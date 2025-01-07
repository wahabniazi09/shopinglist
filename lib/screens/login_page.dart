import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopinglist/routes/page_routes.dart';
import 'package:shopinglist/services/auth_helper.dart';
import 'package:shopinglist/services/validation.dart';
import 'package:shopinglist/widgets/beveled_button..dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = "/LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailCntrl = TextEditingController();
  final passCntrl = TextEditingController();
  bool loginStatus = false;
  bool isObscure = true;
  String email = '';
  String password = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, PageRoutes.shopinglistPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login Page'),
      ),
      body: Center(
          child: Card(
        color: Colors.orange.withOpacity(0.7),
        elevation: 10,
        margin: const EdgeInsets.all(10),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                //physics: const NeverScrollableScrollPhysics(),
                child: SafeArea(
                    child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailCntrl,
                    maxLength: 30,
                    decoration: const InputDecoration(
                        labelText: 'Email', hintText: "Enter Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidation,
                    onSaved: (value) {
                      setState(() {
                        email = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: passCntrl,
                    obscureText: isObscure,
                    maxLength: 8,
                    decoration: const InputDecoration(
                        labelText: 'Password', hintText: "Enter password"),
                    keyboardType: TextInputType.number,
                    validator: passwordValidation,
                    onSaved: (value) {
                      setState(() {
                        password = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  loginStatus
                      ? const SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: BeveledButton(
                              title: "Login", onTap: onLoginSubmit),
                        )
                ],
              ),
            )))),
      )),
    );
  }

  void onLoginSubmit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        loginStatus = true;
      });
      await Future.delayed(const Duration(seconds: 2), () {});
      _signInUser();

      setState(() {
        loginStatus = false;
      });
    }
  }

  void _signInUser() async {
    AuthenticationHelper()
        .signIn(email: email, password: password)
        .then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You are authenticated")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $value")));
      }
    });

    await Future.delayed(const Duration(seconds: 2), () {});
    Navigator.pushReplacementNamed(context, PageRoutes.shopinglistPage);
  }
}
