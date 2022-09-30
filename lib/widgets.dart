import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/pages/register.dart';
List<String> userMenu = <String>['Pilih Role', 'Guru', 'Murid'];

class DropDownRegister extends StatefulWidget {
  const DropDownRegister({Key? key}) : super(key: key);

  @override
  State<DropDownRegister> createState() => _DropDownRegisterState();
}

class _DropDownRegisterState extends State<DropDownRegister> {
  String dropDownValue = userMenu.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: (value){
        if(value == 'Pilih Role'){
          return 'Please Pick a Role';
        }
        return null;
      },
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            )
        ),
        items: userMenu.map<DropdownMenuItem<String>>((String value){
          return DropdownMenuItem<String>(
            child: Text(value),
            value: value,
          );
        }).toList(),
        value: dropDownValue,
        onChanged: (String? value){
          setState(() {
            dropDownValue = value!;
          });
        });
  }
}
