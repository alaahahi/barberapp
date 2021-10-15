import 'package:cached_network_image/cached_network_image.dart';
import 'package:barber/widgets/common/RemoteGridNList.dart';
import 'package:barber/widgets/Items/DisplayMode.dart';
import 'package:barber/widgets/Items/ListActionBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:barber/widgets/Layouts/StyledAppBar.dart';
import 'package:flutter/material.dart';

class RemoteListNGridScaffold<T> extends StatefulWidget {
  const RemoteListNGridScaffold({
    Key key,
    this.title,
    this.photo,
    this.logo,
    this.future,
    this.filler,
    this.actions,
    this.info,
  }) : super(key: key);

  final String title, photo, logo,info;
  final Future<List<T>> future;
  final Widget Function(T, bool) filler;
  final List<Widget> actions;

  @override
  _RemoteListNGridScaffoldState createState() =>
      _RemoteListNGridScaffoldState<T>();
}

class _RemoteListNGridScaffoldState<T>
    extends State<RemoteListNGridScaffold<T>> {
  DisplayMode displayMode = DisplayMode.grid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(title: widget.title),
      body: ListView(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
                imageUrl: widget.photo ?? widget.logo,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              if (widget.logo != null && widget.logo.isNotEmpty)
                Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: widget.logo,
                    height: 80,
                    width: 80,
                  ),
                ),
              if (widget.actions != null)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Column(children: widget.actions),
                ),
            ],
          ),
          SizedBox(height: 10,),
          ListActionBar(
            displayMode: displayMode,
            changeDisplayMode: (DisplayMode d) {
              setState(() => displayMode = d);
            },
          ),
           if (widget.info != null && widget.info.isNotEmpty)
          Section(
          title: 'Info'.tr(),
          tiles: [
            Card(
              child: ListTile(
                title: Text(
                  widget.info,
                ),
                leading: Icon(Icons.info),
                onTap: () {
                },
              ),
            ),]),
           SizedBox(height: 30),
          RemoteGridNList<T>(
            displayMode: displayMode,
            future: widget.future,
            filler: widget.filler,
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
class Section extends StatelessWidget {
  const Section({Key key, this.title, this.tiles}) : super(key: key);

  final String title;
  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 26, 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        ...tiles,
      ],
    );
  }
}