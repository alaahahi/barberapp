import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/data/api.dart';
import 'package:coupons/models/CategoriesModel.dart';
import 'package:coupons/screens/Category/category.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class RandomCategoryList extends StatelessWidget {
  const RandomCategoryList({Key key, this.isGrid = false}) : super(key: key);
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          return isGrid
              ? GridView.count(
                  childAspectRatio:  500 / 500,
                  crossAxisCount: 3,
                  padding: EdgeInsets.all(25),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: renderChildren(context, snapshot.data),
                )
              : GridView.count(
            childAspectRatio: 500 / 500,
            crossAxisCount: 3,
            padding: EdgeInsets.all(25),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: renderChildren(context, snapshot.data),
          );
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey[100],
          highlightColor: Colors.grey[200],
          child:
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
              ),
            ],
          )
        );
      },
    );
  }

  List<Widget> renderChildren(BuildContext context, List<CategoryModel> data) {
    return data
        .map(
          (category) => CategoryButton(
            textName: category.title,
            imgItem: category.logo,
            onClick: () => pushNewScreen(
              context,
              screen: CategoryPage(category: category),
            ),
          ),
        )
        .toList();
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key key,
    this.textName,
    this.imgItem,
    this.onClick,
  }) : super(key: key);

  final String textName;
  final String imgItem;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            margin: EdgeInsets.all(10),
            child: CachedNetworkImage(
              imageUrl: imgItem,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.03,
              child:
          Text(textName)
          ),
        ],
      ),
    );
  }
}
