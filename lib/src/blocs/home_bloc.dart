import 'package:flutter_web_test/src/models/brewery.dart';
import 'package:flutter_web_test/src/store/dbProvider.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final DBProvider dbProvider;

  HomeBloc(this.dbProvider);
  final _subject = BehaviorSubject<List<Brewery>>();

  ValueStream<List<Brewery>> get breweries => _subject;

  Future refresh() async {
    _subject.add(await dbProvider.getBreweries());
  }

  void dispose() {
    _subject.close();
  }
}