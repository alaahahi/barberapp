import 'package:coupons/data/api.dart';
import 'package:coupons/models/SearchResult.dart';
import 'package:coupons/screens/Other/freeGifts.dart';
import 'package:coupons/screens/Other/weeklyWithdrawals.dart';
import 'package:coupons/screens/Search/RandomCategoryList.dart';
import 'package:coupons/widgets/Cards/InfoCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:coupons/widgets/CarouselBanner.dart';
import 'package:coupons/widgets/common/RowTitle.dart';
import 'package:coupons/widgets/common/OfferList.dart';
import 'package:coupons/screens/Home/profileRow.dart';
import 'package:coupons/screens/Home/ActivationBox.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 60),
          child: Column(
            children: [
              SizedBox(height: 20),

              //ProfileRow(),



              SizedBox(height: 5),
              CarouselBanner(imageUrls: [
                'https://savingapp.co/AdminCp/storage/app/public/homeSlider/slide1.jpeg',
                'https://savingapp.co/AdminCp/storage/app/public/homeSlider/slide2.jpeg',
                'https://savingapp.co/AdminCp/storage/app/public/homeSlider/slide3.jpeg',
                'https://savingapp.co/AdminCp/storage/app/public/homeSlider/slide4.jpeg'
              ], isloading: true),

              SizedBox(height: 10),

              RandomCategoryList(),

              //freeGifts(),

              SizedBox(height: 10),

              FutureBuilder<SearchResult>(
                future: context.read<Api>().getHome(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Column(
                      children: [
                        //RowTitle(title: 'Featured Offers'.tr()),

                        //OfferList(list: snapshot.data.products),
                        // RowTitle(title: 'Trending Restaurants'),
                        // CompanyList(),
                        //weeklyWithdrawals(),

                        //RowTitle(title: 'Featured Companies'.tr()),

                        Column(
                          children: snapshot.data.companies
                              .map((e) => InfoCard(company: e, vertical: false))
                              .toList(),
                        )
                      ],
                    );
                  }
                  return Shimmer.fromColors(
                      baseColor: Colors.grey[100],
                      highlightColor: Colors.grey[200],
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ));
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
