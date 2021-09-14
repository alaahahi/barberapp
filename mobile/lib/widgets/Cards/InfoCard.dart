import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/models/CompanyModel.dart';
import 'package:coupons/screens/Company/company.dart';
import 'package:coupons/services/likes.dart';
import 'package:coupons/widgets/Cards/CardTags.dart';
import 'package:coupons/widgets/Cards/LikeButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class InfoCard extends StatelessWidget {
  final CompanyModel company;

  final double width;
  final double height;
  final bool vertical;

  // final GestureTapCallback onTap;

  InfoCard({
    @required this.company,
    this.width,
    this.height,
    // this.onTap,
    this.vertical = true,
  });

  double getWidth(BuildContext context) {
    return width ??
        (vertical ? MediaQuery.of(context).size.width * 0.5 : double.infinity);
  }

  double getHeight(BuildContext context) {
    return height ?? (vertical ? 220 : 250);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNewScreen(context, screen: CompanyPage(company: company));
      },
      child: Container(
        padding: EdgeInsets.only(right: 5, left: 5),
        width: getWidth(context),
        height: getHeight(context),
        child: Card(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          child: Stack(
            children: <Widget>[
              renderContent(context),
              Positioned(
                top: vertical ? 0 : null,
                bottom: vertical ? null : 0,
                right: EasyLocalization.of(context).locale.languageCode == 'en'
                    ? 0
                    : null,
                left: EasyLocalization.of(context).locale.languageCode == 'en'
                    ? null
                    : 0,
                child: LikeButton<CompanyLikeService>(id: company.id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderContent(BuildContext context) {
    if (vertical)
      return Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Stack(
              children: [
                Container(height: 120, child: renderImage()),
                if (company.category != null && company.category.isNotEmpty)
                  CardTags(title: company.category, color: Colors.orange),
                SizedBox(width: 5.0),
                Container(
                  padding: EdgeInsets.all(12),
                  width: 90,
                /*  child: CardTags(
                    title: company.isOpen ? 'open'.tr() : 'closed'.tr(),
                    color: company.isOpen ? Colors.green : Colors.red,
               ),
               */    ),
                company.ratting == null
                    ? Container()
                    : Padding(
                        padding:
                            const EdgeInsets.only(right: 15, left: 15, top: 35),
                        child: Expanded(
                          child: Row(
                            children: [
                              Text(
                                "${(company.ratting).toString().characters.take(3)}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Align(
                                child: RatingBar.builder(
                                  // تقييم النجوم
                                  initialRating: 1,
                                  itemSize: 25,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 1,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                alignment: Alignment.centerRight,
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      company.title,
                      maxLines: vertical ? 1 : 2,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  company.desc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
//                    textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,//Center Row contents vertically,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: company.logo,
                            width: 45,
                            height: 45,
                            fit: BoxFit.fill,
                            errorWidget: (_, __, ____) => renderErrorImage(),
                          ),
                        ),
                      ],
                    ),
                    Column(//Center Column contents horizontally,
                      children: [
                        Center(
                          child:
                              Row(
                                children: [
                                  Text(
                                    '${(company.openMins).toString().characters.take(5)} M',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(child: Text(""),),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          flex: 4,
          child: Stack(
            children: [
              Container(height: getHeight(context), child: renderImage()),
              if (company.category != null && company.category.isNotEmpty)
                CardTags(title: company.category, color: Colors.orange),
    /*
              SizedBox(width: 5.0),
              Container(
                padding: EdgeInsets.all(12),
                width: 90,
                height: 50,
           child: CardTags(
                  title: company.isOpen ? 'open'.tr() : 'closed'.tr(),
                  color: company.isOpen ? Colors.green : Colors.red,
                ),
              ),*/
              company.ratting == null
                  ? Container(child: Text(""),)
                  : Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 80),
                      child: Row(
                          children: [
                            Text(
                              "${(company.ratting).toString().characters.take(3)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Align(
                              child: RatingBar.builder(
                                // تقييم النجوم
                                initialRating: 1,
                                itemSize: 25,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 1,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ],
                        ),
                      ),
            ],
          ),
        ),

/*
        Flexible(
          flex: 3,
          child: renderText(context),
        ),
    */
      ],
    );
  }




  Widget renderText(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Row(
        children: <Widget>[

          SizedBox(
            height: 10,
          ),
          CachedNetworkImage(
            imageUrl: company.logo,
            width: 50,
            height: 50,
            fit: BoxFit.fill,
            errorWidget: (_, __, ____) => renderErrorImage(),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text(
                      company.title,
                      textAlign: TextAlign.left,
                      maxLines: vertical ? 1 : 2,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
               /* Text(
                  company.desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
               ), */
                Row(
                  children: [
                    Text(
                      '${(company.openMins).toString()} M',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),
                  /*  Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          "||",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                          ),
                        )
                ),*/
                 /*   Text(
                      '${(company.closeMinute / 60).toString().characters.take(5)} PM',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CachedNetworkImage renderImage() {
    if (company.photo == null || company.photo.isEmpty)
      return renderErrorImage();
    return CachedNetworkImage(
      imageUrl: company.photo,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorWidget: (_, __, ____) => renderErrorImage(),
    );
  }

  CachedNetworkImage renderErrorImage() {
    return CachedNetworkImage(
      imageUrl: 'NoImagePlaceHolder'.tr(),
      fit: BoxFit.cover,
    );
  }
}
