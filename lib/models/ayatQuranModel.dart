class quranModel{
  List <Ayat>? ayat;
  String namaLatin;
  String nama;
  String nomor;
  String? error;

  quranModel({required this.nama, required this.ayat, required this.namaLatin, required this.nomor});

 factory quranModel.hasError(String errorMessage){
    return quranModel(
        nama: errorMessage,
        ayat: [],
        namaLatin: errorMessage,
        nomor: errorMessage
    );
  }

  factory quranModel.fromJson(Map<String, dynamic> json){
    return quranModel(
        nama: json['nama'],
        ayat: json['ayat'],
        namaLatin: json['nama_latin'],
        nomor: json['nomor']
    );
  }
}

class Ayat{
  String nomor;
  String arab;
  String translate;

  Ayat({required this.nomor, required this.arab, required this.translate});

  factory Ayat.fromJson(
      Map<String, dynamic> json){
    return Ayat(
        nomor: json['nomor'],
        arab: json['ar'],
        translate: json['tr']
    );
  }
}