abstract class BaseModel<T> {
  Map<String, dynamic> toMap();
  T fromJson(Map<String, dynamic> map);
}
