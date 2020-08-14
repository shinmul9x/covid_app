import 'package:covid_app/widgets/custom_data_table_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  _MainState createState() => _MainState();
}

class _MainState extends State<MainPage> {
  final Color infectedBarColor = const Color(0xffff9a3c);
  final Color recoveredBarColor = const Color(0xff00f098);
  final Color deathBarColor = const Color(0xffff374f);
  final double width = 8;
  final double _maxY = 30;

  final Color componentColor = const Color(0xff333346);
  final Color textColor = const Color(0xff7589a2);

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  List<String> countryList = <String>[
    'Viet Nam',
    'Trung Quoc',
    'Hoa Ki',
    'Anh Quoc',
    'Nhat Ban'
  ];
  String _countryName;

  @override
  void initState() {
    super.initState();
    _countryName = countryList[0];

    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    showingBarGroups = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff191921),
        appBar: AppBar(
          backgroundColor: Color(0xff191921),
          elevation: 0,
          title: Text('#StayHome'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Country pick
              Card(
                color: componentColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 20,
                    top: 4,
                    bottom: 4,
                  ),
                  child: DropdownButtonFormField(
                    items: countryList
                        .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _countryName = value;
                      });
                    },
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    dropdownColor: componentColor,
                    value: _countryName,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    icon: Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // total cases
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTotalCase(
                    title: _countryName,
                    infectedCases: 1000,
                    recoverdCases: 1000,
                    deathCases: 500,
                  ),
                  SizedBox(width: 8),
                  _buildTotalCase(
                    title: 'The gioi',
                    infectedCases: 1000,
                    recoverdCases: 1000,
                    deathCases: 500,
                  ),
                ],
              ),
              SizedBox(height: 16),
              // avoid infection
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: [
              //     Row(
              //       children: [
              //         buildAvoidInfectionView('deo khau trang'),
              //         buildAvoidInfectionView('khong tu tap'),
              //         buildAvoidInfectionView('giu khoang cach 2m'),
              //       ],
              //     ),
              //     Row(
              //       children: [
              // buildAvoidInfectionView('rua tay xat khuan'),
              // buildAvoidInfectionView('uong nhieu nuoc '),
              // buildAvoidInfectionView('kiem tra y te neu sot'),
              //       ],
              //     ),
              //   ],
              // ),

              // 7 days later, chart
              Card(
                color: componentColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                    top: 16,
                    left: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: '$_countryName ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            TextSpan(
                              text: 'trong 7 ngay qua',
                              style: TextStyle(
                                color: Color(0xff7589a2),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      BarChart(
                        BarChartData(
                          barGroups: showingBarGroups,
                          maxY: _maxY,
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: SideTitles(
                              textStyle: TextStyle(color: Color(0xff7589a2)),
                              showTitles: true,
                              getTitles: (value) => '${value.toInt() + 1}/8',
                            ),
                            leftTitles: SideTitles(
                                textStyle: TextStyle(color: Color(0xff7589a2)),
                                showTitles: true,
                                getTitles: (value) {
                                  if (value != _maxY && value % 5 == 0)
                                    return '${value.toInt()}';
                                  else
                                    return '';
                                },
                                margin: 16),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawHorizontalLine: true,
                            checkToShowHorizontalLine: (value) {
                              if (value % 5 == 0)
                                return true;
                              else
                                return false;
                            },
                          ),
                          alignment: BarChartAlignment.spaceAround,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildLegendChart(
                            label: 'nhiem benh',
                            color: infectedBarColor,
                          ),
                          SizedBox(width: 8),
                          _buildLegendChart(
                            label: 'hoi phuc',
                            color: recoveredBarColor,
                          ),
                          SizedBox(width: 8),
                          _buildLegendChart(
                            label: 'tu vong',
                            color: deathBarColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Ranking
              CustomDataTable2(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('So lieu duoc thong ke boi abcxyz',
                      style: TextStyle(color: textColor)),
                ],
              ),
              Container(
                height: 200,
                child: ListView(
                  // children: countryList
                  //     .map<Widget>((e) => buildAvoidInfectionView(e))
                  //     .toList(),
                  scrollDirection: Axis.horizontal,

                  children: [
                    Container(
                      width: 150,
                      child: buildAvoidInfectionView('rua tay xat khuan'),
                    ),
                    Container(
                      width: 150,
                      child: buildAvoidInfectionView('uong nhieu nuoc '),
                    ),
                    Container(
                      width: 150,
                      child: buildAvoidInfectionView('kiem tra y te neu sot'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
            ],
          ),
        ),
      );

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 0, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: infectedBarColor,
        width: width,
      ),
      BarChartRodData(
        y: y2,
        color: recoveredBarColor,
        width: width,
      ),
      BarChartRodData(
        y: (y2 - y1).abs(),
        color: deathBarColor,
        width: width,
      ),
    ]);
  }

  Widget _buildLegendChart({Color color, String label}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 4,
            backgroundColor: color,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
                // color: Color(0xff7589a2),
                color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldOfTotalCase({String label, int numberCase, Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            // fontSize: 16,
          ),
        ),
        Text(
          numberCase.toString(),
          style: TextStyle(
            color: Colors.white,
            // fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalCase(
      {String title, int infectedCases, int recoverdCases, int deathCases}) {
    return Expanded(
      child: Card(
        color: componentColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              _buildFieldOfTotalCase(
                label: 'Nhiem benh',
                numberCase: infectedCases,
                color: infectedBarColor,
              ),
              _buildFieldOfTotalCase(
                label: 'Hoi phuc',
                numberCase: recoverdCases,
                color: recoveredBarColor,
              ),
              _buildFieldOfTotalCase(
                label: 'Tu vong',
                numberCase: deathCases,
                color: deathBarColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAvoidInfectionView(String label) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 36,
            ),
            SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
