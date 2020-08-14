import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class CustomDataTable2 extends StatelessWidget {
  const CustomDataTable2({Key key}) : super(key: key);

  final Color infectedBarColor = const Color(0xffff9a3c);
  final Color recoveredBarColor = const Color(0xff00f098);
  final Color deathBarColor = const Color(0xffff374f);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomDataTableProvider(),
      builder: (context, child) {
        return Card(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 4,
              top: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Thống kê số liệu',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                SizedBox(height: 8),
                DataTable(
                  showCheckboxColumn: false,
                  columnSpacing: 20,
                  horizontalMargin: 8,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Quoc gia',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Icon(
                          Icons.add_circle_outline,
                          color: infectedBarColor,
                        ),
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                        label: Expanded(
                          child: Icon(
                            Icons.favorite_border,
                            color: recoveredBarColor,
                          ),
                        ),
                        numeric: true),
                    DataColumn(
                        label: Expanded(
                          child: Icon(
                            Icons.highlight_off,
                            color: deathBarColor,
                          ),
                        ),
                        numeric: true),
                  ],
                  rows: buildDataRow(
                    context,
                    context.watch<CustomDataTableProvider>().focusData,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buildPageTableInfo(context),
                    SizedBox(width: 4),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (!context
                            .read<CustomDataTableProvider>()
                            .isFirstPage()) {
                          context
                              .read<CustomDataTableProvider>()
                              .previousPage();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (!context
                            .read<CustomDataTableProvider>()
                            .isLastPage()) {
                          context.read<CustomDataTableProvider>().nextPage();
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  DataCell buildDataCell(BuildContext context, {String label}) {
    return DataCell(
      Text(
        label,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  List<DataRow> buildDataRow(BuildContext context, List<String> list) {
    int rowsPerPage = context.watch<CustomDataTableProvider>().rowsPerPage;
    List<DataRow> dataRows = [];

    for (int i = 0; i < rowsPerPage; ++i) {
      dataRows.add(i < list.length
          ? DataRow(
              cells: [
                buildDataCell(context, label: list[i]),
                buildDataCell(context, label: '100'),
                buildDataCell(context, label: '50000'),
                buildDataCell(context, label: '10000'),
              ],
            )
          : DataRow(
              cells: [
                buildDataCell(context, label: ''),
                buildDataCell(context, label: ''),
                buildDataCell(context, label: ''),
                buildDataCell(context, label: ''),
              ],
            ));
    }
    return dataRows;
  }

  Widget buildPageTableInfo(BuildContext context) {
    var provider = context.watch<CustomDataTableProvider>();
    int lenList = provider.countryList.length;
    int start = provider.startIndex + 1;
    int end = provider.endIndex;
    return Text('$start - $end của $lenList');
  }
}

class CustomDataTableProvider extends ChangeNotifier {
  CustomDataTableProvider() {
    countryList = <String>[
      'Viet Nam',
      'Trung Quoc',
      'Hoa Ki',
      'Anh Quoc',
      'Nhat Ban',
      'Brazil',
      'Thuy si',
      'Thuy dien',
      'Phap',
      'Nga',
      'An do'
    ];
    numPages = countryList.length ~/ rowsPerPage + 1;
    changeFocusData();
  }
  List<String> countryList;

  List<String> focusData;
  int startIndex;
  int endIndex;

  int rowsPerPage = 5;
  int pageFocus = 0;
  int numPages;

  bool isFirstPage() => (pageFocus == 0);
  bool isLastPage() => (pageFocus == numPages - 1);

  void nextPage() {
    ++pageFocus;
    changeFocusData();
    notifyListeners();
  }

  void previousPage() {
    --pageFocus;
    changeFocusData();
    notifyListeners();
  }

  void changeFocusData() {
    startIndex = pageFocus * rowsPerPage;
    endIndex = (pageFocus + 1) * rowsPerPage;
    endIndex = endIndex > countryList.length ? countryList.length : endIndex;
    focusData = countryList.sublist(startIndex, endIndex);
  }
}
