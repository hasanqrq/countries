import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'apiconstants.dart';
import 'countryDataModel.dart';
import 'countryListTile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iso_countries/country.dart';

class CountryDetails extends StatefulWidget {
  final Country selectedCountry;

  CountryDetails({required this.selectedCountry});

  @override
  State<StatefulWidget> createState() {
    return _CountryDetailState();
  }
}

class _CountryDetailState extends State<CountryDetails> {
  late CountryDataModel countryDetail;

  fetchData() async {
    Dio dio = Dio();
    var url = '$baseURL$codeRoute${widget.selectedCountry.countryCode}';
    Response response = await dio.get(url);

    print(response.data);

    setState(() {
      countryDetail = CountryDataModel.fromJson(response.data);
    });

    print(countryDetail);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (countryDetail == null) {
      return Scaffold(
        appBar:  AppBar(
          title: const Text("Loading..."),
        ),
      );
    }
    var scaffold = Scaffold(
        appBar: AppBar(
          title: const Text('Country Details'),
        ),
        body: Builder(
          builder: (context) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 300,
                      width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SvgPicture.network(
                          countryDetail.flag,
                          placeholderBuilder: (BuildContext context) => Container(
                              padding: const EdgeInsets.all(30.0),
                              child: const CircularProgressIndicator()),
                        ),
                      ),
                    ),
                   const  Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                   const  SizedBox(height: 10.0,),
                    Row(
                      children: <Widget>[Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(countryDetail.name, textAlign: TextAlign.left, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      )],
                    ),
                    const SizedBox(height: 5.0,),
                    CountryList(countryDetail.data),
                  ],
                ),
              ),
        ));
    return scaffold;
  }
}
