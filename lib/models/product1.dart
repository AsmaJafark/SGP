enum Shade { orange, green }

class Product1 {
  final int id;
  final String marketName;
  final String productName;
 
  final int price;
   late int  quantity;
  final String manufacturing;
  final String image;
  // final int productNumber;

  final String? description;
  final bool inCart;
  final Shade shade;
  
factory Product1.fromJson(Map<String,dynamic> json) => Product1(
    id: int.parse(json['id'].toString()),
    marketName: json['marketName']  == null ? '' : json['marketName']as String,
    productName: json['productName']  == null ? '' : json['productName']as String,
    quantity: json['quantity'].toString()  == null ? 0 : int.parse(json['quantity'].toString()),
    price: json['price'].toString() == null ? 0 : int.parse(json['price'].toString()),
    manufacturing: json['manufacturing']  == null ? '' : json['manufacturing']as String,
    image: json['image']  == null ? '' : json['image']as String,
    // productNumber: json['productNumber']   == null ? 0 : json['productNumber'] as int,
  );
  
  Product1({
    required this.marketName,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.manufacturing,
    required this.image,
    // required this.productNumber,
    this.description,
    this.inCart = false,
    this.shade = Shade.green,
    required int this.id
  });

  



 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['marketName'] = this.marketName;
     data['productName'] = this.productName;
     data['quantity'] = this.quantity;
    data['price'] = this.price;

data['manufacturing'] = this.manufacturing;
    data['image'] = this.image;
    // data['productNumber'] = this.productNumber;

    return data;
  }

}
