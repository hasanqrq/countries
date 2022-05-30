import 'package:flutter/material.dart';


class CountryList extends StatelessWidget {
  Map<String, dynamic> country;

  // ignore: use_key_in_widget_constructors
  CountryList(this.country);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: country.length,
          itemBuilder: (context, index) {
            String key = country.keys.elementAt(index);

            return Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(15.0),
                ),
                Text('$key : '),
                Text(country[key].toString())
              ],
            );
          }),
    );
  }
}
