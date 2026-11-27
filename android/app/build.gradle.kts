import java.io.FileInputStream
import java.net.URI
import java.util.Base64
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// `--dart-define-from-file=env/<flavor>.json` 값은 Flutter tool 이 `dart-defines` 속성
// (base64, 쉼표 구분) 으로 넘긴다. 카카오 네이티브 앱 키를 manifest 에 쓰기 위해 읽는다 (PLAN §12).
val dartDefines: Map<String, String> =
    (project.findProperty("dart-defines") as String?)
        ?.split(",")
        ?.mapNotNull { encoded ->
            val decoded = String(Base64.getDecoder().decode(encoded))
            val separator = decoded.indexOf('=')
            if (separator <= 0) null else decoded.substring(0, separator) to decoded.substring(separator + 1)
        }
        ?.toMap()
        ?: emptyMap()
val kakaoNativeAppKey = dartDefines["KAKAO_NATIVE_APP_KEY"].orEmpty()

// App Links host (PLAN §2.1). env/<flavor>.json 의 SITE_URL 에서 host 만 꺼낸다.
// 값이 없으면 (dart-define 없이 gradle 만 돌린 경우) 아무 링크와도 맞지 않는 host 로 둔다.
val appLinkHost: String =
    dartDefines["SITE_URL"]
        ?.let { runCatching { URI(it).host }.getOrNull() }
        ?.takeIf { it.isNotEmpty() }
        ?: "listywave-unset.invalid"

// release 서명 (PLAN §7 M6, README "출시 서명"). android/key.properties 와 keystore(*.jks) 는 git 에서
// 제외된다. 파일이 없으면 (CI, 다른 개발자) debug key 로 서명해 release 빌드가 계속 돌게 한다.
// 이렇게 만든 파일은 스토어에 올릴 수 없다.
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties =
    Properties().apply {
        if (keystorePropertiesFile.exists()) {
            FileInputStream(keystorePropertiesFile).use { load(it) }
        }
    }
val hasReleaseKeystore = keystorePropertiesFile.exists()

android {
    namespace = "com.listywave.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.listywave.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // 카카오톡 공유 메시지에서 앱으로 돌아오는 scheme (`kakao{NATIVE_APP_KEY}://kakaolink`).
        // 키가 없으면 (로컬 dev) 다른 앱과 겹치지 않는 값으로 둔다. 출시 전 env/prod.json 에 키를 넣는다.
        manifestPlaceholders["kakaoScheme"] =
            if (kakaoNativeAppKey.isEmpty()) "listywave-kakao-unset" else "kakao$kakaoNativeAppKey"
        manifestPlaceholders["appLinkHost"] = appLinkHost
    }

    // dev/prod 를 한 기기에 같이 설치할 수 있게 dev 에 ".dev" suffix 를 붙인다 (PLAN §5.4).
    flavorDimensions += "env"
    productFlavors {
        create("dev") {
            dimension = "env"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "ListyWave Dev")
        }
        create("prod") {
            dimension = "env"
            resValue("string", "app_name", "ListyWave")
        }
    }

    signingConfigs {
        if (hasReleaseKeystore) {
            create("release") {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig =
                if (hasReleaseKeystore) {
                    signingConfigs.getByName("release")
                } else {
                    logger.warn("android/key.properties 가 없어 release 빌드를 debug key 로 서명한다 (스토어 업로드 불가).")
                    signingConfigs.getByName("debug")
                }
        }
    }
}

flutter {
    source = "../.."
}
