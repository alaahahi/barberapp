import 'package:coupons/services/likes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    Key key,
    this.color,
    this.icon,
    this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final Color color;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        icon: Icon(
          icon,
          color: color,
          size: 30,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class LikeButton<T extends LikeService> extends StatelessWidget {
  const LikeButton({Key key, this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (_, likeService, __) => Card(
        margin: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        color:  Color.fromRGBO(17, 47, 0, 1),
        child: IconButton(
          icon: Icon(
            likeService.isLiked(id) ? Icons.favorite : Icons.favorite_border,
            color: Color.fromRGBO(236, 194, 0, 1),

            size: 30,
          ),
          onPressed: () => likeService.toggle(id),
        ),
      ),
    );
  }
}
