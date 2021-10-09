import 'dart:ffi';

import 'package:barber/data/api.dart';
import 'package:barber/models/OrderModel.dart';

import 'package:barber/widgets/Layouts/StyledAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:provider/provider.dart';

class feedback extends StatefulWidget {
  final OrderModel order;
  final Void statecood;

  const feedback({Key key, this.order, this.statecood}) : super(key: key);

  @override
  _feedbackState createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  double rang = 0;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(title: 'Feedback'.tr()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(right: 12, left: 12, bottom: 5, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: textbuld(widget.order.title_company.toString(),
                        Colors.black, 18, FontWeight.w600),
                  ),
                  textbuld(
                      DateFormat('yyyy-MM-dd   kk:mm')
                          .format(widget.order.createdAt),
                      Colors.grey,
                      14,
                      FontWeight.w500),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    "invoice number :".tr(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${widget.order.id + 100000}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RatingBar.builder(
              // تقييم النجوم
              initialRating: rang,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                rang = rating;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: textController,
                maxLength: 500,
                keyboardType: TextInputType.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .apply(fontSizeDelta: 1),
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  // icon:  Icon(Icons.attach_money),

                  hintText: "Describe your experience(optional)".tr(),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 16,
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      "Back".tr(),
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                    )),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (textController.text == "") {
                      Navigator.of(context).pop();
                      final res = await context.read<Api>().sendUser(
                          id: widget.order.id.toString(),
                          evaluation: rang,
                          messag: "nullText");
                     // Fluttertoast.showToast(msg: res.toString());
                    }
                    Navigator.of(context).pop();
                    final res = await context.read<Api>().sendUser(
                        id: widget.order.id.toString(),
                        evaluation: rang,
                        messag: textController.text);
                   // Fluttertoast.showToast(msg: res.toString());
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 16,
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      "Send Feedback".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
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
