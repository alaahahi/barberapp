import 'package:cached_network_image/cached_network_image.dart';
import 'package:barber/models/ProductModel.dart';
import 'package:barber/services/likes.dart';
import 'package:barber/services/cartService.dart';
import 'package:barber/widgets/Cards/LikeButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

class LikableCard extends StatelessWidget {
  final ProductModel product;
  final GestureTapCallback onTap;
  final bool vertical;
  final bool showEdit;

  LikableCard({
    @required this.product,
    this.onTap,
    this.vertical = true,
    this.showEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(
      builder: (_, cartService, __) => Container(
        width: vertical
            ? MediaQuery.of(context).size.width * 0.5
            : double.infinity,
        height: vertical ? 350 :  MediaQuery.of(context).size.height * 0.5,
        child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                renderContent(
                  context,
                  cartService.getQunatity(product.id),
                  cartService.change,
                ),
                /*
                Positioned(
                  bottom: vertical ? null : 0,
                  top: vertical ? 0 : null,
                  left: EasyLocalization.of(context).locale.languageCode == 'en'
                      ? 0
                      : null,
                  right:
                      EasyLocalization.of(context).locale.languageCode == 'en'
                          ? null
                          : 0,
                  child: LikeButton<ProductLikeService>(id: product.id),
                ),

                 */
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderContent(
    context,
    int quantity,
    void Function(int id, int quantity) changeQuantity,
  ) {
    if (vertical)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 6, child: renderImage(context)),
         // Flexible(flex: 2, fit: FlexFit.loose, child: renderTexts(quantity, changeQuantity)),
        ],
      );

    return Row(
      children: <Widget>[
        Flexible(flex: 6, child: renderImage(context)),
       // Flexible(flex: 3, child: renderTexts(quantity, changeQuantity)),
      ],
    );
  }

  Widget renderTexts(
    int quantity,
    void Function(int id, int quantity) changeQuantity,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                maxLines: vertical ? 1 : 2,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (product.desc != null && product.desc.isNotEmpty)
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: vertical ? 1 : 2,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.redAccent,
                  ),
                ),
              SizedBox(height: 4),
              Row(
                children: [
                  if (product.discountPrice != null)
                    Text(
                      product.discountPrice == 0
                          ? '0'
                          : product.discountPrice.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: vertical ? 2 : 3,
                      style: TextStyle(
                        color: Colors.green.shade400,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (product.discountPrice != null) SizedBox(width: 10),
                  /*
                  if (product.price != null)
                    Text(
                      product.price.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: vertical ? 2 : 3,
                      style: TextStyle(
                        color: product.discountPrice != null
                            ? Colors.blue.shade100
                            : Colors.blue.shade400,
                        fontSize: product.discountPrice != null ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: product.discountPrice != null
                            ? FontStyle.italic
                            : FontStyle.normal,
                        decoration: product.discountPrice != null
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
    */
                ],
              ),
            ],
          ),
          if (quantity > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Icon(Icons.remove),
                  onPressed: () => changeQuantity(product.id, quantity - 1),
                ),
                Text(quantity.toString()),
                TextButton(
                  child: Icon(Icons.add),
                  onPressed: () => changeQuantity(product.id, quantity + 1),
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget renderImage(context) {
    if (product.photo == null || product.photo.isEmpty) {
      return renderErrorImage();
    }
    return GestureDetector(
      child: CachedNetworkImage(
        imageUrl: product.photo,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorWidget: (_, __, ____) => renderErrorImage(),
      ),
      onTap: () {
        pushNewScreen(
          context,
          pageTransitionAnimation: PageTransitionAnimation.scale,
          withNavBar: false,
          screen: imgeView(
            product: product.photo,
            errorImg: renderErrorImage,
          ),
        );
      },
    );
  }

  CachedNetworkImage renderErrorImage() {
    return CachedNetworkImage(
      imageUrl: 'NoImagePlaceHolder'.tr(),
      fit: BoxFit.cover,
    );
  }
}

class imgeView extends StatelessWidget {
  final String product;
  final Function errorImg;

  const imgeView({Key key, this.product, this.errorImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          imageProvider: CachedNetworkImageProvider(product),
          errorBuilder: (context, error, stackTrace) => errorImg(),
        ),
        RaisedButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
              padding:
                  EdgeInsets.only(right: 18, top: 38, bottom: 16, left: 18),
              child: Icon(
                Icons.close,
                size: 40,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
