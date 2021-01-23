import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  String label;
  Function validateFun;
  Function saveFun;
  CustomTextField({this.label, this.saveFun, this.validateFun});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        onSaved: (newValue) {
          saveFun(newValue);
        },
        validator: (value) {
          return validateFun(value);
        },
        decoration: InputDecoration(
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
