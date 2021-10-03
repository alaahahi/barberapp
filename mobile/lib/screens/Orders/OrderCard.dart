import 'package:coupons/models/OrderModel.dart';

import 'package:coupons/screens/Orders/orderShow.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:coupons/data/api.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:coupons/screens/Orders/feedback.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    Key key,
    this.order,
  }) : super(key: key);
  final OrderModel order;

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isCard = true;

  @override
  Widget build(BuildContext context) {
    return isCard == true
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
            elevation: 2,
            child: Container(
              margin: EdgeInsets.all(1),
              child: Column(
                children: [
//            ...order
//                .product
//                .map((e) =>
                  Column(
                    children: [
                      SizedBox(
                        height: 11,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: textbuld(widget.order.title_company,
                                  Colors.black, 16, FontWeight.w500),
                              width: MediaQuery.of(context).size.width / 1.8,
                            ),
                            Container(
                              child: textbuld(
                                  DateFormat('yyyy-MM-dd   kk:mm')
                                      .format(widget.order.createdAt),
                                  Colors.grey,
                                  14,
                                  FontWeight.w500),
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.height / 45,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: textbuld("Invoice number :".tr(),
                                  Colors.grey.shade500, 16, FontWeight.w600),
                            ),
                            Container(
                              child: textbuld('${widget.order.id + 100000}',
                                  Colors.black, 16, FontWeight.w500),
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: textbuld("Quantity ".tr(),
                                Colors.grey.shade500, 16, FontWeight.w600),
                          ),
                          textbuld(
                              widget.order.product.length.toString(),
                              Colors.black,
                              //order.pivot.quantity.toString()
                              18,
                              FontWeight.w500),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 7,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: textbuld("total Amount ".tr(),
                                Colors.grey.shade500, 16, FontWeight.w600),
                          ),
                          SizedBox(width: 6),
                          Container(
                            child: textbuld(
                                "${widget.order.orderTotal.toString()}",
                                Colors.black,
                                18,
                                FontWeight.bold),
                            width: MediaQuery.of(context).size.width / 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                pushNewScreen(context,
                                    screen: orderShow(
                                      order: widget.order,
                                    ));
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 14, left: 14, bottom: 8, top: 8),
                                  child: Text(
                                    "Details".tr(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                              ),
                            ),
                            widget.order.isAccepted == 0
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height / 19,
                                    ),
                                  )
                                : widget.order.isAccepted == 1
                                    ? widget.order.serviceRating == 0 ||
                                            widget.order.serviceRating == null
                                        ? InkWell(
                                            onTap: () {
                                              pushNewScreen(context,
                                                  screen: feedback(
                                                    order: widget.order,
                                                  ));
                                            },
                                            child: Container(
                                                padding: const EdgeInsets.only(
                                                    right: 13,
                                                    left: 13,
                                                    bottom: 8,
                                                    top: 8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Text(
                                                  "Feedback".tr(),
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          )
                                        : Container()
                                    : Container(),
                            Container(
                              child: Text(
                                widget.order.isAccepted == 0
                                    ? 'Wating'.tr()
                                    : widget.order.isAccepted == 1
                                        ? 'Compleated'.tr()
                                        : widget.order.isAccepted == 2
                                            ? 'Rejected'.tr()
                                            : 'contact admin',
                                style: TextStyle(
                                    color: widget.order.isAccepted == 0
                                        ? Colors.blue
                                        : widget.order.isAccepted == 1
                                            ? Colors.green
                                            : widget.order.isAccepted == 2
                                                ? Colors.blueGrey
                                                : Colors.blueGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget textbuld(String text, var color, double size, var fontWeight) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }

  CreateAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Text(
                      "are sure of the deleting process",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        color: Colors.blue,
                        child: Text("Yes".tr(),
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
//                          setstatIsCard();
//                          deletsdId();
                          Navigator.of(context).pop();

                          // deletedCompany(order.id);
                        },
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        color: Colors.grey,
                        child: Text(
                          "No".tr(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget buttenCancel(Color color, String text, var fun) {
    return InkWell(
        onTap: fun,
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 45, right: 45),
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50)),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  void deletsdId() {
    if (true) {
        Navigator.of(context, rootNavigator: true).pop();
        context.read<Api>()
            .deletedCompany(widget.order.id.toString());
    }
  }


  void setstatIsCard() {
    setState(() {
      isCard = false;
    });
    print("CLick");
  }
}
