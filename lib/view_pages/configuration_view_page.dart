import 'package:flutter/material.dart';
import 'package:jny_library_showcase/controllers/configuration_page_controller.dart';

class ConfigurationViewPage extends StatelessWidget {
  final ConfigurationPageController controller;

  const ConfigurationViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Configuration",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: TextField(
                controller: controller.pairingIDTEC,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Device Pairing ID",
                ),
                onSubmitted: (_) => controller.savePairingID(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}