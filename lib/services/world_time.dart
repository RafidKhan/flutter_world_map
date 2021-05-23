import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      if (now.hour > 6 && now.hour < 18) {
        isDayTime = true;
      } else {
        isDayTime = false;
      }
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught Error: $e');
      time = 'could not get time data';
    }
  }
}
