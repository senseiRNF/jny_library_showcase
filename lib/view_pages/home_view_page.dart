import 'package:dpad_container/dpad_container.dart';
import 'package:flutter/material.dart';
import 'package:jny_library_showcase/controllers/home_page_controller.dart';

class HomeViewPage extends StatelessWidget {
  final HomePageController controller;

  const HomeViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "JNY Library Showcase Display"
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: DpadContainer(
                  onClick: () => controller.onClickedMenu(0),
                  onFocus: (focus) => controller.onFocusChanged(focus, 0),
                  child: InkWell(
                    onTap: () => controller.onClickedMenu(0),
                    child: Card(
                      elevation: 5.0,
                      color: controller.selectedIndex == 0 ?
                      Theme.of(context).colorScheme.primary :
                      Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Text(
                          "Main Showcase",
                          style: TextStyle(
                            color: controller.selectedIndex == 0 ? Colors.white : Colors.black,
                            fontSize: 28.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: DpadContainer(
                  onClick: () => controller.onClickedMenu(1),
                  onFocus: (focus) => controller.onFocusChanged(focus, 1),
                  child: InkWell(
                    onTap: () => controller.onClickedMenu(1),
                    child: Card(
                      elevation: 5.0,
                      color: controller.selectedIndex == 1 ?
                      Theme.of(context).colorScheme.primary :
                      Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Text(
                          "Configurations",
                          style: TextStyle(
                            color: controller.selectedIndex == 1 ? Colors.white : Colors.black,
                            fontSize: 28.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Material(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}