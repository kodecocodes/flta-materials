import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';

DatabaseConnection connect() {
    return DatabaseConnection.delayed(
      Future.sync(() async {
        final sqlite3 = await WasmSqlite3.loadFromUrl(
          Uri.parse('sqlite3.wasm'),
        );

        final databaseImpl = WasmDatabase(sqlite3: sqlite3, path: 'recipes.db');
        return DatabaseConnection(databaseImpl);
      }),
    );
}