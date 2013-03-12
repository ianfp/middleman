library rockband;

import 'middleman.dart';
import 'package:unittest/unittest.dart';

class Musician {
  String name;
  int age;
  ToOne<Band> _band;

  Musician(this.name) : _band = new ToOne<Band>();
  Band get band => _band.value;
  set band(Band b) => _band.value = b;
}

class Band {
  String name;
  ToMany<Musician> _members;

  Band(this.name) : _members = new ToMany<Musician>();

  Collection<Musician> get members => _members.items;
  int get numMembers => _members.items.length;

  void addMember(Musician member) {
    _members.add(member);
    member.band = this;
  }

  void removeMember(Musician member) {
    _members.remove(member);
    member.band = null;
  }
}

void main() {
  test("rockband basic test", () {
    var band = new Band("The Beatles");
    band.addMember(new Musician("John Lennon"));
    var paul = new Musician("Paul McCartney");

    expect(band.numMembers, equals(1));
    band.removeMember(paul);
    expect(band.numMembers, equals(1));
    for ( var john in band.members ) {
      expect(john, new isInstanceOf<Musician>());
      expect(john.name, equals("John Lennon"));
      expect(john.band, equals(band));
      band.removeMember(john);
      expect(john.band, isNull);
    }
    expect(band.numMembers, equals(0));
  });
}