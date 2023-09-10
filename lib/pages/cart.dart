import 'package:untitled/customer.dart';
import 'package:untitled/pages/Sharedsession.dart';
import 'package:untitled/pages/listitems.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/fetchdata.dart';
import 'package:untitled/pages/wish_list.dart';
import 'package:untitled/pages/credit.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';
import 'package:untitled/constants/constants.dart';
import 'package:path/path.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product1.dart';

var sessionManager = SessionManager();
fetchdata fetch=new fetchdata();

late  List<Product1> myList1=[];

join1( String a,String b) async {
  final prefs1 = await SharedPreferences.getInstance();
  String n=prefs1.get("namename").toString() ;

  try {
    http.Response res = await http.get(
        Uri.parse(fetchdata.apiUrl+'reglist?username=' +
            n +
            '&&listname=' +
            a+
            '&&price='+b),
        headers: {'Content-Type': 'application/json'});
    print("register");} catch (e) {
    print("no register");
  }
}

updateinfo( String a,String b) async {
  await fetch.updateinfolist(a,b);

}
sendemail( String list) async {
  await fetch.sendemail(list);
}
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Cart> {



  deleteitems(String listname) async {

    final prefs = await SharedPreferences.getInstance();

    String A=prefs.get("namename").toString() ;

    try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'deletelistitems?listName=' +
              listname +
              '&&userName=' +
              A
          ),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("no filld");
    } }
  delete(String listname) async {
    await fetch.deletelist(listname);
  }

  List<Widget> itemsData = [];
  void getPostsData() async{


    List<Widget> listItems = [];
    myList1= await fetch.wish1();
    myList1.forEach((post) {
      listItems.add(Container(
          height: 190,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.productName,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.marketName,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      post.manufacturing,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  post.quantity == 1 ? print('counter at 1') : post.quantity--;
                                  Customer customer = Customer();
                                  var result = await customer.updateProductQuantity(post.id.toString(), post.quantity.toString());
                                  getPostsData();
                                },
                                child: Icon(Icons.remove)),
                            Text('${post.quantity}'),
                            GestureDetector(
                                onTap: () async {
                                  post.quantity++;
                                  Customer customer = Customer();
                                  var result = await customer.updateProductQuantity(post.id.toString(), post.quantity.toString());
                                  getPostsData();
                                  print('set');
                                },
                                child: Icon(Icons.add)),

                          ],
                        ),),
                    ),
                    Text(
                      "${post.price} \$",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[  ElevatedButton(
                          child: Text('delete'),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 221, 161, 71),
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () async{
                            Customer customer = Customer();
                            var result = await customer.deleteProductFromCart(post.id.toString());
                            getPostsData();
                          },
                        ),

                        ])


                  ],
                ),
                Expanded(
                  child: Image.asset('assets/images/'+post.image,width: 140,height: 160,),
                ),

                // Image.asset(
                //   "assets/images/${post.imageUrl}.png",
                //   height: double.infinity,
                // )
              ],
            ),
          ))
      );
    });
    setState(() {
      itemsData = listItems;
    });
  }

  TextEditingController controllerText1=TextEditingController();
  TextEditingController controllerText2=TextEditingController();
  TextEditingController controllerText11=TextEditingController();
  TextEditingController controllerText22=TextEditingController();

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;


  @override
  void dispose() {
    controllerText1.dispose();
    controllerText2.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 125;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 30;
      });
    });
  }


  String dialogeValue = '';




  void openDialogepay(String s1){
    Future openDialoge2() => showDialog(
        context: this.context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 209, 224, 199),
          title: Text('which way u want :'),
          //content: Text('ADD ITEMS USING :'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 221, 161, 71),
              ),
              onPressed: ()async {

                sendemail(s1);
                Navigator.of(context).pop();
              },
              child: Text("Cash"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 221, 161, 71),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MySample();
                }));
              },
              child: Text("credit card"),
            ),
          ],
        ));
    openDialoge2();
  }



  void openDialoge1(String s1, String s2){
    Future openDialoge2() => showDialog(
        context: this.context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 209, 224, 199),
          title: Text('hi in this list u can :'),
          //content: Text('ADD ITEMS USING :'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 221, 161, 71),
              ),
              onPressed: ()async {

                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return WishList();
                }));
              },
              child: Text("Add Items"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 221, 161, 71),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return listitems();
                }));
              },
              child: Text("show items"),
            ),
          ],
        ));
    openDialoge2();
  }
  Future openDialoge() => showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 209, 224, 199),
        title: Text('New List'),
        content: Container(
            height: 115,
            child: Column(
              children: [
                TextField(
                  autocorrect: true,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  decoration:
                  InputDecoration(hintText: 'Enter The List Name'),
                  controller: controllerText1,
                ),
                TextField(
                  autocorrect: true,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  decoration:
                  InputDecoration(hintText: 'Enter The Total Price'),
                  controller: controllerText2,
                ),
              ],
            )),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 221, 161, 71),
            ),
            onPressed: () {
              join1(controllerText1.text , controllerText2.text);
              Navigator.of(context)
                  .pop(controllerText1.text + "-" + controllerText2.text);


              getPostsData();

            },
            child: Text("Create"),
          ),
        ],
      ));

  Future openDialogeupdate() => showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 209, 224, 199),
        title: Text('New List'),
        content: Container(
            height: 115,
            child: Column(
              children: [
                TextField(
                  autocorrect: true,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  decoration:
                  InputDecoration(hintText: 'Enter The New Name'),
                  controller: controllerText11,
                ),
                TextField(
                  autocorrect: true,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  decoration:
                  InputDecoration(hintText: 'Enter The Total Price'),
                  controller: controllerText22,
                ),
              ],
            )),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 221, 161, 71),
            ),
            onPressed: () {
              updateinfo(controllerText11.text , controllerText22.text);
              getPostsData();
            },
            child: Text("update"),
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {



    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Your Lists'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 12,
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Align(
                            heightFactor: 1,
                            alignment: Alignment.topCenter,
                            child: itemsData[index]);
                      })
              ),
              Center(
                child: ElevatedButton.icon(
                    onPressed: () async {
                      Customer customer = Customer();
                      openDialogepay(customer.email);
                      var result = await customer.deleteAllProductsInCart();
                      if(result['status'] == 'success'){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Checkout Successfully!!'),)
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(result['status'].toString()) ),
                        );
                      }
                      getPostsData();qw:w:we
                    },
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text('Checkout')),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }


}