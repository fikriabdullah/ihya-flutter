import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/widgets.dart';

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

class _registerFormState extends State<registerForm> {
  final formKey = GlobalKey<FormState>();

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
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please Enter Your Phone Number';
                    }
                    return null;
                  },
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
                child: DropDownRegister(),
              ),
              SizedBox(height: 50,),
          ElevatedButton(
              onPressed: (){
                if(formKey.currentState!.validate()){
                  Navigator.pushReplacementNamed(context, '/dashboardMurid');
                  print("redirecting to dashboard Murid");
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

