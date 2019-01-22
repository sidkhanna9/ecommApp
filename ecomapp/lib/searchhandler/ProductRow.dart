import 'dart:convert';
import 'package:ecomapp/globals/global.dart' as gb;
import 'package:ecomapp/product/model.dart';
import 'package:ecomapp/searchhandler/MiniProduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecomapp/themedata/Theme.dart' as theme;

class ProductRow extends StatelessWidget{
  MiniProduct mini;
    ProductRow({this.mini});
    Product arg;
 
  @override
  Widget build(BuildContext context) {
    final productThumbnail=new Container(

alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 24.0),
      child: new Hero(
        tag: 'product-icon-${mini.productId}',
        child: ClipRRect( 
          borderRadius: new BorderRadius.circular(10.0),
          child:Image.network(
            
          mini.imageUrl,
          height: theme.Dimens.productHeight,
          width: theme.Dimens.productWidth,
        
        fit: BoxFit.fitHeight
        )
        ),
      ),
    );
  
  

final productCard = new Container(
      margin: const EdgeInsets.only(left: 72.0, right: 24.0),
      decoration: new BoxDecoration(
        color: theme.Colors.productCard,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(color: Colors.black,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(mini.productName, style: theme.TextStyles.productTitle),
            new Text(mini.category, style: theme.TextStyles.productCategory),
            new Container(
              color: const Color(0xFF00C6FF),
              width: 24.0,
              height: 1.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0)
            ),
            new Row(
              children: <Widget>[
                new Icon(Icons.star, size: 14.0,
                  color: theme.Colors.productRating),
                new Text(
                  mini.rating.toString(), style: theme.TextStyles.productRating),
                new Container(width: 24.0),
                new Icon(Icons.monetization_on ,size: 14.0,
                  color: theme.Colors.productBestPrice),
                new Text(
                  mini.bestPrice.toString(), style: theme.TextStyles.productBestPrice),
              ],
            )
          ],
        ),
      ),
    );

    return new Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
       onPressed: (){
        gb.productId= mini.productId;
        getdata();
       },
        
        child: new Stack(
          children: <Widget>[
            productCard,
            productThumbnail,
          ],
        ),
      ),
    );
  }



Future<String> getdata() async{
http.Response response= await http.get(Uri.encodeFull(gb.productFetchUrl),headers: gb.getHeader);
var jsonData=json.decode(response.body);
gb.product.id=jsonData[''];
gb.product.images=jsonData[''];
gb.product.name=jsonData['productName'];
gb.product.description=jsonData['description'];
gb.product.features=jsonData['keyFeatures'];
gb.product.rating=jsonData['rating'];
gb.product.avatar=jsonData[''];

/*

  Product({
    @required this.id,
    @required this.name,
    @required this.avatar,
    @required this.description,
    @required this.features,
    @required this.rating,
    @required this.images,
  });

 */


}
}

//   Future<Product> _product() async{

// String url="http://10.177.7.88:5000/product/get/"+this.mini.productId;
// http.Response response = await http.get(Uri.encodeFull(url),
// headers: {
//   "Accept":"application/json"
// });

// var jsonData=json.decode(response.body);
// this.arg= Product(name: jsonData['productName'],
//  avatar: jsonData['imageSrc'][0],
//   description: jsonData['description'],
//    images: jsonData['imgSrc'],
//     rating: jsonData['rating'], 
//     features: jsonData['keyFeatures'],
//      id: jsonData['productId'],);
// return arg;

//   }