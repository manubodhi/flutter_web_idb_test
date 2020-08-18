import 'package:flutter/material.dart';
import 'package:flutter_web_test/src/store/dbProvider.dart';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';
import 'src/app.dart';

Future main() async {
  IdbFactory idbFactory;
  WidgetsFlutterBinding.ensureInitialized();
  var dbProvider = DBProvider(idbFactory: getIdbFactory());
  await dbProvider.open();
  runApp(MyApp(dbProvider: dbProvider,));
}