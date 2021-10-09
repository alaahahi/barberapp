import 'package:barber/widgets/Layouts/StyledAppBar.dart';
import 'package:barber/widgets/common/RandomGiftList.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyledAppBar(
          title: "My Gift".tr(),
        ),
        body: RandomGiftList(isGrid: false));
  }
}
