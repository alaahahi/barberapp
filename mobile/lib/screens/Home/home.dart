import 'package:barber/data/api.dart';
import 'package:barber/models/SliderModel.dart';
import 'package:barber/screens/Search/RandomCategoryList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:barber/widgets/CarouselBanner.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
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
              AnimatedSize(
              vsync: this,
              curve: Curves.linear,
              duration: Duration(milliseconds:1000),
              child:
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
              )),


              SizedBox(height: 15),
         AnimatedSize(
           vsync: this,
            curve: Curves.easeInOutCubic,
            duration: Duration(milliseconds:2000),
            child:
                    Container(
                      child: FutureBuilder(
                      future: context.read<Api>().getSlider(),
                      builder: (context, AsyncSnapshot<List<SliderModel>> snapshot) {
                        if ( snapshot.hasData) {
                          return   CarouselBanner(imageUrls:snapshot.data, isloading: true);
                        }
                        return Container();
                      },
                  ),
                    ),),
              SizedBox(height: 30),
      AnimatedSize(
        vsync: this,
        curve: Curves.easeInOutBack,
        duration: Duration(milliseconds:3000),
        child:
              RandomCategoryList(),
      ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ));
  }
}
