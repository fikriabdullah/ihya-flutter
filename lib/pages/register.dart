import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
List<String> userMenu = <String>['Pilih Role', 'Guru', 'Murid'];

class register extends StatelessWidget {
  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: registerForm()
      ),
    );
  }
}

class registerForm extends StatefulWidget {
  const registerForm({Key? key}) : super(key: key);

  @override
  State<registerForm> createState() => _registerFormState();
}


class _registerFormState extends State<registerForm>{

  final formKey = GlobalKey<FormState>();
  final authService auth = authService();

  String dropDownValue = userMenu.first;
  String userName = "";
  String password = "";
  String email = "";
  String phoneNumber = "";
  String role = "";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/biru.png'),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          margin: EdgeInsets.only(top: 150),
          height: 700,
          width: 600,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            )
          ),
          child: Column(
            children: [
              SizedBox(height: 20,),
              SizedBox(
                width: 350,
                child: TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please Enter Your Email';
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Enter Your Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 350,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      userName = value;
                    });
                  },
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please Enter Your Username';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: "Enter Your Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 350,
                child: TextFormField(
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: "Enter Your Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 350,
                child: TextFormField(
                  onChanged: (value){
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                  validator: (value) => value == null || value.isEmpty ? 'Please Provide Your Phone Number' : null,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      labelText: "Enter Your Phone Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 350,
                child: DropdownButtonFormField(
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
                        role = value;
                      });
                    }
                )
              ),
              SizedBox(height: 50,),
          ElevatedButton(
              onPressed: ()async{
                if(formKey.currentState!.validate()){
                  dynamic result = await auth.createUserWithEmailPassword(phoneNumber, userName, email, role, password);
                  if(result == 'weak-password'){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Strengthten Your Password With Combination of Special Character and Numerical')));
                  }else if(result == 'email-already-in-use'){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email is Already in Use')));
                  }else if(result == 'userCreatedSaved'){
                    if(role == "Murid"){
                      Navigator.pushReplacementNamed(context, '/dashboardMurid');
                      print(role);
                    }else if(role == "Guru") {
                      Navigator.pushReplacementNamed(context, '/dashboardGuru');
                      print(role);
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text("Register",
                  style: TextStyle(
                      letterSpacing: 1.0,
                      fontSize: 20
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

