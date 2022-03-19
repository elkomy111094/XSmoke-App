import 'package:flutter/material.dart';
import 'package:xsmoke/conatants.dart';

class CustomTextFormField extends StatelessWidget {
  final String fieldName;

  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType? keyBoardType;

  /*final void Function(String?)? onSave;*/
  final Widget? suffixIcon;
  final bool textObsecure;

  void Function(String)? onChange;
  void Function(String?)? onSave;

  CustomTextFormField(
      {this.onChange,
      this.onSave,
      this.hintText = "",
      this.prefixIcon = null,
      this.keyBoardType,
      this.textObsecure = false,
      this.suffixIcon = null,
      required this.fieldName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: fieldName,
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontFamily: "Patu",
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ])),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: 45,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                letterSpacing: .75,
                                fontFamily: "Patu"),
                            obscureText: textObsecure,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: hintText,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                prefixIcon,
                                color: kSecondaryColor,
                                size: 30,
                              ),
                              suffixIcon: suffixIcon,
                              focusColor: kSecondaryColor,
                              /*filled: true,*/
                              /*fillColor: mainColor,*/
                              hoverColor: kSecondaryColor,
                            ),
                            keyboardType: keyBoardType,
                            onChanged: onChange,
                            onSaved: onSave,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
