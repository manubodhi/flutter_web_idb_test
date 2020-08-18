import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_web_test/src/models/brewery.dart';
import 'package:idb_shim/idb.dart';
import 'package:tekartik_common_utils/map_utils.dart';

const String dbName = 'brewery.db';

const int kVersion1 = 1;

String fieldTitle = 'title';
String fieldDescription = 'description';

class DBProvider{
  final IdbFactory idbFactory;
  Database db;

  static final String storeName = "breweries";

  DBProvider({@required this.idbFactory});

  Future open() async{
    db = await idbFactory.open(dbName, version: kVersion1, onUpgradeNeeded: onUpgradeNeeded);
  }

  void onUpgradeNeeded(VersionChangeEvent event) {
    var db = event.database;
    db.createObjectStore(storeName, autoIncrement: true);
  }

  ObjectStore get breweriesWritableTxn {
    var txn = db.transaction(storeName, idbModeReadWrite);
    var store = txn.objectStore(storeName);
    return store;
  }

  ObjectStore get breweriesReadableTxn {
    var txn = db.transaction(storeName, idbModeReadOnly);
    var store = txn.objectStore(storeName);
    return store;
  }

  Future<List<Brewery>> getBreweries() async {
    // devPrint('getting $offset $limit');
    var list = <Brewery>[];
    var store = breweriesReadableTxn;
    // ignore: cancel_subscriptions
    StreamSubscription subscription;
    subscription = store
        .openCursor(direction: idbDirectionPrev, autoAdvance: true)
        .listen((cursor) {
      try {
        var map = asMap<String, dynamic>(cursor.value);

        if (map != null) {
          var note = cursorToBrewery(cursor);
          // devPrint('adding ${note}');
          list.add(note);
        }
      } catch (e) {
        // devPrint('error getting list notes $e');
      }
    });
    await subscription.asFuture();
    return list;
  }

  Brewery cursorToBrewery(CursorWithValue/*<int, Map<String, dynamic>>*/ cursor) {
  Brewery brewery;
  var snapshot = asMap(cursor.value);
  if (snapshot != null) {
    brewery = Brewery.fromMap(snapshot, cursor.primaryKey as int);
  }
  return brewery;
}

Future saveBreweries(List<Brewery> breweries) async {
    var store = breweriesWritableTxn;
    for (var i = 0; i < breweries.length; i++) {
    if (breweries[i].id != null) {
      await store.put(breweries[i].toMap(), breweries[i].id);
    } else {
      breweries[i].id = await store.add(breweries[i].toMap()) as int;
    }  
    }
    
  }


}