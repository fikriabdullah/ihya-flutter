import 'package:get/get.dart' as state;
import 'package:http/http.dart';
import 'dart:convert';

class QuranList extends state.GetxController{
  List _quranList= [];
  Map _ayatList = {};

  List get qList => _quranList;
  Map get aList => _ayatList;

  Future getSuratData() async {
    Response response = await get(Uri.parse('https://equran.id/api/surat'));
    List suratData = jsonDecode(response.body);
    print(suratData[1]['nama_latin']);
    _quranList = suratData;
    update();
  }

  Future getAyatData(int nomor) async{
    Response response = await get(Uri.parse('https://equran.id/api/surat/$nomor'));
    Map suratData = jsonDecode(response.body);
    _ayatList = suratData;
    update();
  }

}
