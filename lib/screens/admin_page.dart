import 'package:flutter/material.dart';
import 'package:johnproject/components/custom_dialog.dart';
import 'package:johnproject/screens/homepage.dart';
import 'package:johnproject/utility/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'admin_custom_page.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(),
          Container(
            padding: const EdgeInsets.only(left: 35, top: 130),
            child: const Text(
              'Welcome\nJohn',
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        // TextField(
                        //   style: TextStyle(color: Colors.black),
                        //   decoration: InputDecoration(
                        //       fillColor: Colors.grey.shade100,
                        //       filled: true,
                        //       hintText: "Email",
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //       )),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),

                        TextField(
                          style: const TextStyle(),
                          obscureText: true,
                          controller: _password,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                  )),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    // print("object");
                                    if (_password.text == "casadenebuni123") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminCustomPage()));
                                    } else {
                                      CustomAwesomDialog().dialogBox(
                                          context,
                                          "Error...!",
                                          "Please enter correct password...!",
                                          DialogType.ERROR);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TextButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(context, 'register');
                            //   },
                            //   // child: Text(
                            //   //   'Sign Up',
                            //   //   textAlign: TextAlign.left,
                            //   //   style: TextStyle(
                            //   //       decoration: TextDecoration.underline,
                            //   //       color: Color(0xff4c505b),
                            //   //       fontSize: 18),
                            //   // ),
                            //   style: ButtonStyle(),
                            // ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff4c505b),
                                    fontSize: 18,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // bool inputValidate() {
  //   var isValid = false;
  //   if (_password.text.trim().isEmpty) {
  //     isValid = false;
  //   } else {
  //     isValid = true;
  //   }
  //   return isValid;
  // }
}
