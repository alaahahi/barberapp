import 'package:barber/data/api.dart';
import 'package:barber/models/ActivationResult.dart';
import 'package:barber/screens/Home/ActivationInput.dart';
import 'package:barber/services/activation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ActivationBox extends StatefulWidget {
  ActivationBox({Key key}) : super(key: key);

  @override
  _ActivationBoxState createState() => _ActivationBoxState();
}

class _ActivationBoxState extends State<ActivationBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Activation>(
      builder: (_, state, __) => state.isActive == ActivationState.unknown
          ? Shimmer.fromColors(
          baseColor: Colors.grey[100],
          highlightColor: Colors.grey[200],
          child:
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
              ),
            ],
          )
      )
          : state.isActive == ActivationState.active
              ? Container()
              : Column(
                  children: [
                    renderStrips(),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.red.shade200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Not Active'.tr(),
                            style: TextStyle(
                              color: Colors.red.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            'You have not activate your account yet.'.tr() +
                                '\n' +
                                'Please activate your account To take advantage of the weekly and monthly draws and get additional benefits'
                                    .tr(),
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                          SizedBox(height: 20),
                          ActivationInput(),
                        ],
                      ),
                    ),
                    renderStrips(),
                  ],
                ),
    );
  }

  Widget renderStrips() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment(-.1, .7),
          stops: [0.0, 0.5, 0.5, 1],
          colors: [
            Colors.red.shade200,
            Colors.red.shade200,
            Colors.red.shade300,
            Colors.red.shade300,
          ],
          tileMode: TileMode.repeated,
        ),
      ),
    );
  }
}
