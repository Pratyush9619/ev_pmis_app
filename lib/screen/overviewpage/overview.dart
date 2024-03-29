import 'package:ev_pmis_app/widgets/custom_appbar.dart';
import 'package:ev_pmis_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cities_provider.dart';
import '../../shared_preferences/shared_preferences.dart';
import '../../style.dart';

class OverviewPage extends StatefulWidget {
  String? depoName;
  String? role;
  OverviewPage({super.key, required this.depoName, this.role});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  String? cityName;
  String roles = '';
  List<String> screens = [
    '/depotOverview',
    '/planning-page',
    '/material-page',
    '/daily-report',
    '/monthly-report',
    '/detailed-page',
    '/jmrPage',
    '/safety-page',
    '/quality-page',
    '/testing-page',
    // '/depotOverview',
    '/closure-page',
    '/testing-page',
  ];
  List imagedata = [
    'assets/overview_image/overview.png',
    'assets/overview_image/project_planning.png',
    'assets/overview_image/resource.png',
    'assets/overview_image/daily_progress.png',
    'assets/overview_image/monthly.png',
    'assets/overview_image/detailed_engineering.png',
    'assets/overview_image/jmr.png',
    'assets/overview_image/safety.png',
    'assets/overview_image/quality.png',
    'assets/overview_image/testing_commissioning.png',
    'assets/overview_image/closure_report.png',
    'assets/overview_image/easy_monitoring.jpg',
  ];

  @override
  void initState() {
    cityName = Provider.of<CitiesProvider>(context, listen: false).getName;
    print('Overview page - ${widget.role}');
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> desription = [
      'Overview of Project Progress Status of ${widget.depoName} Bus Charging Infra',
      'Project Planning & Scheduling Bus Depot Wise [Gant Chart] ',
      'Material Procurement & Vendor Finalization Status',
      'Submission of Daily Progress Report for Individual Project',
      'Monthly Project Monitoring & Review',
      'Detailed Engineering Of Project Documents like GTP, GA Drawing',
      'Online JMR verification for projects',
      'Safety check list & observation',
      'FQP Checklist for Civil,Electrical work & Quality Checklist',
      'Testing & Commissioning Reports of Equipment',
      'Closure Report',
      'Easy monitoring of O & M schedule for all the equipment of depots.',
    ];
    return Scaffold(
      drawer: const NavbarDrawer(),
      appBar: CustomAppBar(
        isCentered: false,
        title: '${widget.depoName}/Overview Page',
        height: 55,
        isSync: false,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        children: List.generate(desription.length, (index) {
          return GestureDetector(
              onTap: () =>
                  // Navigator.push(
                  //   context,
                  // MaterialPageRoute(
                  //   builder: (context) => MaterialProcurement(
                  //       cityName: cityName, depoName: widget.depoName),
                  // )),
                  Navigator.pushNamed(context, screens[index], arguments: {
                    'depoName': widget.depoName,
                    'role': roles,
                    'cityName': cityName
                  }),
              child: cards(desription[index], imagedata[index], index));
        }),
      ),
    );
  }

  Widget cards(String desc, String image, int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 10,
        shadowColor: blue,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(
              desc,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  void getData() async {
    roles = await StoredDataPreferences.getSharedPreferences('role');
    print('Overview - $roles');
  }
}
