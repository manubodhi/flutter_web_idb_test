import 'dart:convert';

import 'package:flutter_web_test/src/services/api_service.dart';
import 'package:flutter_web_test/src/utils/constants.dart';

class Brewery {
  int id;
  String name;
  String breweryType;
  String street;
  String city;
  String state;
  String postalCode;
  String country;
  String longitude;
  String latitude;
  String phone;
  String websiteUrl;
  String updatedAt;

  Brewery(
      {this.id,
      this.name,
      this.breweryType,
      this.street,
      this.city,
      this.state,
      this.postalCode,
      this.country,
      this.longitude,
      this.latitude,
      this.phone,
      this.websiteUrl,
      this.updatedAt});

  factory Brewery.fromJson(Map<String, dynamic> json) {
    return Brewery(
      id: json['id'],
      name: json['name'],
      breweryType: json['brewery_type'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      phone: json['phone'],
      websiteUrl: json['website_url'],
      updatedAt: json['updated_at'],
    );
  }

  Brewery.fromMap(Map map, this.id) {
    name = map["name"];
    breweryType = map["breweryType"];
    street = map["street"];
    city = map["city"];
    state = map["state"];
    postalCode = map["postalCode"];
    country = map["country"];
    longitude = map["longitude"];
    latitude = map["latitude"];
    phone = map["phone"];
    websiteUrl = map["websiteUrl"];
    updatedAt = map["updatedAt"];
  }

  Map<String, String> toMap() {
    var map = <String, String>{
      "name": name,
      "breweryType": breweryType,
      "street": street,
      "city": city,
      "state": state,
      "postalCode": postalCode,
      "country": country,
      "longitude": longitude,
      "latitude": latitude,
      "phone": phone,
      "websiteUrl": websiteUrl,
      "updatedAt": updatedAt,
    };
    return map;
  }

  static ApiData<List<Brewery>> get all {

    return ApiData(
      url: Constants.GET_ALL_BREWERY,
      parse: (response){
        final result = json.decode(response.body);
        Iterable list = result;
        return list.map((model) => Brewery.fromJson(model)).toList();
      }
    );
    
  }

}
