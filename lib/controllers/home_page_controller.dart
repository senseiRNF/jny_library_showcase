import 'package:flutter/material.dart';
import 'package:jny_library_showcase/controllers/configuration_page_controller.dart';
import 'package:jny_library_showcase/controllers/showcase_page_controller.dart';
import 'package:jny_library_showcase/services/local/functions/route_functions.dart';
import 'package:jny_library_showcase/view_pages/home_view_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageController();
}

class HomePageController extends State<HomePage> {
  int? selectedIndex;

  onFocusChanged(bool focused, int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  onClickedMenu(int index) {
    switch(index) {
      case 0:
        MoveTo(context: context, target: const ShowcasePage()).go();
        break;
      case 1:
        MoveTo(context: context, target: const ConfigurationPage()).go();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeViewPage(controller: this);
  }
}