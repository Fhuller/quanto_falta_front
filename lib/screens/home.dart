import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quanto_falta_front/api/certificateapi.dart';
import 'package:quanto_falta_front/core/ui/theme_extensions.dart';
// ignore: depend_on_referenced_packages
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quanto_falta_front/core/widget/quanto_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double percent = 0.1;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var _fileName = 'Anexar Certificado';

  File? fileToSend = null;

  @override
  Widget build(BuildContext context) {
    String JWT = ModalRoute.of(context)?.settings.arguments as String;

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
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Andamento',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 50,
                  child: CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: percent,
                    center: new Text(
                      "20.0%",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
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
                      'Enviar Certificado',
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
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    QuantoField(
                      label: 'Horas',
                      controller: descriptionController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null) {
                            if (result != null) {
                              setState(() {
                                _fileName = result.files.first.name.toString();
                              });
                              var pickedFile = result.files.first;
                              fileToSend = File(pickedFile.path.toString());

                              print('File name: $_fileName');
                            } else {
                              print("Sem permissão de acesso");
                            }
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(child: Text(_fileName)),
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
                        onPressed: () async {
                          if (fileToSend == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Favor enviar arquivo')));
                          } else {
                            await CertificateAPI.upload(
                              name: nameController.text,
                              description: descriptionController.text,
                              file: fileToSend,
                              JWT: JWT,
                            );
                          }
                        },
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
