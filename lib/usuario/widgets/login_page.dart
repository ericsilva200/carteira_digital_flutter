import "dart:convert";
import "dart:developer";

import "package:carteira/documento/widgets/home_page.dart";
import "package:carteira/usuario/controller/user_controller.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";

import '../model/user_model.dart';
import "sign_up_page.dart";

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginPage> {
  final TextEditingController _mailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carteira Digital',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple[400],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 126, 87, 194), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Entrar",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _mailInputController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: Colors.white,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          ))),
                      validator: (mail) {
                        if (mail == null || mail.isEmpty) {
                          return "Digite o seu e-mail";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordInputController,
                      obscureText: showPassword == false,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.vpn_key_sharp,
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (senha) {
                        if (senha == null || senha.isEmpty) {
                          return "Digite a sua senha";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: showPassword,
                    onChanged: (bool? newValue) {
                      setState(() {
                        showPassword = newValue!;
                      });
                    },
                    activeColor: Color.fromARGB(255, 126, 87, 194),
                  ),
                  const Text(
                    "Mostrar a Senha",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _doLogin();
                    }
                  },
                  child: const Text("Login"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: const Text("Cadastre-se"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin() async {
    String mailForm = _mailInputController.text;
    String passwordForm = _passwordInputController.text;

    bool logged = await ref.read(userControllerProvider.notifier).signIn(mailForm, passwordForm);
    if (logged) {
      log("LOGIN EFETUADO COM SUCESSO.");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      log("FALHA NO LOGIN.");

      showAlertDialog1(BuildContext context) {
        // configura o button
        Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        // configura o  AlertDialog
        AlertDialog alerta = AlertDialog(
          title: Text("Falha no Login"),
          content: Text("Usuário inválido! Verifique a senha e o e-mail."),
          actions: [
            okButton,
          ],
        );
        // exibe o dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alerta;
          },
        );
      }

      showAlertDialog1(context);
    }
  }

  Future<User> _getSavedUser(mailForm, passwordForm) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonUser = prefs.getString("LOGGIN_USER_INFOS") ?? {};
    log(jsonUser.toString());
    Map<String, dynamic> mapUser = json.decode(jsonUser.toString());
    User user = User.fromJson(mapUser);
    return user;
  }
}
