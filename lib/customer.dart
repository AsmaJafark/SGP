import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Customer  {

  Customer._privateConstructor();
  static final Customer _instance  = Customer._privateConstructor();
  static const String serverURL = "https://womenstore112.000webhostapp.com/";
  
  String id = '';
  String name = '';
  String email = '';
  String password = '';
  String place = '';
  String phone = '';

  factory Customer() {
    return _instance ;
  }

  Future <dynamic> loginToBackend(String email, String password) async {
    Response response = await post(Uri.parse("${serverURL}singin.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode({'email': email, 'password': password}));

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      debugPrint("Success: ${jsonResponse['message']}");
      this.id = jsonResponse['message']['id'].toString();
      this.name = jsonResponse['message']['name'];
      this.email = jsonResponse['message']['email'];
      this.place = jsonResponse['message']['place'];
      this.password = jsonResponse['message']['password'];
    }

    return jsonResponse;
  }
  
  Future <dynamic> signupToBackend(String name, String password, String email, String place, String phone) async {
    Response response = await post( Uri.parse("${serverURL}singup.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'name': name, 'email': email,  'place': place, 'password': password, 'phone': phone })
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      this.id = jsonResponse['message']['id'].toString();
      this.name = jsonResponse['message']['name'];
      this.email = jsonResponse['message']['email'];
      this.place = jsonResponse['message']['place'];
      this.phone = jsonResponse['message']['phone'];
      this.password = jsonResponse['message']['password'];
    }

    return jsonResponse;
  }

  Future <dynamic> getAllProducts() async {
    Response response = await post( Uri.parse("${serverURL}all_products.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> addProductToCart(String productId) async {
    Response response = await post( Uri.parse("${serverURL}add_product_to_cart.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'product_id': productId, 'user_id': this.id, 'quantity': 1})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> getUserCartProducts() async {
    Response response = await post( Uri.parse("${serverURL}user_cart_products.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'user_id': this.id})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> updateProductQuantity(String productId, String quantity) async {
    Response response = await post( Uri.parse("${serverURL}update_product_quantity.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'product_id': productId, 'user_id': this.id, 'quantity': quantity})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> deleteProductFromCart(String productId) async {
    Response response = await post( Uri.parse("${serverURL}delete_product_from_cart.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'product_id': productId, 'user_id': this.id,})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> deleteAllProductsInCart() async {
    Response response = await post( Uri.parse("${serverURL}delete_all_products_from_cart.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'user_id': this.id,})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }

  Future <dynamic> updateName(String name) async {
    Response response = await post( Uri.parse("${serverURL}update_name.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'name': name, 'email': email})
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      this.name = name;
    }
    return jsonResponse;
  }
  Future <dynamic> updatePassword(String password) async {
    Response response = await post( Uri.parse("${serverURL}update_password.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'password': password, 'email': email})
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      this.password = password;
    }
    return jsonResponse;
  }

  Future <dynamic> addHotel(String name, String price, String location, String about, String place) async {
    Response response = await post( Uri.parse("${serverURL}add_hotel.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'user_id': id, 'name': name, 'price': price, 'location': location, 'about': about, 'place': place})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> addCity(String name, String location, String about, String place) async {
    Response response = await post( Uri.parse("${serverURL}add_city.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'user_id': id, 'name': name, 'location': location, 'about': about, 'place': place})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> addTimeline(String title, String body, String place) async {
    Response response = await post( Uri.parse("${serverURL}add_timeline.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'user_id': id, 'title': title, 'body': body, 'place': place})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }

  Future <dynamic> getCreatedHotels() async {
    Response response = await post( Uri.parse("${serverURL}user_hotels.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'id': id})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getCreatedCities() async {
    Response response = await post( Uri.parse("${serverURL}user_cities.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'id': id})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getCreatedTimelines() async {
    Response response = await post( Uri.parse("${serverURL}user_timelines.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'id': id})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  Future <dynamic> getAllHotels() async {
    Response response = await post( Uri.parse("${serverURL}all_hotels.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getAllCities() async {
    Response response = await post( Uri.parse("${serverURL}all_cities.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getAllTimelines() async {
    Response response = await post( Uri.parse("${serverURL}all_timelines.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  Future <dynamic> addHotelReview(String hotelId, String review) async {
    Response response = await post( Uri.parse("${serverURL}add_review.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'hotel_id': hotelId, "city_id": null, "timeline_id": null, 'user_id': this.id, 'review': review})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> addCityReview(String cityId, String review) async {
    Response response = await post( Uri.parse("${serverURL}add_review.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'city_id': cityId, 'hotel_id': null, "timeline_id": null, 'user_id': this.id, 'review': review})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> addTimelineReview(String timelineId, String review) async {
    Response response = await post( Uri.parse("${serverURL}add_review.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'timeline_id': timelineId,'hotel_id': null, "city_id": null, 'user_id': this.id, 'review': review})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }

  Future <dynamic> addHotelLike(String hotelId, double like) async {
    Response response = await post( Uri.parse("${serverURL}add_like.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'hotel_id': hotelId, "city_id": null, "timeline_id": null, 'user_id': this.id, 'like': like.toString()})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> addCityLike(String cityId, double like) async {
    Response response = await post( Uri.parse("${serverURL}add_like.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'city_id': cityId, 'hotel_id': null, "timeline_id": null, 'user_id': this.id, 'like': like.toString()})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> addTimelineLike(String timelineId, double like) async {
    Response response = await post( Uri.parse("${serverURL}add_like.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'timeline_id': timelineId, 'hotel_id': null, "city_id": null, 'user_id': this.id, 'like': like.toString()})
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }

  Future <dynamic> getHotelReviews(String hotelId) async {
    Response response = await post( Uri.parse("${serverURL}hotel_reviews.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'hotel_id': hotelId})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getCityReviews(String cityId) async {
    Response response = await post( Uri.parse("${serverURL}city_reviews.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'city_id': cityId})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getTimelineReviews(String timelineId) async {
    Response response = await post( Uri.parse("${serverURL}timeline_reviews.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'timeline_id': timelineId})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  Future <dynamic> deleteHotel(String hotelId) async {
    Response response = await post( Uri.parse("${serverURL}delete_location.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'hotel_id': hotelId, "city_id": null, "timeline_id": null, })
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> deleteCity(String cityId) async {
    Response response = await post( Uri.parse("${serverURL}delete_location.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'hotel_id': null, "city_id": cityId, "timeline_id": null, })
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }
  Future <dynamic> deleteTimeline(String timelineId) async {
    Response response = await post( Uri.parse("${serverURL}delete_location.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'hotel_id': null, "city_id": null, "timeline_id": timelineId, })
    );
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;
  }

  Future <dynamic> getBroadcasters() async {
    Response response = await post( Uri.parse("${serverURL}broadcasters.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  Future <dynamic> updateBroadcastingState(String isBroadcasting) async {
    Response response = await post( Uri.parse("${serverURL}update_is_broadcasting.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'id': id, 'is_broadcasting' : isBroadcasting})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
}

class NotificationMessage {
  String title = '';
  String body = '';
  dynamic payload;

  NotificationMessage(this.title, this.body, this.payload);
}