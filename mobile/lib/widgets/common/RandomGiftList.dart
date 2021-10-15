import 'package:barber/models/CategoriesModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:barber/data/api.dart';
import 'package:barber/screens/Home/ActivationBox.dart';
import 'package:barber/screens/Home/ActivationInput.dart';
import 'package:barber/services/activation.dart';
import 'package:barber/widgets/Items/showGift.dart';

import 'package:barber/models/GiftModel.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class RandomGiftList extends StatelessWidget {
  const RandomGiftList({Key key, this.isGrid = false}) : super(key: key);
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
      future: context.read<Api>().getCategories(),
      builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.red),
              ),
            ],
          );
        }
        if (snapshot.hasData) {
          return ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              textTitle(snapshot.data.first.toString(), Colors.blue),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: renderPoints(context, snapshot.data),
                ),
              ),
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  List<Widget> renderPoints(BuildContext context, List<CategoryModel> data) {
    return data.map((winner) {
      if (true) {
        return GiftButton(
            textName: winner.title,
            imgItem: winner.photo
       );
      } else {
        return Container();
      }
    }).toList();
  }

  List<Widget> renderWeekly(BuildContext context, List<GiftModel> data) {
    return data.map((winner) {
      if (winner.gift_type_id == 4) {
        return GiftButton(
            textName: winner.giftTranslation.title,
            imgItem: winner.icon,
            level_points: "",
            onClick: () {
              pushNewScreen(
                context,
                screen: showGift(
                  giftModel: winner,
                ),
              );
            });
      } else {
        return Container();
      }
    }).toList();
  }
}

List<Widget> renderMonthly(BuildContext context, List<GiftModel> data) {
  return data.map((winner) {
    if (winner.gift_type_id == 3) {
      return GiftButton(
          textName: winner.giftTranslation.title,
          imgItem: winner.icon,
          level_points: "",
          onClick: () {
            pushNewScreen(
              context,
              screen: showGift(
                giftModel: winner,
              ),
            );
          });
    } else {
      return Container();
    }
  }).toList();
}

class GiftButton extends StatelessWidget {
  const GiftButton({
    Key key,
    this.textName,
    this.imgItem,
    this.onClick,
    this.level_points,
    this.gift_type_id,
    this.giftTranslation,
  }) : super(key: key);

  final String textName, imgItem, level_points;
  final gift_type_id;
  final void Function() onClick;
  final GiftTranslation giftTranslation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 80,
          margin: EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CachedNetworkImage(
                imageUrl: imgItem,
                fit: BoxFit.cover,
              ),
              Text(textName),
              Text(level_points),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textTitle(String title, var colorTitle) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, left: 25, right: 25),
    child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: colorTitle,
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )),
  );
}
class ActivationListTile extends StatefulWidget {
  const ActivationListTile({Key key}) : super(key: key);

  @override
  _ActivationListTileState createState() => _ActivationListTileState();
}

class _ActivationListTileState extends State<ActivationListTile> {
  bool showActivationInput = false;

  @override
  Widget build(BuildContext context) {
    return showActivationInput
        ? ListTile(
        title: ActivationInput(
            onActivate: () => setState(() => showActivationInput = false)))
        : ListTile(
      leading: Icon(Icons.more_time_outlined),
      title: Text('Click here to extend activation'.tr()),
      onTap: () => setState(() => showActivationInput = true),
    );
  }
}