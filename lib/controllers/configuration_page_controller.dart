import 'package:flutter/material.dart';
import 'package:jny_library_showcase/services/local/functions/dialog_functions.dart';
import 'package:jny_library_showcase/services/local/functions/route_functions.dart';
import 'package:jny_library_showcase/services/local/functions/shared_prefs_functions.dart';
import 'package:jny_library_showcase/view_pages/configuration_view_page.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => ConfigurationPageController();
}

class ConfigurationPageController extends State<ConfigurationPage> {
  TextEditingController pairingIDTEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    checkPairingID();
  }

  Future checkPairingID() async {
    await SharedPrefsFunctions.readData('pairingID').then((pairingIDResult) {
      if(pairingIDResult != null) {
        setState(() {
          pairingIDTEC.text = pairingIDResult;
        });
      }
    });
  }

  savePairingID() async {
    await SharedPrefsFunctions.writeData('pairingID', pairingIDTEC.text).then((writeResult) {
      if(writeResult == true) {
        OkDialog(
          context: context,
          content: "Success saving Pairing ID",
          headIcon: true,
          okPressed: () => CloseBack(context: context).go(),
        ).show();
      } else {
        OkDialog(
          context: context,
          content: "Failed to save Pairing ID",
          headIcon: false,
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConfigurationViewPage(controller: this);
  }
}