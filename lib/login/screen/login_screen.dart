import 'package:flutter/material.dart';
import 'package:products_kart/login/model/login_request_model.dart';
import 'package:products_kart/login/provider/auth_provider.dart';
import 'package:products_kart/product/screen/product_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = 'kminchelle';
    passwordController.text = '0lelplR';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "EnterUserName";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "EnterPassword";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          doLogin(context);
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ),
              ),
              if (authProvider.isLoading) const CircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }

  Future<void> doLogin(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      final provider = Provider.of<AuthProvider>(context, listen: false);

      LoginRequest loginRequest = LoginRequest(
        name: nameController.text,
        password: passwordController.text,
      );

      bool success = await provider.doLogin(loginRequest);
      if (success && mounted) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProductScreen()),
        );
      }
    }
  }
}
