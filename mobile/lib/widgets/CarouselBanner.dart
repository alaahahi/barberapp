import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupons/models/SliderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarouselBanner extends StatelessWidget {
  const CarouselBanner({
    Key key,
    @required this.imageUrls,
    this.isloading = false
  }) : super(key: key);

  final List<SliderModel> imageUrls;
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
                height: MediaQuery.of(context).size.height * 0.33,
                enableInfiniteScroll: true,
                autoPlay: true,
                aspectRatio: 16/9,
                autoPlayInterval: Duration(seconds: 3),
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
