import '../models/ayatQuranModel.dart';
import 'package:http/http.dart';
import 'dart:convert';

class quranApiProvider{
  Future<quranModel> fetchQuranlist (int nomor)async{
    try{
      Response response = await get(Uri.parse('https://equran.id/api/surat/${nomor}'));
      Map<String, dynamic> suratData = jsonDecode(response.body);
      //print(suratData[1]['nama_latin']);
      return quranModel.fromJson(suratData);
    }catch(error, stacktrace){
      print("exception occured : $error, stacktrace: $stacktrace");
     return quranModel.hasError("Data Not Found");
    }
  }
}