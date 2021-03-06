
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:ecomapp/globals/global.dart';
import 'package:ecomapp/product/merchant.dart';
import 'package:ecomapp/product/model.dart';
import 'package:ecomapp/themedata/image_card.dart';
import 'package:flutter/material.dart';
import 'package:ecomapp/globals/global.dart' as gb;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
 
import 'package:ecomapp/themedata/Theme.dart' as theme;
 
 
 class ProductDetailPage extends StatefulWidget{
  
   @required Product product;
   ProductDetailPage({this.product}){
     productGlobal=new Product(inventoryId:product.inventoryId,
     productId:product.productId,
     productRating: product.productRating,
     name:product.name ,
     avatar:product.avatar,
     description:product.description ,
     features: product.features,
     cost: product.cost,
     merchantRating: product.merchantRating,
     quantityLeftMerchant: product.quantityLeftMerchant,
     imageURLList: product.imageURLList,
     merchantId: product.merchantId,
     merchantName: product.merchantName);
 
     print(productGlobal.toString() + "hiiiiii");
   }
   
   @override
   ProductState createState() => new ProductState();
 }
 
 class ProductState extends State<ProductDetailPage>{
 
var myInt,qInt;
  final quantityController=TextEditingController();
   final Product product=productGlobal;
  var itemSelect;
  List<String> costA;
  Widget _buildContent(){
    print("Build Content");
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          _buildImageScroller(),
        ],
      ),
    );
  }
 
  Widget _buildAvatar(){
    print("Building avatar");
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white30),
      ),
      margin: const EdgeInsets.only(top: 32.0,left: 16.0),
      padding: const EdgeInsets.all(3.0),
      child: ClipOval(
        child: Image.network(productGlobal.avatar),
      ),
    );
  }
 
  Widget _buildInfo(){
    print("build info");
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right:16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            productGlobal.name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          new Row(
              children: <Widget>[
          new Icon(Icons.star, size: 14.0,
                  color: Colors.black),
                  new Text(
                  productGlobal.productRating.toString(),
            style:TextStyle(
              color:Colors.black.withOpacity(0.85),
              fontWeight: FontWeight.w500,
            ),
            ),
              ]
          ),
          Container(
            color: Colors.black.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            width: 225.0,
            height: 1.0,
          ),
 
          Text(
            "Description:\n"+productGlobal.description+"\nFeatures:\n"+productGlobal.features,
            style: TextStyle(
              color: Colors.black.withOpacity(0.85),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildImageScroller(){
    print("build Im");
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox.fromSize(
        size: Size.fromHeight(245.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          itemCount: productGlobal.imageURLList.length,
          itemBuilder: (BuildContext context,int index){
            var image=productGlobal.imageURLList[index];
            return ImageCard(image);
          },
        ),
      ),
    );
  }
Future<String> getData() async {
  if(costA!=null)
{
  myInt = int.parse(costA[2]);
assert(myInt is int);
qInt = int.parse(quantityController.text);
assert(qInt is int);
}
if(costA==null){
  Fluttertoast.instance.showToast(
        msg: "Select a merchant",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white
    );
  return null;
}
else if(qInt>myInt){
  Fluttertoast.instance.showToast(
        msg: "Maximum quantity "+myInt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white
    );
    return null;
}
else{
 
Map map={"token" : gb.token,
  "product" : {
    "inventoryId": productGlobal.inventoryId,
    "productId": productGlobal.productId,
    "productName": productGlobal.name,
    "imageSrc": productGlobal.avatar,
    "productRating": productGlobal.productRating,
    "quantity": productGlobal.quantityLeftMerchant,
    "price": productGlobal.cost,
  }
};
 
 
http.Response response = await http.post(gb.addToCartURL+gb.token,
headers: {
  "Content-Type":"application/json"
},
body: utf8.encode(json.encode(map)),
 
);
 
var jsonData=json.decode(response.body);
 
if(jsonData['status']=="SUCCESS")
{
  Fluttertoast.instance.showToast(
        msg: "Successfully added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white
    );
    
 
}
else{
  Fluttertoast.instance.showToast(
        msg: "Login Failed"  +jsonData['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
 
 
} 
  }}
 
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
    home:Scaffold(
      backgroundColor: theme.Colors.productPageBackground,
    resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildContent()
        ],
        
      ),
      bottomNavigationBar: BottomAppBar(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new RaisedButton(
                  color: Colors.teal,
                  textColor: Colors.white,
                  child: new Text("Select merchant"),
                  onPressed: (){
                    if(session.emailId!=null){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Merchant();
                    }));
                    }
                    else{
                      Fluttertoast.instance.showToast(
        msg: "Login is required",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white
    );
                    }
                  
                  },
                  splashColor: Colors.redAccent,
                ),
         
        ],
      ),
     ),
    )
    );
  }
}