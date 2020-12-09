import 'dart:convert';

import 'package:countries_info/classes/constants.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class CountryDetailPage extends StatefulWidget {
  final countryData;

  CountryDetailPage(this.countryData);
  @override
  _CountryDetailPageState createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  bool fetchingDetails = false;
  List borderingCountries = [];

  getBorderingCountryDetails(String alpha3Code) async {
    var results =
        await Constants.httpGetRequest(Constants.searchUrl + alpha3Code);
    var country = json.decode(results);
    borderingCountries.add(country);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (var border in widget.countryData['borders']) {
      getBorderingCountryDetails(border);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.countryData['name']), actions: [
        IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.about)),
      ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(widget.countryData['alpha2Code']),
                    ),
                    title: Text(widget.countryData['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                    subtitle: Text(widget.countryData['subregion']),
                  ),
                  Image.network(
                      Constants.imgUrl +
                          widget.countryData['alpha2Code']
                              .toString()
                              .toLowerCase() +
                          ".png",
                      fit: BoxFit.fill
                      // placeholderBuilder: (context) =>
                      //     CircularProgressIndicator(),
                      ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                        "${widget.countryData['name']} covers an area of ${widget.countryData['area']} km^2 and has a population of ${widget.countryData['population']} - the nation has a Gini coefficient of ${widget.countryData['gini']}. A resident of ${widget.countryData['name']} is called a ${widget.countryData['demonym']}. The main currency accepted as a legal tender is the ${widget.countryData['currencies'][0]['name']} which is expressed with the symbol '${widget.countryData['currencies'][0]['symbol']}'"),
                  )
                ],
              ),
            ),
            Card(
                child: ListTile(
              leading: Icon(
                Icons.location_on,
                size: 40,
              ),
              title: Text("Sub-region"),
              subtitle: Text(widget.countryData['subregion']),
            )),
            Card(
                child: ListTile(
              leading: Icon(Icons.location_city, size: 40),
              title: Text("Capital"),
              subtitle: Text(widget.countryData['capital']),
            )),
            SizedBox(
              height: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  title: Text("Languages",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  subtitle: Text(
                      "${widget.countryData['languages'].length.toString()} in total"),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: GridView.builder(
                // shrinkWrap: true,
                itemCount: widget.countryData['languages'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                shrinkWrap: true,

                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.lightBlue,
                              Colors.blue,
                              Colors.blueAccent
                            ],
                            stops: [0.0, 0.4, 0.7],
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.countryData['languages'][index]['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "(${widget.countryData['languages'][index]['nativeName']})",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: ListTile(
                  leading: Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  title: Text("Bordering Countries",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  subtitle:
                      Text("${borderingCountries.length.toString()} in total"),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: borderingCountries == null
                        ? 0
                        : borderingCountries.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40)),
                              child: Image.network(
                                Constants.imgUrl +
                                    borderingCountries[i]['alpha2Code']
                                        .toString()
                                        .substring(0, 2)
                                        .toLowerCase() +
                                    ".png",
                                fit: BoxFit.fill,
                              )),
                        ),
                        onTap: () =>
                            Constants.moreInfo(context, borderingCountries[i]),
                      );
                    })),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
