import 'package:amaliyot/utils/app_constant.dart';
import 'package:amaliyot/utils/preferences.dart';
import 'package:amaliyot/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PinCodeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<Color> onAppBarColorChanged;
  final ValueChanged<double> onTextFontSize;
  final ValueChanged<Color> onTextColor;

  const PinCodeScreen({
    super.key,
    required this.onThemeChanged,
    required this.onAppBarColorChanged,
    required this.onTextFontSize,
    required this.onTextColor,
  });

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final textPinCodeController1 = TextEditingController();
  final textPinCodeController2 = TextEditingController();

  String errorMessagePinCode1 = "";
  String errorMessagePinCode2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: textPinCodeController1,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                fillColor: const Color(0xffF1F1FE),
                filled: true,
                errorStyle: const TextStyle(color: Colors.red),
                label: const Text(
                  "PIN CODE",
                  style: TextStyle(fontSize: 14),
                ),
                errorText:
                    errorMessagePinCode1.isEmpty ? null : errorMessagePinCode1,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: textPinCodeController2,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                fillColor: const Color(0xffF1F1FE),
                filled: true,
                errorStyle: const TextStyle(color: Colors.red),
                label: const Text(
                  "PIN CODE Again",
                  style: TextStyle(fontSize: 14),
                ),
                errorText:
                    errorMessagePinCode2.isEmpty ? null : errorMessagePinCode2,
              ),
            ),
            const SizedBox(height: 50),
            ZoomTapAnimation(
              onTap: () async {
                if (textPinCodeController1.text.length < 4) {
                  errorMessagePinCode1 = "Don't be less than four numbers";
                } else if (textPinCodeController1.text !=
                    textPinCodeController2.text) {
                  errorMessagePinCode2 = "Pin Codes must be the same";
                } else {
                  errorMessagePinCode2 = "";
                  errorMessagePinCode1 = "";
                }

                if (errorMessagePinCode1.isEmpty &&
                    errorMessagePinCode2.isEmpty) {
                  AppConstants.password = textPinCodeController1.text;
                  await Preferences.setPassword(AppConstants.password);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen(
                        onThemeChanged: widget.onThemeChanged,
                        onAppBarColorChanged: widget.onAppBarColorChanged,
                        onTextFontSize: widget.onTextFontSize,
                        onTextColor: widget.onTextColor,
                      );
                    },
                  ));
                }
                setState(() {});
              },
              child: Container(
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.green.shade400,
                ),
                child: const Center(
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
