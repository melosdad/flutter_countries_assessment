import 'dart:convert';

import 'package:countries_info/classes/constants.dart';
import 'package:countries_info/routes.dart';
import 'package:flutter/material.dart';

// TODO: fetch list of countries from API and render
// Feel free to change this to a stateful widget if necessary
class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  var countries;
  bool fetchingCountries = false;
  final TextEditingController txtSearch = new TextEditingController();
  List results = [];

  fetchCountries() async {
    setState(() {
      fetchingCountries = true;
    });
    var results = await Constants.httpGetRequest(Constants.baseUrl);
    var allCountries = json.decode(results);
    setState(() {
      countries = allCountries;
      fetchingCountries = false;
    });
  }

  Widget showWhichData(var countries) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: countries == null ? 0 : countries.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              leading: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 80,
                  ),
                  Image.network(
                      Constants.imgUrl +
                          countries[i]['alpha2Code'].toString().toLowerCase() +
                          ".png",
                      width: 80,
                      height: 50,
                      fit: BoxFit.fill
                      // placeholderBuilder: (context) =>
                      //     CircularProgressIndicator(),
                      ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueGrey,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(-1.0, 1.0))
                              ]),
                          child: Text(
                            countries[i]['alpha2Code'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )))
                ],
              ),
              title: Text(countries[i]['name']),
              subtitle: Text(countries[i]['capital']),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () => Constants.moreInfo(context, countries[i]),
            ),
          );
        });
  }

  void searchForCountry(term) {
    setState(() {
      results.clear();

      for (var country in countries) {
        if (country['name']
            .toString()
            .toLowerCase()
            .contains(term.toString().toLowerCase())) {
          results.add(country);
        }
      }
    });
    print(results.length);
  }

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries"),
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.about)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: fetchingCountries
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Fetching countries...')
                  ],
                ),
              )
            : countries.length > 0
                ? Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(1.0, 1.0))
                                ],
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                  controller: txtSearch,
                                  decoration: InputDecoration(
                                      hintText: "Search Countries",
                                      border: InputBorder.none),
                                  onChanged: (term) => searchForCountry(term),
                                ),
                              )),
                          Positioned(
                            right: 15,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: Icon(
                                Icons.close,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  txtSearch.text = '';
                                  results.clear();
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: results.length > 0
                            ? showWhichData(results)
                            : showWhichData(countries),
                      ),
                    ],
                  )
                : Center(
                    child: Text("Countries not found."),
                  ),
      ),
    );
  }
}
