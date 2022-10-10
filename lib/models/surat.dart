import 'package:http/http.dart';
import 'dart:convert';

class surat{

  Future getSuratData() async {
    Response response = await get(Uri.parse('https://equran.id/api/surat'));
    List suratData = jsonDecode(response.body);
    print(suratData[1]['nama_latin']);
    return suratData;
  }
}
