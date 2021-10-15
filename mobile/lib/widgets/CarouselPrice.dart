import 'package:barber/models/PriceModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarouselPrice extends StatelessWidget {
  const CarouselPrice({
    Key key,
    @required this.imageUrls,
    this.isloading = false
  }) : super(key: key);

  final List<PriceModel> imageUrls;
  final bool isloading;

  @override
  Widget build(BuildContext context) {
    return  CarouselSlider(
              items: imageUrls
                  .map((url) => Container(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width:MediaQuery.of(context).size.width,
                          imageUrl: url.img,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                enableInfiniteScroll: true,
                autoPlay: true,
                aspectRatio: 16/9,
                autoPlayInterval: Duration(seconds: 300),
                autoPlayAnimationDuration: Duration(milliseconds: 600),
                //autoPlayCurve: Curves.easeOutSine,
                //enlargeCenterPage: true,
               // disableCenter: true,
                viewportFraction: 1,
                scrollDirection: Axis.horizontal,
              ),
            );
  }
}
