import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social/my_flutter_app_icons.dart';

Widget input({
  FormFieldValidator<String> validator,
  FormFieldSetter<String> onSave,
  String hint,
  TextInputType type,
  TextInputAction action,
  IconData prefix,
  bool enabled,
  bool showPrefix = true,
  TextEditingController controller,
  IconData suffix,
  List<TextInputFormatter> formatters,
}) {
  return Container(
    padding: EdgeInsets.only(top: 10),
    child: TextFormField(
      inputFormatters: formatters,
      controller: controller,
      enabled: enabled,
      validator: validator,
      onSaved: onSave,
      textInputAction: action,
      keyboardType: type,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? Container(
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      bottomLeft: Radius.circular(2)),
                ),
                child: Icon(suffix),
              )
            : null,
        prefixIcon: showPrefix
            ? Container(
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      bottomLeft: Radius.circular(2)),
                ),
                child: Icon(prefix),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    ),
  );
}

Widget btn({Function onPressed, String title, BuildContext context}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.7,
    child: RaisedButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(10),
      color: Colors.pink,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
