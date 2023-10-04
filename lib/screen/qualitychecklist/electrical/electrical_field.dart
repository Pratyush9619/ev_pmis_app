import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_pmis_app/widgets/custom_appbar.dart';
import 'package:ev_pmis_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_EP.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_acdb.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_cdi.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_charger.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_ci.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_cmu.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_ct.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_msp.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_pss.dart';
import '../../../QualityDatasource/qualityElectricalDatasource/quality_rmu.dart';
import '../../../components/Loading_page.dart';
import '../../../model/quality_checklistModel.dart';
import '../../../provider/cities_provider.dart';
import '../../../style.dart';
import '../../../widgets/activity_headings.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/quality_list.dart';
import '../../homepage/gallery.dart';
import '../../safetyreport/safetyfield.dart';

class ElectricalField extends StatefulWidget {
  String? depoName;
  String? title;
  String? fielClnName;
  int? titleIndex;
  ElectricalField(
      {super.key,
      required this.depoName,
      required this.title,
      required this.fielClnName,
      required this.titleIndex});

  @override
  State<ElectricalField> createState() => _ElectricalFieldState();
}

class _ElectricalFieldState extends State<ElectricalField> {
  String? cityName;
  Stream? _stream;
  dynamic alldata;
  late DataGridController _dataGridController;
  late QualityPSSDataSource _qualityPSSDataSource;
  late QualityrmuDataSource _qualityrmuDataSource;
  late QualityctDataSource _qualityctDataSource;
  late QualitycmuDataSource _qualitycmuDataSource;
  late QualityacdDataSource _qualityacdDataSource;
  late QualityCIDataSource _qualityCIDataSource;
  late QualityCDIDataSource _qualityCDIDataSource;
  late QualityMSPDataSource _qualityMSPDataSource;
  late QualityChargerDataSource _qualityChargerDataSource;
  late QualityEPDataSource _qualityEPDataSource;

  List<dynamic> psstabledatalist = [];
  List<dynamic> rmutabledatalist = [];
  List<dynamic> cttabledatalist = [];
  List<dynamic> cmutabledatalist = [];
  List<dynamic> acdbtabledatalist = [];
  List<dynamic> citabledatalist = [];
  List<dynamic> cditabledatalist = [];
  List<dynamic> msptabledatalist = [];
  List<dynamic> chargertabledatalist = [];
  List<dynamic> eptabledatalist = [];

  List<QualitychecklistModel> qualitylisttable1 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable2 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable3 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable4 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable5 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable6 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable7 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable8 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable9 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable10 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable11 = <QualitychecklistModel>[];
  List<QualitychecklistModel> qualitylisttable12 = <QualitychecklistModel>[];

  late TextEditingController nameController,
      docController,
      vendorController,
      dateController,
      olaController,
      panelController,
      depotController,
      customerController;

  void initializeController() {
    nameController = TextEditingController();
    docController = TextEditingController();
    vendorController = TextEditingController();
    dateController = TextEditingController();
    // dateController = TextEditingController();
    olaController = TextEditingController();
    panelController = TextEditingController();
    depotController = TextEditingController();
    customerController = TextEditingController();
  }

  @override
  void initState() {
    cityName = Provider.of<CitiesProvider>(context, listen: false).getName;

    initializeController();
    _fetchUserData();
    qualitylisttable1 = getData();
    _qualityPSSDataSource =
        QualityPSSDataSource(qualitylisttable1, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    qualitylisttable2 = rmu_getData();
    _qualityrmuDataSource =
        QualityrmuDataSource(qualitylisttable2, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    qualitylisttable3 = ct_getData();
    _qualityctDataSource =
        QualityctDataSource(qualitylisttable3, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    qualitylisttable4 = cmu_getData();
    _qualitycmuDataSource =
        QualitycmuDataSource(qualitylisttable4, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    qualitylisttable5 = acdb_getData();
    _qualityacdDataSource =
        QualityacdDataSource(qualitylisttable5, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    qualitylisttable6 = ci_getData();
    _qualityCIDataSource =
        QualityCIDataSource(qualitylisttable6, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    qualitylisttable7 = cdi_getData();
    _qualityCDIDataSource =
        QualityCDIDataSource(qualitylisttable7, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    qualitylisttable8 = msp_getData();
    _qualityMSPDataSource =
        QualityMSPDataSource(qualitylisttable8, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    qualitylisttable9 = charger_getData();
    _qualityChargerDataSource = QualityChargerDataSource(
        qualitylisttable9, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    qualitylisttable10 = earth_pit_getData();
    _qualityEPDataSource =
        QualityEPDataSource(qualitylisttable10, widget.depoName!, cityName!);
    _dataGridController = DataGridController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavbarDrawer(),
      appBar: CustomAppBar(
          title: '${widget.depoName!}/${widget.title}',
          height: 50,
          isSync: true,
          store: () {
            storeData(context, widget.depoName!, currentDate);
            FirebaseFirestore.instance
                .collection('ElectricalChecklistField')
                .doc('${widget.depoName}')
                .collection('userId')
                .doc(userId)
                .collection(widget.fielClnName!)
                .doc(currentDate)
                .set({
              'EmployeeName': nameController.text,
              'DocNo': docController.text,
              'VendorName': vendorController.text,
              'Date': dateController.text,
              'Ola No': olaController.text,
              'Panel No': panelController.text,
              'Depot Name': depotController.text,
              'Customer Name': customerController.text
            });
          },
          isCentered: false),
      body:
          // StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection('CivilQualityChecklistCollection')
          //       .doc('${widget.depoName}')
          //       .collection('userId')
          //       .doc('widget.currentDate')
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     return
          SingleChildScrollView(
        child: Column(
          children: [
            electricalField(nameController, 'Employee Name'),
            electricalField(docController, 'Dist EV'),
            electricalField(vendorController, 'Vendor Name'),
            electricalField(dateController, 'Date'),
            electricalField(olaController, 'Ola No'),
            electricalField(panelController, 'Panel No'),
            electricalField(depotController, 'Depot Name'),
            electricalField(customerController, 'Customer Name'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: StreamBuilder(
                stream: _stream,
                //  widget.titleIndex! == 0
                //     ? _stream
                //     : widget.titleIndex! == 1
                //         ? _stream1
                //         : widget.titleIndex! == 2
                //             ? _stream2
                //             : widget.titleIndex! == 3
                //                 ? _stream3
                //                 : widget.titleIndex! == 4
                //                     ? _stream4
                //                     : widget.titleIndex! == 5
                //                         ? _stream5
                //                         : widget.titleIndex! == 6
                //                             ? _stream6
                //                             : widget.titleIndex! == 7
                //                                 ? _stream7
                //                                 : widget.titleIndex! == 8
                //                                     ? _stream8
                //                                     : widget.titleIndex! == 9
                //                                         ? _stream9
                //                                         : widget.titleIndex! ==
                //                                                 10
                //                                             ? _stream10
                //                                             : _stream11,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingPage();
                  }
                  if (!snapshot.hasData || snapshot.data.exists == false) {
                    return
                        //  widget.isHeader!
                        //     ?
                        SfDataGridTheme(
                      data: SfDataGridThemeData(headerColor: blue),
                      child: SfDataGrid(
                        source: widget.titleIndex! == 0
                            ? _qualityPSSDataSource
                            : widget.titleIndex! == 1
                                ? _qualityrmuDataSource
                                : widget.titleIndex! == 2
                                    ? _qualityctDataSource
                                    : widget.titleIndex! == 3
                                        ? _qualitycmuDataSource
                                        : widget.titleIndex! == 4
                                            ? _qualityacdDataSource
                                            : widget.titleIndex! == 5
                                                ? _qualityCIDataSource
                                                : widget.titleIndex! == 6
                                                    ? _qualityCDIDataSource
                                                    : widget.titleIndex! == 7
                                                        ? _qualityMSPDataSource
                                                        : widget.titleIndex! ==
                                                                8
                                                            ? _qualityChargerDataSource
                                                            : _qualityEPDataSource,
                        // widget.titleIndex! == 10
                        //     ? _qualityRoofingDataSource
                        //     : _qualityPROOFINGDataSource,

                        //key: key,
                        allowEditing: true,
                        frozenColumnsCount: 1,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        selectionMode: SelectionMode.single,
                        navigationMode: GridNavigationMode.cell,
                        columnWidthMode: ColumnWidthMode.auto,
                        editingGestureType: EditingGestureType.tap,
                        controller: _dataGridController,

                        // onQueryRowHeight: (details) {
                        //   return details.rowIndex == 0 ? 60.0 : 49.0;
                        // },
                        columns: [
                          GridColumn(
                            columnName: 'srNo',
                            width: 80,
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: false,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Sr No',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            width: 350,
                            columnName: 'checklist',
                            allowEditing: false,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('ACTIVITY',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            columnName: 'responsibility',
                            width: 250,
                            allowEditing: true,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text('RESPONSIBILITY',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white,
                                  )),
                            ),
                          ),
                          GridColumn(
                            columnName: 'Reference',
                            allowEditing: true,
                            width: 250,
                            label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('DOCUMENT REFERENCE',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            columnName: 'observation',
                            allowEditing: true,
                            width: 200,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('OBSERVATION',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            columnName: 'Upload',
                            allowEditing: false,
                            visible: true,
                            width: 150,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Upload',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            columnName: 'View',
                            allowEditing: true,
                            width: 150,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('View',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          // GridColumn(
                          //   columnName: 'Delete',
                          //   autoFitPadding:
                          //       const EdgeInsets.symmetric(
                          //           horizontal: 16),
                          //   allowEditing: false,
                          //   visible: true,
                          //   width: 120,
                          //   label: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 8.0),
                          //     alignment: Alignment.center,
                          //     child: Text('Delete Row',
                          //         overflow:
                          //             TextOverflow.values.first,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16,
                          //             color: white)
                          //         //    textAlign: TextAlign.center,
                          //         ),
                          //   ),
                          // ),
                        ],

                        // stackedHeaderRows: [
                        //   StackedHeaderRow(cells: [
                        //     StackedHeaderCell(
                        //         columnNames: ['SrNo'],
                        //         child: Container(child: Text('Project')))
                        //   ])
                        // ],
                      ),
                    );
                    // : Center(
                    //     child: Container(
                    //       padding: EdgeInsets.all(25),
                    //       decoration: BoxDecoration(
                    //           borderRadius:
                    //               BorderRadius.circular(20),
                    //           border: Border.all(color: blue)),
                    //       child: const Text(
                    //         '     No data available yet \n Please wait for admin process',
                    //         style: TextStyle(
                    //             fontSize: 30,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   );
                  } else if (snapshot.hasData) {
                    alldata = '';
                    alldata = snapshot.data['data'] as List<dynamic>;
                    qualitylisttable1.clear();
                    alldata.forEach((element) {
                      qualitylisttable1
                          .add(QualitychecklistModel.fromJson(element));
                      if (widget.titleIndex! == 0) {
                        _qualityPSSDataSource = QualityPSSDataSource(
                            qualitylisttable1, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      } else if (widget.titleIndex! == 1) {
                        _qualityrmuDataSource = QualityrmuDataSource(
                            qualitylisttable2, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      } else if (widget.titleIndex! == 2) {
                        _qualityctDataSource = QualityctDataSource(
                            qualitylisttable3, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      } else if (widget.titleIndex! == 3) {
                        _qualitycmuDataSource = QualitycmuDataSource(
                            qualitylisttable4, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      } else if (widget.titleIndex! == 4) {
                        _qualityacdDataSource = QualityacdDataSource(
                            qualitylisttable5, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      } else if (widget.titleIndex! == 5) {
                        _qualityCIDataSource = QualityCIDataSource(
                            qualitylisttable6, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      } else if (widget.titleIndex! == 6) {
                        _qualityCDIDataSource = QualityCDIDataSource(
                            qualitylisttable7, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      } else if (widget.titleIndex! == 7) {
                        _qualityMSPDataSource = QualityMSPDataSource(
                            qualitylisttable8, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      } else if (widget.titleIndex! == 8) {
                        _qualityChargerDataSource = QualityChargerDataSource(
                            qualitylisttable9, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      } else if (widget.titleIndex! == 9) {
                        _qualityEPDataSource = QualityEPDataSource(
                            qualitylisttable10, cityName!, widget.depoName!);
                        _dataGridController = DataGridController();
                      }
                      //  else if (widget.titleIndex! == 10) {
                      //   _qualityRoofingDataSource = QualityWCRDataSource(
                      //       qualitylisttable1,
                      //       widget.depoName!,
                      //       cityName!);
                      //   _dataGridController = DataGridController();
                      // } else if (widget.titleIndex! == 11) {
                      //   _qualityPROOFINGDataSource =
                      //       QualityPROOFINGDataSource(qualitylisttable1,
                      //           widget.depoName!, cityName!);
                      //   _dataGridController = DataGridController();
                      // }
                    });
                    return SfDataGridTheme(
                      data: SfDataGridThemeData(headerColor: blue),
                      child: SfDataGrid(
                        source: widget.titleIndex! == 0
                            ? _qualityPSSDataSource
                            : widget.titleIndex! == 1
                                ? _qualityrmuDataSource
                                : widget.titleIndex! == 2
                                    ? _qualityctDataSource
                                    : widget.titleIndex! == 3
                                        ? _qualitycmuDataSource
                                        : widget.titleIndex! == 4
                                            ? _qualityacdDataSource
                                            : widget.titleIndex! == 5
                                                ? _qualityCIDataSource
                                                : widget.titleIndex! == 6
                                                    ? _qualityCDIDataSource
                                                    : widget.titleIndex! == 7
                                                        ? _qualityMSPDataSource
                                                        : widget.titleIndex! ==
                                                                8
                                                            ? _qualityChargerDataSource
                                                            : _qualityEPDataSource,
                        // : widget.titleIndex! ==
                        //         10
                        //     ? _qualityRoofingDataSource
                        // : _qualityPROOFINGDataSource,

                        //key: key,
                        allowEditing: true,
                        frozenColumnsCount: 2,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        selectionMode: SelectionMode.single,
                        navigationMode: GridNavigationMode.cell,
                        columnWidthMode: ColumnWidthMode.auto,
                        editingGestureType: EditingGestureType.tap,
                        controller: _dataGridController,

                        // onQueryRowHeight: (details) {
                        //   return details.rowIndex == 0 ? 60.0 : 49.0;
                        // },
                        columns: [
                          GridColumn(
                            columnName: 'srNo',
                            width: 80,
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: false,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Sr No',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            width: 350,
                            columnName: 'checklist',
                            allowEditing: false,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('ACTIVITY',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            columnName: 'responsibility',
                            width: 250,
                            allowEditing: true,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text('RESPONSIBILITY',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white,
                                  )),
                            ),
                          ),
                          GridColumn(
                            columnName: 'Reference',
                            allowEditing: true,
                            width: 250,
                            label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('DOCUMENT REFERENCE',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            columnName: 'observation',
                            allowEditing: true,
                            width: 200,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('OBSERVATION',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            columnName: 'Upload',
                            allowEditing: false,
                            visible: true,
                            width: 150,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Upload.',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          GridColumn(
                            columnName: 'View',
                            allowEditing: true,
                            width: 150,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('View',
                                  overflow: TextOverflow.values.first,
                                  style: tableheaderwhitecolor),
                            ),
                          ),
                          // GridColumn(
                          //   columnName: 'Delete',
                          //   autoFitPadding: const EdgeInsets.symmetric(
                          //       horizontal: 16),
                          //   allowEditing: false,
                          //   width: 120,
                          //   visible: true,
                          //   label: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 8.0),
                          //     alignment: Alignment.center,
                          //     child: Text('Delete Row',
                          //         overflow: TextOverflow.values.first,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16,
                          //             color: white)
                          //         //    textAlign: TextAlign.center,
                          //         ),
                          //   ),
                          // ),
                        ],

                        // stackedHeaderRows: [
                        //   StackedHeaderRow(cells: [
                        //     StackedHeaderCell(
                        //         columnNames: ['SrNo'],
                        //         child: Container(child: Text('Project')))
                        //   ])
                        // ],
                      ),
                    );
                  } else {
                    // here w3e have to put Nodata page
                    return LoadingPage();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      //  },
      //),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => ElectricalTable(
      //             depoName: widget.depoName,
      //             title: widget.title,
      //             titleIndex: widget.titleIndex,
      //           ),
      //         ));
      //   },
      //   label: const Text('Proceed to Sync'),
      // ),
    );
  }

  Widget electricalField(TextEditingController controller, String title) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: CustomTextField(
          controller: controller,
          labeltext: title,
          validatortext: '$title is Required',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next),
    );
  }

  storeData(BuildContext context, String depoName, String currentDate) {
    Map<String, dynamic> pssTableData = Map();
    Map<String, dynamic> rmuTableData = Map();
    Map<String, dynamic> ctTableData = Map();
    Map<String, dynamic> cmuTableData = Map();
    Map<String, dynamic> acdbTableData = Map();
    Map<String, dynamic> ciTableData = Map();
    Map<String, dynamic> cdiTableData = Map();
    Map<String, dynamic> mspTableData = Map();
    Map<String, dynamic> chargerTableData = Map();
    Map<String, dynamic> epTableData = Map();

    for (var i in _qualityPSSDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button' ||
            data.columnName == 'View' ||
            data.columnName != 'Delete') {
          pssTableData[data.columnName] = data.value;
        }
      }

      psstabledatalist.add(pssTableData);
      pssTableData = {};
    }

    FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc(depoName)
        .collection('PSS TABLE DATA')
        .doc('PSS')
        .collection(userId!)
        .doc(currentDate)
        .set({
      'data': psstabledatalist,
    }).whenComplete(() {
      psstabledatalist.clear();
      for (var i in _qualityrmuDataSource.dataGridRows) {
        for (var data in i.getCells()) {
          if (data.columnName != 'button' ||
              data.columnName == 'View' ||
              data.columnName != 'Delete') {
            rmuTableData[data.columnName] = data.value;
          }
        }
        rmutabledatalist.add(rmuTableData);
        rmuTableData = {};
      }

      FirebaseFirestore.instance
          .collection('ElectricalQualityChecklist')
          .doc(depoName)
          .collection('RMU TABLE DATA')
          .doc('RMU')
          .collection(userId!)
          .doc(currentDate)
          .set({
        'data': rmutabledatalist,
      }).whenComplete(() {
        rmutabledatalist.clear();
        for (var i in _qualityctDataSource.dataGridRows) {
          for (var data in i.getCells()) {
            if (data.columnName != 'button' ||
                data.columnName == 'View' ||
                data.columnName != 'Delete') {
              ctTableData[data.columnName] = data.value;
            }
          }

          cttabledatalist.add(ctTableData);
          ctTableData = {};
        }

        FirebaseFirestore.instance
            .collection('ElectricalQualityChecklist')
            .doc(depoName)
            .collection('CONVENTIONAL TRANSFORMER TABLE DATA')
            .doc('CONVENTIONAL TRANSFORMER')
            .collection(userId!)
            .doc(currentDate)
            .set({
          'data': cttabledatalist,
        }).whenComplete(() {
          cttabledatalist.clear();
          for (var i in _qualitycmuDataSource.dataGridRows) {
            for (var data in i.getCells()) {
              if (data.columnName != 'button' ||
                  data.columnName == 'View' ||
                  data.columnName != 'Delete') {
                cmuTableData[data.columnName] = data.value;
              }
            }
            cmutabledatalist.add(cmuTableData);
            cmuTableData = {};
          }

          FirebaseFirestore.instance
              .collection('ElectricalQualityChecklist')
              .doc(depoName)
              .collection('CTPT METERING UNIT TABLE DATA')
              .doc('CTPT METERING UNIT')
              .collection(userId!)
              .doc(currentDate)
              .set({
            'data': cmutabledatalist,
          }).whenComplete(() {
            cmutabledatalist.clear();
            for (var i in _qualityacdDataSource.dataGridRows) {
              for (var data in i.getCells()) {
                if (data.columnName != 'button' ||
                    data.columnName != 'Delete') {
                  acdbTableData[data.columnName] = data.value;
                }
              }
              acdbtabledatalist.add(acdbTableData);
              acdbTableData = {};
            }

            FirebaseFirestore.instance
                .collection('ElectricalQualityChecklist')
                .doc(depoName)
                .collection('ACDB TABLE DATA')
                .doc('ACDB DATA')
                .collection(userId!)
                .doc(currentDate)
                .set({
              'data': acdbtabledatalist,
            }).whenComplete(() {
              acdbtabledatalist.clear();
              for (var i in _qualityCIDataSource.dataGridRows) {
                for (var data in i.getCells()) {
                  if (data.columnName != 'button' ||
                      data.columnName == 'View' ||
                      data.columnName != 'Delete') {
                    ciTableData[data.columnName] = data.value;
                  }
                }
                citabledatalist.add(ciTableData);
                ciTableData = {};
              }

              FirebaseFirestore.instance
                  .collection('ElectricalQualityChecklist')
                  .doc(depoName)
                  .collection('CABLE INSTALLATION TABLE DATA')
                  .doc('CABLE INSTALLATION')
                  .collection(userId!)
                  .doc(currentDate)
                  .set({
                'data': citabledatalist,
              }).whenComplete(() {
                citabledatalist.clear();
                for (var i in _qualityCDIDataSource.dataGridRows) {
                  for (var data in i.getCells()) {
                    if (data.columnName != 'button' ||
                        data.columnName == 'View' ||
                        data.columnName != 'Delete') {
                      cdiTableData[data.columnName] = data.value;
                    }
                  }
                  cditabledatalist.add(cdiTableData);
                  cdiTableData = {};
                }

                FirebaseFirestore.instance
                    .collection('ElectricalQualityChecklist')
                    .doc(depoName)
                    .collection('CDI TABLE DATA')
                    .doc('CDI DATA')
                    .collection(userId!)
                    .doc(currentDate)
                    .set({
                  'data': cditabledatalist,
                }).whenComplete(() {
                  cditabledatalist.clear();
                  for (var i in _qualityMSPDataSource.dataGridRows) {
                    for (var data in i.getCells()) {
                      if (data.columnName != 'button' ||
                          data.columnName == 'View' ||
                          data.columnName != 'Delete') {
                        mspTableData[data.columnName] = data.value;
                      }
                    }
                    msptabledatalist.add(mspTableData);
                    mspTableData = {};
                  }

                  FirebaseFirestore.instance
                      .collection('ElectricalQualityChecklist')
                      .doc(depoName)
                      .collection('MSP TABLE DATA')
                      .doc('MSP DATA')
                      .collection(userId!)
                      .doc(currentDate)
                      .set({
                    'data': msptabledatalist,
                  }).whenComplete(() {
                    msptabledatalist.clear();
                    for (var i in _qualityChargerDataSource.dataGridRows) {
                      for (var data in i.getCells()) {
                        if (data.columnName != 'button' ||
                            data.columnName == 'View' ||
                            data.columnName != 'Delete') {
                          chargerTableData[data.columnName] = data.value;
                        }
                      }
                      chargertabledatalist.add(chargerTableData);
                      chargerTableData = {};
                    }

                    FirebaseFirestore.instance
                        .collection('ElectricalQualityChecklist')
                        .doc(depoName)
                        .collection('CHARGER TABLE DATA')
                        .doc('CHARGER DATA')
                        .collection(userId!)
                        .doc(currentDate)
                        .set({
                      'data': chargertabledatalist,
                    }).whenComplete(() {
                      chargertabledatalist.clear();
                      for (var i in _qualityEPDataSource.dataGridRows) {
                        for (var data in i.getCells()) {
                          if (data.columnName != 'button' ||
                              data.columnName == 'View' ||
                              data.columnName != 'Delete') {
                            epTableData[data.columnName] = data.value;
                          }
                        }
                        eptabledatalist.add(epTableData);
                        epTableData = {};
                      }

                      FirebaseFirestore.instance
                          .collection('ElectricalQualityChecklist')
                          .doc(depoName)
                          .collection('EARTH TABLE DATA')
                          .doc('EARTH DATA')
                          .collection(userId!)
                          .doc(currentDate)
                          .set({
                        'data': eptabledatalist,
                      }).whenComplete(() {
                        eptabledatalist.clear();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Data are synced'),
                          backgroundColor: blue,
                        ));
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  void _fetchUserData() async {
    await FirebaseFirestore.instance
        .collection('ElectricalChecklistField')
        .doc(widget.depoName)
        .collection("userId")
        .doc(userId)
        .collection(widget.fielClnName!)
        .doc(currentDate)
        .get()
        .then((ds) {
      setState(() {
        nameController.text = ds.data()!['EmployeeName'];
        docController.text = ds.data()!['DocNo'];
        vendorController.text = ds.data()!['VendorName'];
        dateController.text = ds.data()!['Date'];
        olaController.text = ds.data()!['ola No'];
        panelController.text = ds.data()!['Panel No'];
        depotController.text = ds.data()!['Depot Name'];
        customerController.text = ds.data()!['Customer Name'];
      });
    });
  }
}