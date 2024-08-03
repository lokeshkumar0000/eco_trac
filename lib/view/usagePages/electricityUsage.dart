import 'package:electricity/services/general%20services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class TableView extends StatefulWidget {
  /// Creates the home page.
  TableView({Key? key}) : super(key: key);

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  List<DataSet> BillData = <DataSet>[];
  List<Avg> AvgBillData = <Avg>[];

  late EmployeeDataSource employeeDataSource;
  late AvgDataSource avgDataSource;

  @override
  void initState() {
    super.initState();
    BillData = getBillData();
    AvgBillData = getAvgData();
    employeeDataSource = EmployeeDataSource(employeeData: BillData);
    avgDataSource = AvgDataSource(employeeData: AvgBillData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electricity usage DataGrid'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SfDataGrid(
              allowPullToRefresh: true,
              source: employeeDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'Date',
                    label: Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Date',
                        ))),
                GridColumn(
                    columnName: 'KWH',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('KWH consumed'))),
                GridColumn(
                    columnName: 'Amount',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Amount(₹)',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'Status',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Status'))),
              ],
            ),
            // Text("Successfully you")

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SfDataGrid(
                allowColumnsResizing: true,
                allowPullToRefresh: false,
                source: avgDataSource,
                columnWidthMode: ColumnWidthMode.fill,
                rowHeight: MediaQuery.of(context).size.height * 0.04,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'Date',
                      label: Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Date',
                          ))),
                  GridColumn(
                      columnName: 'avg KWH',
                      label: Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Avg KWH',
                          ))),
                  GridColumn(
                      columnName: 'KWH',
                      label: Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text('KWH consumed'))),
                  // GridColumn(
                  //     columnName: 'Status',
                  //     label: Container(
                  //         padding: EdgeInsets.all(8.0),
                  //         alignment: Alignment.center,
                  //         child: Text('Status'))),
                ],
                allowColumnsDragging: false,
                columnResizeMode: ColumnResizeMode.onResize,
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Set your Goal..!",
                          style: TextStyles.subHeading,
                        ))))
          ],
        ),
      ),
    );
  }

  List<DataSet> getBillData() {
    return [
      DataSet("16-12-2023", 143315, 30807, false),
      DataSet("19-11-2023", 187504, 25404, true),
      DataSet("27-10-2023", 189840, 34900, true),
      DataSet("18-9-2022", 189570, 47705, true),
      DataSet("26-8-2024", 115077, 25695, true),
      DataSet("11-7-2024	", 133398, 31196, false),
      DataSet("3-6-2024", 199292, 11953, true),
      DataSet("19-5-2024	", 191577, 34565, false),
      DataSet("2-4-2022", 113242, 10740, true),
      DataSet("8-3-2022", 121781, 40254, true),
      DataSet("1-2-2022", 145289, 25831, true),
      DataSet("15-1-2022", 130724, 47604, true),
    ];
  }
}

List<Avg> getAvgData() {
  return [
    Avg("16-12-2023", 143315, 30807),
    Avg("19-11-2023", 187504, 25404),
  ];
}

class DataSet {
  DataSet(this.date, this.units_consumed, this.amount, this.status);
  final String date;
  final int units_consumed;
  final int amount;
  final bool status;
}

class Avg {
  Avg(
    this.date,
    this.units_consumed,
    this.average_units_consumed,
  );
  final String date;
  final int units_consumed;
  final int average_units_consumed;
}

/// An object to set the DataSet collection data source to the datagrid. This
/// is used to map the DataSet data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the DataSet data source class with required details.
  EmployeeDataSource({required List<DataSet> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'date',
                value: e.date,
              ),
              DataGridCell<int>(
                  columnName: 'KWH consumed', value: e.units_consumed),
              DataGridCell<int>(columnName: 'designation', value: e.amount),
              DataGridCell<String>(
                  columnName: 'salary',
                  value: e.status == true ? "Paid" : "Pending"),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    print(row);
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      print(e.value);

      return Container(
        color: e.value == "16-12-2023" ? Colors.amber : Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}

class AvgDataSource extends DataGridSource {
  /// Creates the DataSet data source class with required details.
  AvgDataSource({required List<Avg> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Date', value: e.date),
              DataGridCell<int>(
                columnName: 'Average KWH ',
                value: e.average_units_consumed,
              ),
              DataGridCell<int>(
                  columnName: 'KWH consumed this month',
                  value: e.units_consumed),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    print(row);
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      print(e.value);

      return Container(
        color: e.value == "16-12-2023" ? Colors.amber : Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
