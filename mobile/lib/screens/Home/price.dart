import 'package:barber/widgets/Layouts/StyledAppBar.dart';
import 'package:barber/widgets/common/RandomGiftList.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

class PricePage extends StatelessWidget {
  const PricePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyledAppBar(
          title: "Prices".tr(),
        ),
        body: RandomGiftList(isGrid: false));
  }
}
