import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/models/OrderModel.dart';
import 'package:flutter/material.dart';

class productCart extends StatelessWidget {
  const productCart({
    Key key,
    this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
      elevation: 10,
      child: Container(
//        height: MediaQuery.of(context).size.height / 4.4,
          margin: EdgeInsets.all(1),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: product.photo,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: textbuld(product.titleTranslation, Colors.black, 16,
                          FontWeight.w500),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textbuld(' price :', Colors.grey, 16, FontWeight.w500),
                      SizedBox(
                        width: 5,
                      ),
                      textbuld(product.pivot.quantity.toString()+" X", Colors.black, 16, FontWeight.w500),
                      SizedBox(
                        width: 5,
                      ),
                      Center(
                        child: textbuld(product.discountPrice.toString(), Colors.black, 16,
                            FontWeight.w500),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget textbuld(String text, var color, double size, var fontWeight) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}
