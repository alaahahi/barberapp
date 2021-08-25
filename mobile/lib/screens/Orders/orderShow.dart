import 'package:coupons/models/OrderModel.dart';
import 'package:coupons/widgets/Layouts/StyledAppBar.dart';

import 'package:flutter/material.dart';

import 'package:coupons/screens/Orders/productCart.dart';
import 'package:easy_localization/easy_localization.dart';

class orderShow extends StatelessWidget {
  final OrderModel order;

  const orderShow({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(title: 'Order Details'.tr()),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: textbuld('Order'.tr()+':'+'${order.id + 100000}', Colors.black, 18,
                    FontWeight.bold),
              ),

              Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 50,
                  child: textbuld(DateFormat('yyyy-MM-dd   kk:mm').format(order.createdAt) , Colors.grey, 16,
                      FontWeight.w500))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: [
                textbuld(order.product.length.toString(), Colors.black, 16,
                    FontWeight.w500),
                textbuld(' Items'.tr(), Colors.grey, 16, FontWeight.w500),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.5,
            child: ListView(
              padding: EdgeInsets.only(bottom: 200),
              children: order.product
                  .map((e) => productCart(
                        product: e,
                      ))
                  .toList(),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              child: textbuld("total Amount ".tr(),
                  Colors.grey.shade500, 16, FontWeight.w600),
            ),
          ),
          Center(
            child: Container(
              child: textbuld("${order.orderTotal.toString()}",
                  Colors.black, 18, FontWeight.bold),
              width: MediaQuery.of(context).size.width / 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget textbuld(String text, var color, double size, var fontWeight) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}
