import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin/home/home_sceen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //Email field

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Voer je e-mailadres in";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Voer een geldige e-mailadres in");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Gebruikersnaam",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //Password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: isHiddenPassword,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Wachtwoord is vereist om in te loggen");
        }
        if (!regex.hasMatch(value)) {
          return ("Voer een geldig wachtwoord in(Min. 6 karakters)");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: InkWell(
              onTap: _togglePasswordView, child: const Icon(Icons.visibility)),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Wachtwoord",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final loginButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 178, 0, 13),
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "Aanmelden",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text("Login Screen",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      height: 200,
                      width: 300,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      )),
                  const SizedBox(
                    height: 45,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: const Text(
                          "Log in met je AP-gebruikersnaam en wachtwoord")),
                  const SizedBox(
                    height: 45,
                  ),
                  emailField,
                  const SizedBox(
                    height: 45,
                  ),
                  passwordField,
                  const SizedBox(
                    height: 45,
                  ),
                  loginButton,
                  const SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successvol"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
