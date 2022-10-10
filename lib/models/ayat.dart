import 'package:http/http.dart';
import 'dart:convert';

class ayat{

  Future getAyatData(int nomor) async{
    Response response = await get(Uri.parse('https://equran.id/api/surat/${nomor}'));
    Map suratData = jsonDecode(response.body);
    return suratData['ayat'];
  }
}