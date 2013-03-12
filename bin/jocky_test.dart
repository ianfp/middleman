import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';
import 'package:unittest/unittest.dart';

void main() {
  var pool = new ConnectionPool(
    user: 'jocky_test',
    password: 'jocky_test',
    db: 'music'
  );

  test("Delete test", () {
    pool.prepare("delete from musician")
      .then((Query query) {
        return query.execute();
      })
      .then((Results result) {
        print("${result.affectedRows} row(s) deleted.");
      });
  });

  test("Insert test", () {
    pool.prepare("insert into musician (name, age) values (?, ?)")
      .then((Query query) {
        query[0] = "John Lennon";
        query[1] = 51;
        return query.execute();
      })
      .then((Results result) {
        print("New ID is ${result.insertId}.");
      });
  });

  test("Select test", () {
    pool.query("select * from musician")
      .then((Results results) {
//        print("Fields are ${results.fields}");
        for (var row in results) {
          print("Row is ${row}");
        }
      });
  });
}
