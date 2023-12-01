import 'package:flutter/material.dart';
import 'package:quanto_falta_front/api/userapi.dart';
import 'package:quanto_falta_front/core/widget/quanto_field.dart';
import 'package:quanto_falta_front/core/widget/quanto_logo.dart';
import 'package:quanto_falta_front/screens/home.dart';
import 'package:quanto_falta_front/screens/register.dart';
import 'package:validatorless/validatorless.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const QuantoLogo(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            QuantoField(
                              label: 'E-mail',
                              controller: emailController,
                              focusNode: _emailFocus,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            QuantoField(
                              label: 'Senha',
                              controller: passwordController,
                              obscureText: true,
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatória'),
                                Validatorless.min(6,
                                    'Senha deve conter pelo menos 6 caracteres')
                              ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Esqueceu sua senha?'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        // ignore: non_constant_identifier_names
                                        String JWT = await UserAPI.login(
                                            email: emailController.text,
                                            pwd: passwordController.text);
                                        if (JWT.toString() != "") {
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context)
                                              .pushNamed('/homePage');
                                        }
                                      } catch (e) {
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Erro ao logar')),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Por favor preencha os campos')),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Login'),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F3F7),
                          border: Border(
                            top: BorderSide(
                                width: 2, color: Colors.grey.withAlpha(50)),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            // SignInButton(
                            //   Buttons.Google,
                            //   text: 'Continue com o Google',
                            //   padding: const EdgeInsets.all(5),
                            //   shape: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(30),
                            //     borderSide: BorderSide.none,
                            //   ),
                            //   onPressed: () {
                            //     context.read<LoginController>().googleLogin();
                            //   },
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Não tem conta?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/register');
                                  },
                                  child: const Text('Cadastre-se'),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Precisa de ajuda?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/help');
                                  },
                                  child: const Text('Suporte'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        // Form(
        //   key: _formKey,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Padding(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        //           child: TextFormField(
        //             controller: emailController,
        //             decoration: const InputDecoration(
        //                 border: OutlineInputBorder(), labelText: "Email"),
        //             validator: (value) {
        //               if (value == null || value.isEmpty) {
        //                 return 'Por favor insira seu email';
        //               }
        //               return null;
        //             },
        //           ),
        //         ),
        //         Padding(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        //           child: TextFormField(
        //             controller: passwordController,
        //             obscureText: true,
        //             decoration: const InputDecoration(
        //                 border: OutlineInputBorder(), labelText: "Senha"),
        //             validator: (value) {
        //               if (value == null || value.isEmpty) {
        //                 return 'Por favor insira sua senha';
        //               }
        //               return null;
        //             },
        //           ),
        //         ),
        //         Padding(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
        //           child: Center(
        //             child: ElevatedButton(
        //               onPressed: () async {
        //                 if (_formKey.currentState!.validate()) {
        //                   // ignore: non_constant_identifier_names
        //                   final String JWT = await UserAPI.login(
        //                       email: emailController.text,
        //                       pwd: passwordController.text);
        //                   if (JWT.toString() != "") {
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => HomePage(
        //                                 email: emailController.text,
        //                               )),
        //                     );
        //                   } else {
        //                     ScaffoldMessenger.of(context).showSnackBar(
        //                       const SnackBar(
        //                           content: Text('Credenciais Inválidas')),
        //                     );
        //                   }
        //                 } else {
        //                   ScaffoldMessenger.of(context).showSnackBar(
        //                     const SnackBar(
        //                         content: Text('Por favor preencha os campos')),
        //                   );
        //                 }
        //               },
        //               child: const Text('Login'),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
