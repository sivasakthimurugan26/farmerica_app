import 'package:flutter/material.dart';

class FormHelper {
  static Widget textInput(
    BuildContext context,
    Object initialValue,
    String hintText,
    String helperText,
    Function onChanged, {
    bool isTextArea = false,
    bool isNumberInput = false,
    obscureText= false,
    Function? onValidate,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool readOnly = false,
  }) {
    return TextFormField(
      initialValue: initialValue != null ? initialValue.toString() : "",
      decoration: fieldDecoration(
        context,
        hintText,
        helperText,
        suffixIcon: suffixIcon,
      ),
      readOnly: readOnly,
      obscureText: obscureText,
      maxLines: !isTextArea ? 1 : 3,
      keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
      onChanged: (String value) {
        return onChanged(value);
      },
      validator: (value) {
        return onValidate!(value);
      },
    );
  }

  static InputDecoration fieldDecoration(
    BuildContext context,
    String hintText,
    String helperText, {
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(6),
      hintText: hintText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 1,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
    );
  }

  static Widget fieldLabel(String labelName) {
    return Text(
      labelName,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
    );
  }

  static Widget saveButton(String buttonText, Function onTap,
      {String? color, String? textColor, bool? fullWidth}) {
    return Container(
      height: 50.0,
      width: 150,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: [
            TextButton(
              onPressed: () {
                return onPressed();
              },
              child: new Text(buttonText),
            )
          ],
        );
      },
    );
  }

  static Widget fieldLabelValu(BuildContext context, String labelName) {
    return FormHelper.textInput(
      context,
      labelName,
      "",
      "",
      () {},
      onValidate: (valu) {
        return null;
      },
      readOnly: true,
    );
  }
}
