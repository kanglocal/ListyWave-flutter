/// dio 응답 body 를 모델 생성자에 넘기기 위한 변환. backend 는 항상 JSON 을 준다.
Map<String, dynamic> asJsonMap(Object? data) => data! as Map<String, dynamic>;

List<T> asJsonList<T>(
  Object? data,
  T Function(Map<String, dynamic> json) fromJson,
) => (data! as List<dynamic>)
    .map((e) => fromJson(e as Map<String, dynamic>))
    .toList();
