import 'package:coupons/data/api.dart';
import 'package:coupons/screens/Orders/OrderCard.dart';
import 'package:coupons/services/authService.dart';
import 'package:coupons/models/OrderModel.dart';
import 'package:coupons/widgets/Layouts/StyledAppBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
       Center(
          child: MyOrdersPage(
        keyshow: 1,
      )),
       Center(
          child: MyOrdersPage(
        keyshow: 2,
      )),
       Center(
          child: MyOrdersPage(
        keyshow: 0,
      )),
    ];
    final _kTabs = <Tab>[
      Tab(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text("Compleated".tr()),
          ),
        ),
      ),
      Tab(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text("Rejected".tr()),
          ),
        ),
      ),
      Tab(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            "Wating".tr(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: StyledAppBar(
            title: 'Orders'.tr(),
            butten: TabBar(
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.black),
              tabs: _kTabs,
            ),
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
        ),
      ),
    );
  }
}

class MyOrdersPage extends StatefulWidget {
  final int keyshow;

  const MyOrdersPage({Key key, this.keyshow}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<MyOrdersPage>
    with AutomaticKeepAliveClientMixin<MyOrdersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
//        appBar: StyledAppBar(title: 'Orders'.tr()),
        body: RefreshIndicator(
            onRefresh: () {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (a, b, c) => OrdersPage(),
                      transitionDuration: Duration(seconds: 0)));
              return Future.value(false);
            },
            child: FutureBuilder<User>(
                future: context.read<AuthService>().user,
                builder: (context, user) => !user.hasData
                    ? Center(child: CircularProgressIndicator())
                    : FutureBuilder<List<OrderModel>>(
                        future: context
                            .read<Api>()
                            .getOrders(phone: user.data.phoneNumber),
                        builder: (context, orders) {
                          if (orders.hasData) {
                            if (orders.data.isEmpty)
                              return Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    SizedBox(height: 100),
                                    Icon(
                                      Icons.local_shipping_outlined,
                                      color: Colors.grey.shade200,
                                      size: 240,
                                    ),
                                    Text(
                                      'No Orders Yet'.tr(),
                                      style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            return ListView(
                              padding: EdgeInsets.only(bottom: 200),
                              children: orders.data
                                  .map((e) => (e.isAccepted == widget.keyshow)
                                      ? OrderCard(
                                          order: e,
                                        )
                                      : Container())
                                  .toList(),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }))));
  }

  @override
  bool get wantKeepAlive => true;
}
