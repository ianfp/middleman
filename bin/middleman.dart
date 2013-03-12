library middleman;

import 'package:unittest/unittest.dart';

abstract class Relationship<T> {
  /* no members */
}

class ToOne<T>
implements Relationship<T> {
  T value;
}

class ToMany<T>
implements Relationship<T> {
  List<T> _items = new List<T>();

  Collection<T> get items => new List.from(_items);

  void add(T element) {
    _items.add(element);
  }

  void remove(T element) {
    var i = _items.indexOf(element);
    if ( i >= 0 ) {
      _items.removeAt(i);
    }
  }
}


void main() {
  test("middleman ToOne", () {
    var rel = new ToOne<int>();
    expect(rel.value, isNull);

    rel.value = 15;
    expect(rel.value, equals(15));
  });

  test("middleman ToMany", () {
    var relationship = new ToMany<String>();
    var list = relationship.items;
    expect(list.length, equals(0));
    expect(list.isEmpty, isTrue);

    relationship.add("TEST");
    list = relationship.items;
    expect(list.length, equals(1));
    expect(list.isEmpty, isFalse);
    expect(list.first, equals("TEST"));
    expect(list.last, equals("TEST"));
  });
}