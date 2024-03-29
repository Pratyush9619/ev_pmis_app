import 'package:ev_pmis_app/screen/planning/project_planning.dart';
import 'package:ev_pmis_app/screen/qualitychecklist/quality_checklist.dart';
import 'package:flutter/material.dart';

class TestingAction extends StatefulWidget {
  String? role;
  String? cityName;
  String? depoName;

  TestingAction({super.key, this.cityName, this.role, this.depoName});

  @override
  State<TestingAction> createState() => _TestingActionState();
}

class _TestingActionState extends State<TestingAction> {
  Widget selectedUi = Container();

  @override
  void initState() {
    selectWidget();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return selectedUi;
  }

  Widget selectWidget() {
    switch (widget.role) {
      case 'user':
        selectedUi =
            KeyEvents(cityName: widget.cityName, depoName: widget.depoName);
        break;
      case 'admin':
        selectedUi =
            KeyEvents(cityName: widget.cityName, depoName: widget.depoName);
    }

    return selectedUi;
  }
}
