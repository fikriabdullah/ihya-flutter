import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

//TODO :
// 1. set shared preference
// 2. set forgot password
// 3. set textfield autofocus thing


class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  bool sharedPref = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/biru.png'),
                fit: BoxFit.cover
              )
            ),
            child: Container(
              height: 700,
              width: 800,
              margin: EdgeInsets.only(top: 300.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
                color: Colors.grey[300],
              ),
              child: Column(
                children: [
                  SizedBox(height: 55),
                  SizedBox(
                    width:350,
                    child: TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Please Enter Your Email';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                        autofocus: true,
                        decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        labelText: 'Enter Your Email'
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width:350,
                    child: TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          labelText: 'Enter Your Password'
                      ),
                    ),
                  ),
                  SizedBox(height:10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch(
                          value: sharedPref,
                          onChanged: (bool value){
                            setState(() {
                              sharedPref = value;
                            });
                          }),
                      Text("Save My Data for Future Login",
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          Navigator.pushReplacementNamed(context, '/dashboardMurid');
                          print("redirecting to dashboardMurid");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )),
                  Row(
                    children: [
                      Text("Not Have Account Yet? "),
                      TextButton(onPressed: (){
                        Navigator.pushReplacementNamed(context, '/register');
                      }, child: Text("Click Here"))
                    ],
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
