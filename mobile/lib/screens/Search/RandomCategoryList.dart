import 'package:cached_network_image/cached_network_image.dart';
import 'package:barber/data/api.dart';
import 'package:barber/models/CategoriesModel.dart';
import 'package:barber/screens/Category/category.dart';
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
                  crossAxisCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: renderChildren(context, snapshot.data),
                )
              : GridView.count(
            childAspectRatio: 8 / 5,
            crossAxisCount: 1,

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
                height: MediaQuery.of(context).size.height * 0.06,
                margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.05),
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
      child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            Container(
                width: MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color:Color.fromRGBO(0, 0, 0, 0.9),

                ),
                margin:EdgeInsets.only(bottom: 10),
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child:  CachedNetworkImage(
                    imageUrl: imgItem,
                    fit: BoxFit.cover,
                  ),
                )
            ),
            Container(
              width: MediaQuery.of(context).size.width ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color:Color.fromRGBO(255, 255, 255, 0.3),

              ),
              margin:EdgeInsets.only(bottom: 10),
            ),
            Container(
                child:
                Text(textName,style: TextStyle(color: Color.fromRGBO(236, 194, 0, 1),fontSize:40,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(3, 3),
                      blurRadius: 3.0,
                      color: Color.fromARGB(0, 0, 0, 255),
                    ),
                  ],
                ),)
            ),
          ]
      )

    );
  }
}
