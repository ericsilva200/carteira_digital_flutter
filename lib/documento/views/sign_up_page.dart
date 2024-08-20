import "dart:convert";
import "dart:developer";

import "package:carteira/documento/views/login_page.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../models/user_model.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPage> {
  final TextEditingController _nameInputController = TextEditingController();
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
                "Cadastro",
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
                      controller: _nameInputController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Nome Completo",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (nome) {
                        if (nome == null || nome.isEmpty) {
                          return "Digite o seu nome";
                        }
                        return null;
                      },
                    ),
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
                      ),
                      validator: (mail) {
                        if (mail == null || mail.isEmpty) {
                          return "Digite o seu e-mail";
                        }
                        return null;
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.only(
                      bottom: 15,
                    )),
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
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _doSignUp();
                  }
                },
                child: const Text("Cadastrar"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _doSignUp() {
    User newUser = User(
        name: _nameInputController.text,
        mail: _mailInputController.text,
        password: _passwordInputController.text,
        keepOn: true);

    _saveUser(newUser);
  }

  void _saveUser(User newUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString("LOGGIN_USER_INFOS") ?? {};
    log(user.toString());
    if (user.toString() == "{}") {
      prefs.setString("LOGGIN_USER_INFOS", jsonEncode(newUser.toJson()));
      Navigator.pop(context);
    } else {
      showAlertDialog1(BuildContext context) {
        // configura o button
        Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        );
        // configura o  AlertDialog
        AlertDialog alerta = AlertDialog(
          title: Text("Falha no Cadastro"),
          content: Text("O sistema já possui um usuário cadastrado."),
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
}
