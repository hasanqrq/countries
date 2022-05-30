class CountryDataModel {
  final Map<String, dynamic> data;
  final String name;
  final String currency;
  final String unicodeFlag;
  final String flag;
  final String dialCode;
  

  CountryDataModel(
      {required this.data,
      required this.name,
      required this.currency,
      required this.unicodeFlag,
      required this.flag,
      required this.dialCode});
     
  factory CountryDataModel.fromJson(Map<String, dynamic> json) {
    return CountryDataModel(
      data: {
        'NAME': json['name'],
        'CURRENCY': json['currency'],
        'UNICODEFLAG': json['unicodeFlag'],
        'FLAG': json['flag'],
        'DIALCODE': json['dialCode'],
      },
      name: json['name'],
      currency: json['currency'],
      unicodeFlag: json['unicodeFlag'],
      flag: json['flag'],
      dialCode: json['dialCode'],
   
    );
  }
}
