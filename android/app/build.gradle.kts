import java.util.Base64

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

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
