import 'package:coupons/data/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
class ActivationInput extends StatefulWidget {
  const ActivationInput({Key key, this.onActivate}) : super(key: key);

  final void Function() onActivate;

  @override
  _ActivationInputState createState() => _ActivationInputState();
}

class _ActivationInputState extends State<ActivationInput> {
  MaskedTextController tc = MaskedTextController(mask: '0000-00-0000');
  bool activating = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activation code'.tr(),
          style: TextStyle(
            color: Colors.black.withOpacity(0.3),
            // fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
            ),
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.05)),
            hintText: "0123-45-6789",
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(
            letterSpacing: 10,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          maxLength: 12,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          enabled: !activating,
          controller: tc,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20),
                backgroundColor: Colors.green.shade600,
              ),
              onPressed: () async {
                setState(() {
                  activating = true;
                });
                try {
                  final user = null;
                  final res = await context.read<Api>().activation(
                        card: tc.text,
                        phone: user.phoneNumber,
                      );

                  if (widget.onActivate != null) widget.onActivate();

                  Fluttertoast.showToast(
                    msg: 'Activated successfuly, until: '.tr() + res.toString(),
                  );

                  Phoenix.rebirth(context);
                } catch (ex) {
                  Fluttertoast.showToast(msg: ex.toString());
                }
                setState(() {
                  activating = false;
                });
              },
              child: activating
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red.shade50,
                      ),
                    )
                  : Text('Activate'.tr()),
            ),
          ],
        )
      ],
    );
  }
}
