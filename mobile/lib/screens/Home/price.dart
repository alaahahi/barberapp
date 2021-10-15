import 'package:barber/data/api.dart';
import 'package:barber/models/PriceModel.dart';
import 'package:barber/models/SliderModel.dart';
import 'package:barber/widgets/CarouselBanner.dart';
import 'package:barber/widgets/CarouselPrice.dart';
import 'package:barber/widgets/Layouts/StyledAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class PricePage extends StatelessWidget {
  const PricePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyledAppBar(
          title: "",
        ),
        body:SafeArea(
          child:
          Container(
            child: FutureBuilder(
              future: context.read<Api>().getPrice(),
              builder: (context, AsyncSnapshot<List<PriceModel>> snapshot) {
                if ( snapshot.hasData) {
                  return   CarouselPrice(imageUrls:snapshot.data, isloading: true);
                }
                return Container();
              },
            ),
          ),),
    );
  }
}
