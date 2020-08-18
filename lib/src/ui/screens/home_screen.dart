import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_test/src/blocs/home_bloc.dart';
import 'package:flutter_web_test/src/models/brewery.dart';
import 'package:flutter_web_test/src/services/api_service.dart';
import 'package:flutter_web_test/src/store/dbProvider.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';

class MyHomePage extends StatefulWidget {
  final DBProvider dbProvider;

  const MyHomePage({Key key, @required this.dbProvider}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<Brewery> _breweryList = List<Brewery>();
  HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc(widget.dbProvider);
    _fetchBreweries();
    bloc.refresh();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Brewery>>(
        stream: bloc.breweries,
        builder: (context, breweriesSnapshot) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Breweries"),
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(breweriesSnapshot.data[index].name),
                    subtitle: Text(breweriesSnapshot.data[index].state),
                  );
                },
                itemCount: breweriesSnapshot.data != null ? breweriesSnapshot.data.length : 0,
              ));
        });
  }

  void _fetchBreweries() {
    Webservice().load(Brewery.all).then((breweries) => {
          // setState(() => {_breweryList = breweries})
          widget.dbProvider.saveBreweries(breweries.toList()).then((value) => bloc.refresh())
        });
  }
}
