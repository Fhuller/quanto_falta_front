import 'package:flutter/material.dart';
import 'package:quanto_falta_front/api/userapi.dart';
import 'package:quanto_falta_front/core/ui/theme_extensions.dart';
import 'package:quanto_falta_front/core/widget/quanto_field.dart';
import 'package:quanto_falta_front/core/widget/quanto_logo.dart';
import 'package:quanto_falta_front/screens/login/login_page.dart';
import 'package:validatorless/validatorless.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cursoController = TextEditingController();
  final _horasController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quanto falta',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xffF0851D),
                  ),
                ),
                Text(
                  'Cadastro',
                  style: TextStyle(
                    fontSize: 17,
                    color: const Color(0xffF0851D),
                  ),
                )
              ],
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              color: const Color(0xffF0851D).withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: const Color(0xffF0851D),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const QuantoLogo(),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: QuantoField(
                          label: 'Nome Usuario',
                          controller: _nameController,
                          validator: Validatorless.multiple([
                            Validatorless.required('Nome completo obrigatório'),
                          ]),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: QuantoField(
                          label: 'Nome Curso',
                          controller: _cursoController,
                          validator: Validatorless.multiple([
                            Validatorless.required('Nome do curso obrigatório'),
                          ]),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: QuantoField(
                          label: 'Carga horaria',
                          controller: _horasController,
                          validator: Validatorless.multiple([
                            Validatorless.required('Carga horária obrigatória'),
                          ]),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: QuantoField(
                          label: 'Email',
                          controller: _emailController,
                          validator: Validatorless.multiple([
                            Validatorless.required('Email obrigatório'),
                            Validatorless.email('Email incorreto')
                          ]),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: QuantoField(
                          label: 'Senha',
                          controller: _passwordController,
                          validator: Validatorless.multiple([
                            Validatorless.required('Senha obrigatório'),
                            Validatorless.min(6, 'Senha deve conter 6 digitos')
                          ]),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: QuantoField(
                          label: 'Confirma Senha',
                          controller: _confirController,
                          validator: Validatorless.multiple([
                            Validatorless.compare(_passwordController,
                                'As senhas devem ser iguais')
                          ]),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF0851D),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                if (await UserAPI.register(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    pwd: _passwordController.text)) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ));
                                }
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Erro ao Registrar')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Por favor preencha os campos')),
                              );
                            }
                          },
                          child: const Text('Registrar-se'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
