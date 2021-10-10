import 'package:barber/data/api.dart';
import 'package:barber/models/SearchResult.dart';
import 'package:barber/models/SliderModel.dart';
import 'package:barber/screens/Other/freeGifts.dart';
import 'package:barber/screens/Other/weeklyWithdrawals.dart';
import 'package:barber/screens/Search/RandomCategoryList.dart';
import 'package:barber/widgets/Cards/InfoCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:barber/widgets/CarouselBanner.dart';
import 'package:barber/widgets/common/RowTitle.dart';
import 'package:barber/widgets/common/OfferList.dart';
import 'package:barber/screens/Home/ActivationBox.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/line.png"), repeat: ImageRepeat.repeat )),
    child:
    SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 60),
          child:
          Column(
            children: [
              SizedBox(height: 5),

              Row(
                children: [
                  Container(height: 75, width:MediaQuery.of(context).size.width*0.2,    decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color:Color.fromRGBO(236, 194, 0, 0.9),
                  ),
                   child:  IconButton(
                      icon: Icon(
                        Icons.attach_money_outlined,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        size: 50,
                      ),
                      onPressed: () => null,
                  ),
                  ),
                  SizedBox(width:MediaQuery.of(context).size.width*0.1),
                  Container(height: 75, width:MediaQuery.of(context).size.width*0.4,    decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color:Color.fromRGBO(236, 194, 0, 0),
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo-M.png"), )
                  ),
                  ),
                                    Container(height: 75, width:MediaQuery.of(context).size.width*0.3,    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color:Color.fromRGBO(236, 194, 0, 0),
                  ),
                    child:  Center(child: Text('MODERN MAN', style: TextStyle(color: Color.fromRGBO(236, 194, 0, 0.9),fontSize: 30),)),
                  ),

                ],
              ),


              SizedBox(height: 5),
                  FutureBuilder(
                  future: context.read<Api>().getSlider(),
                  builder: (context, AsyncSnapshot<List<SliderModel>> snapshot) {
                    if ( snapshot.hasData) {
                      return   CarouselBanner(imageUrls:snapshot.data, isloading: true);
                    }
                    return Container();
                  },
                ),



              SizedBox(height: 10),
              RandomCategoryList(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ));
  }
}
