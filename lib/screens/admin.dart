import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quanto_falta_front/core/ui/theme_extensions.dart';
import 'package:quanto_falta_front/core/widget/quanto_field.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _descriptionController = TextEditingController();
    final List<String> buttonLabels = ['aaaaaaaaaaaaaa', '2', '3', '4', '5'];

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: context.primaryColor),
          backgroundColor: const Color(0xFFFAFBFE),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFFAFBFE),
        // drawer: HomeDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Certificados não aprovados',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buttonLabels.map((label) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.all(6.0),
                          ),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('AlertDialog Title'),
                              content: const Text('AlertDialog description'),
                              actions: <Widget>[
                                dialogBox(context),
                              ],
                            ),
                          ),
                          child: Text(
                            label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Certificados aprovados',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Column(children: [
                    QuantoField(
                      label: 'Nome',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: TextField(
                        controller: _descriptionController,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          labelStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Anexar certificado'),
                            Icon(
                              CupertinoIcons.paperclip,
                              size: 20,
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Enviar'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}

Widget dialogBox(BuildContext context) {
  return SizedBox(
    width: 250,
    height: 120,
    child: SizedBox(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, 'download'),
                child: const Text('Baixar documento'),
              ),
            ],
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'refuse'),
                  child: const Text('Recusar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'accept'),
                  child: const Text('Aceitar'),
                ),
              ])
        ],
      ),
    ),
  );
}
