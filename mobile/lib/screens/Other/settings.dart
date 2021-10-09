import 'package:barber/data/api.dart';
import 'package:barber/screens/Home/ActivationInput.dart';
import 'package:barber/widgets/Layouts/StyledAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:barber/widgets/common/LangaugeDropdown.dart';
import 'package:provider/provider.dart';

import 'package:barber/models/UserInfoModel.dart';

String number = " ";
String x, y;

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(title: 'Settings'.tr()),
      body: SettingsScreen(),
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

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  bool _isEditingText = false;

  bool _isEnableText = false;

  TextEditingController _editingController = TextEditingController();

  // TextEditingController _controller = TextEditingController();

  String initialText = "";

//  String newValue;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        /*
        Section(
          title: 'Account'.tr(),
          tiles: [
            Card(
              child: ListTile(
                title: Text('Phone'.tr()),
                leading: Icon(Icons.email),
                trailing: Consumer<AuthService>(
                  builder: (context, value, child) => FutureBuilder<User>(
                    future: value.user,
                    builder: (context, snapshot) => !snapshot.hasData
                        ? CircularProgressIndicator()
                        : Text(
                            number = snapshot.data.phoneNumber,
                            textDirection: ui.TextDirection.ltr,
                          ),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Name'.tr()),
                leading: Container(child: Icon(Icons.account_circle)),
                trailing: Consumer<AuthService>(
                  builder: (context, value, child) => FutureBuilder<User>(
                    future: value.user,
                    builder: (context, snapshot) => !snapshot.hasData
                        ? Container(
                            child: CircularProgressIndicator(),
                          )
                        : FutureBuilder<UserInfoModel>(
                            future: context
                                .read<Api>()
                                .getUserInfo(Number: snapshot.data.phoneNumber),
                            builder: (context, snapshot) => !snapshot.hasData
                                ? Container(
                                 child: Text('User')  ,
                                  )
                                : (snapshot.data.name != null)
                                    ? Container(
                                        child: _editTitleTextField(
                                            x = snapshot.data.name,
                                            y = snapshot.data.phone),
                                      )
                                    : Container(child: Text('User')),

                          ),
                  ),
                ),
              ),
            ),
            Container(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: AnimatedButton(
                    text: 'Name Editing'.tr(),
                    color: Colors.blue,
                    pressEvent: () {
                      AwesomeDialog(
                        context: context,
                        keyboardAware: true,
                        dismissOnBackKeyPress: false,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        body: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Text(
                                "Enter Your Full Name".tr(),
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "New Name".tr(),
                                ),
                                autofocus: _isEnableText,
                                controller: _editingController,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buttenCancel(Colors.red, "Close".tr(), () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                }),
                                buttenCancel(Colors.green, "Save".tr(), () {
                                  editName();
                                  sendName(
                                      (_editingController.text == "")
                                          ? x
                                          : _editingController.text,
                                      y);
                                }),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ).show();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Card(
            //  child: ListTile(
            //    title: Text('Sign out'.tr()),
            //   leading: Icon(Icons.exit_to_app),
            //   onTap: () => context.read<AuthService>().signOut(),
            //  ),
            //  ),
          ],
        ),
         */
        Section(
          title: 'Application Language'.tr(),
          tiles: [
            Card(
              child: ListTile(
                leading: Icon(Icons.translate),
                title: Text('Language'.tr()),
                trailing: LangaugeDropdown(
                  value: EasyLocalization.of(context).locale.languageCode,
                  onChange: (value) {
                    EasyLocalization.of(context).setLocale(Locale(value));
                  },
                ),
              ),
            ),
          ],
        ),
        Section(
          title: 'Contactus'.tr(),
          tiles: [
            Card(
              child: ListTile(
                title: Text(
                  'MODERN MAN - MAJED',
                  style: TextStyle(color: Colors.blue),
                ),
                leading: Icon(
                  Icons.language,
                  color: Colors.blue,
                ),
                onTap: () {

                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  '07724340017',
                ),
                leading: Icon(Icons.call),
                onTap: () {
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'MODERN MAN',
                  style: TextStyle(color: Colors.blue),
                ),
                leading: Icon(
                  Icons.language,
                  color: Colors.blue,
                ),
                onTap: () {
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  '0096400000000000',
                ),
                leading: Icon(Icons.call),
                onTap: () {
                },
              ),
            ),
          ],
        ),

        Section(
          title: 'Power By'.tr(),
          tiles: [
            Card(
              child: ListTile(
                title: Text(
                  '009647511077812',
                ),
                leading: Icon(Icons.call),
                onTap: () {
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Card(
                child: ListTile(
                  title: Text(
                    'Intellij App'.tr(),
                    style: TextStyle(color: Colors.blue),
                  ),
                  leading: Icon(
                    Icons.language,
                    color: Colors.blue,
                  ),
                  onTap: () {
                  },
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }






  Widget _editTitleTextField(String inputText, String phone) {
    initialText = inputText;
    number = phone;
    if (_isEditingText)
      return Container(
        width: 200,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(),
        ),
      );
    return (_editingController.text == "")

        ? Container(
            child: Text(
              inputText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          )
        : Container(
            child: Text(
              _editingController.text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          );
  }

  void editName() {
    setState(() {
      _isEditingText = true;
      _isEnableText = true;
    });
  }

  void sendName(String inputText, String phone) {
    Navigator.of(context, rootNavigator: true).pop();
    initialText = inputText;

    setState(() async {
      final res =
          await context.read<Api>().editUserInfo(name: inputText, phone: phone);
      //Fluttertoast.showToast(msg: res);
      _isEditingText = false;
      _isEnableText = false;

      FocusScope.of(context).unfocus();
    });

    FocusScope.of(context).unfocus();
  }

  Widget buttenCancel(Color color, String text, var fun) {
    return InkWell(
        onTap: fun,
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50)),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
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

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}
