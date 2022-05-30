import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'countryDetails.dart';
import 'package:iso_countries/iso_countries.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => MyApp(),
      },
    ));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late List<Country> countries;
  late  List<Country> filteredCountries = [];
  final TextEditingController _controller = TextEditingController();
  // ignore: non_constant_identifier_names
  bool _IsSearching = false;
  Widget appBarTitle = const Text(
    "Search Country",
    style: TextStyle(color: Colors.white),
  );
  Icon icon = const Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    prepareDefaultCountries();
    super.initState();
  }

  void onTap(Country item) {
    print(item);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountryDetails(selectedCountry: item)));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> prepareDefaultCountries() async {
    List<Country> countries;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      countries = await IsoCountries.iso_countries;
    } on PlatformException {
      countries = [];
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      this.countries = countries;
      filteredCountries = countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: buildAppBar(context),
      ),
      body: ListView.builder(
          // ignore: unnecessary_null_comparison
          itemCount: filteredCountries != null ? filteredCountries.length : 0,
          itemBuilder: (context, index) {
            final country = filteredCountries[index];

            return ListTile(
              title: Text(country.name),
              subtitle: Text(country.countryCode),
              onTap: () => onTap(country),
            );
          }),
    );
    return MaterialApp(
      home: scaffold,
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (!_IsSearching) {
              icon = const Icon(
                Icons.close,
                color: Colors.white,
              );
              appBarTitle = TextField(
                controller: _controller,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.white)),
                onChanged: searchForText,
              );
              _searchStarted();
            } else {
              _searchEnded();
            }
          });
        },
      ),
    ]);
  }

  void _searchStarted() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _searchEnded() {
    setState(() {
      icon = const Icon(
        Icons.search,
        color: Colors.white,
      );
      appBarTitle = const Text(
        "Search Country",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _controller.clear();
      filteredCountries = countries;
    });
  }

  void searchForText(String searchText) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }
}
