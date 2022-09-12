import 'package:denemefirebaseauth/models/base_model.dart';

class HomePageModel extends BaseModel {
  int? placeId;
  String? name;
  int? type;
  int? stars;
  String? price;
  String? city;
  String? image;
  String? body;

  HomePageModel(
      {this.placeId,
      this.name,
      this.type,
      this.stars,
      this.price,
      this.city,
      this.image,
      this.body});

  @override
  fromJson(Map<String, dynamic> map) => HomePageModel(
        placeId: map['placeId'],
        name: map['name'],
        type: map['type'],
        stars: map['stars'],
        price: map['price'],
        city: map['city'],
        image: map['image'],
        body: map['body'],
      );

  @override
  Map<String, dynamic> toMap() => {
        'placeId': placeId,
        'name': name,
        'type': type,
        'stars': stars,
        'price': price,
        'city': city,
        'image': image,
        'body': body,
      };
}
