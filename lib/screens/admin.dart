import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quanto_falta_front/api/certificateapi.dart';
import 'package:quanto_falta_front/core/ui/theme_extensions.dart';
import 'package:quanto_falta_front/core/widget/quanto_field.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _descriptionController = TextEditingController();

    Map<dynamic, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;

    List<Widget> createLabelButtons(List<dynamic> labels) {
      return labels.map<Widget>((label) {
        String capitalizedLabel =
            label['name'][0].toUpperCase() + label['name'].substring(1);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 300, // Adjust this value as needed
              minHeight: 70, // Adjust this value as needed
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[200],
                padding: EdgeInsets.all(6.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.black), // Black border
                ),
              ),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(capitalizedLabel),
                  content: Text(label['email'] ?? ""),
                  actions: <Widget>[
                    dialogBox(context, label, arguments?['JWT']),
                  ],
                ),
              ),
              child: Text(
                capitalizedLabel,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      }).toList();
    }

    var verifiedLabels =
        json.decode(arguments?['validados'].body)['certificados'];
    var notVerifiedLabels =
        json.decode(arguments?['nValidados'].body)['certificados'];

    List<Widget> labelButtons = createLabelButtons(verifiedLabels);
    List<Widget> notVerifiedlabelButtons =
        createLabelButtons(notVerifiedLabels);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: context.primaryColor),
          backgroundColor: const Color(0xFFFAFBFE),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFFAFBFE),
        // drawer: HomeDrawer(),
        body: SingleChildScrollView(
            child: Column(children: [
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
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 8.0,
                children: notVerifiedlabelButtons,
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
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 8.0,
                children: labelButtons,
              ),
            ),
          ),
        ])));
  }
}

Widget dialogBox(BuildContext context, dynamic label, String JWT) {
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
                onPressed: () {
                  CertificateAPI.download(
                      filename:
                          label['file'].split(Platform.pathSeparator).last,
                      JWT: JWT);
                },
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
                  onPressed: () {
                    CertificateAPI.validar(id: label['_id'], JWT: JWT);
                  },
                  child: const Text('Aceitar'),
                ),
              ])
        ],
      ),
    ),
  );
}
