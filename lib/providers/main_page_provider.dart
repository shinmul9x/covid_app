import 'package:flutter/foundation.dart';
import 'dart:math';

class MainPageProvider extends ChangeNotifier {
  List<CountryData> _countryDataList;

  MainPageProvider() {
    final country1 = _createCountry(
      'Viet Nam',
      100,
      90,
      10,
      _createInfo7Days(),
    );
    final country2 = _createCountry(
      'Trung quoc',
      11200,
      960,
      1120,
      _createInfo7Days(),
    );
    final country3 = _createCountry(
      'Hoa ki',
      10350,
      90,
      10130,
      _createInfo7Days(),
    );
    final country4 = _createCountry(
      'Nhat ban',
      1090,
      910,
      10,
      _createInfo7Days(),
    );
    final country5 = _createCountry(
      'Thuy si',
      10310,
      920,
      13410,
      _createInfo7Days(),
    );
    final country6 = _createCountry(
      'An do',
      1900,
      980,
      1210,
      _createInfo7Days(),
    );

    _countryDataList = [
      country1,
      country2,
      country3,
      country4,
      country5,
      country6,
    ];
    focusCountry = _countryDataList[0];
  }

  CountryData focusCountry;

  void selectCountry(String name) {
    focusCountry = _getCountryData(name);
    notifyListeners();
  }

  List<String> getCountriesName() =>
      _countryDataList.map<String>((e) => e.name).toList();

  List<CountryData> get countryDataList => _countryDataList;

  CountryData _getCountryData(String name) {
    for (var e in _countryDataList) {
      if (e.name == name) {
        return e;
      }
    }
    ;
    return _countryDataList[0];
  }

  CountryData _createCountry(
    String name,
    int infected,
    int recovered,
    int death,
    List<InfoInDay> info7Days,
  ) {
    return CountryData(
      name: name,
      totalInfectedCases: infected,
      totalRecoveredCases: recovered,
      totalDeathCases: death,
      inforIn7Days: info7Days,
    );
  }

  List<InfoInDay> _createInfo7Days() {
    var ran = Random();
    final day1 = InfoInDay(
      day: '1/8',
      infectedCases: ran.nextInt(100),
      recoveredCases: ran.nextInt(100),
      deathCases: ran.nextInt(50),
    );
    final day2 = InfoInDay(
      day: '2/8',
      infectedCases: ran.nextInt(100),
      recoveredCases: ran.nextInt(100),
      deathCases: ran.nextInt(50),
    );
    final day3 = InfoInDay(
      day: '3/8',
      infectedCases: ran.nextInt(100),
      recoveredCases: ran.nextInt(100),
      deathCases: ran.nextInt(50),
    );
    final day4 = InfoInDay(
      day: '4/8',
      infectedCases: ran.nextInt(100),
      recoveredCases: ran.nextInt(100),
      deathCases: ran.nextInt(50),
    );
    final day5 = InfoInDay(
      day: '5/8',
      infectedCases: ran.nextInt(100),
      recoveredCases: ran.nextInt(100),
      deathCases: ran.nextInt(50),
    );
    final day6 = InfoInDay(
      day: '6/8',
      infectedCases: ran.nextInt(100),
      recoveredCases: ran.nextInt(100),
      deathCases: ran.nextInt(50),
    );
    final day7 = InfoInDay(
      day: '7/8',
      infectedCases: ran.nextInt(100),
      recoveredCases: ran.nextInt(100),
      deathCases: ran.nextInt(50),
    );
    return <InfoInDay>[
      day1,
      day2,
      day3,
      day4,
      day5,
      day6,
      day7,
    ];
  }
}

class CountryData {
  String name;
  int totalInfectedCases;
  int totalRecoveredCases;
  int totalDeathCases;
  List<InfoInDay> inforIn7Days;

  CountryData({
    this.name,
    this.totalInfectedCases,
    this.totalRecoveredCases,
    this.totalDeathCases,
    this.inforIn7Days,
  });
}

// information about cases in day
class InfoInDay {
  String day;
  int infectedCases;
  int recoveredCases;
  int deathCases;

  InfoInDay({
    this.day,
    this.infectedCases,
    this.recoveredCases,
    this.deathCases,
  });
}

class AvoidInfectionAction {
  String actions;
  String imgPath;

  AvoidInfectionAction({@required this.actions, this.imgPath});
}
