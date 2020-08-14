import 'package:flutter/foundation.dart';

class MainPageProvider extends ChangeNotifier {
  List<String> countryList;
}

class CountryData {
  String name;
  int totalInfectedCases;
  int totalRecoverdCases;
  int totalDeathCases;
  List<InfoInDay> inforIn7Days;

  CountryData({
    this.name,
    this.totalInfectedCases,
    this.totalRecoverdCases,
    this.totalDeathCases,
    this.inforIn7Days,
  });
}

// information about cases in day
class InfoInDay {
  String day;
  int infectedCases;
  int recoverdCases;
  int deathCases;

  InfoInDay({
    this.day,
    this.infectedCases,
    this.recoverdCases,
    this.deathCases,
  });
}

class AvoidInfectionAction {
  String actions;
  String imgPath;

  AvoidInfectionAction({@required this.actions, this.imgPath});
}
