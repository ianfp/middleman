import 'package:unittest/unittest.dart';
import 'rockband.dart';
import 'middleman.dart';
import 'dart:mirrors';

class MirrorTest {

}


void main() {
  var band = new Band("ELP");
  var bandMirror = reflect(band);

  test("creating mirrors", () {
    expect(bandMirror, new isInstanceOf<Mirror>());
    expect(bandMirror, new isInstanceOf<InstanceMirror>());
    ClassMirror classMirror = bandMirror.type;
    expect(classMirror, new isInstanceOf<ClassMirror>());
    expect(classMirror.setters.length, equals(0));
    expect(classMirror.variables.length, equals(2));
    expect(classMirror.variables.containsKey("_members"), isTrue);
    expect(classMirror.qualifiedName, equals("rockband.Band"));
  });

  test("using mirrors to modify the object", () {
    ClassMirror classMirror = bandMirror.type;
    var membersMirror = classMirror.variables["_members"];
    expect(membersMirror, new isInstanceOf<VariableMirror>());
    var membersClassMirror = membersMirror.type;
    expect(membersClassMirror, new isInstanceOf<ClassMirror>());

    var future = membersClassMirror.newInstance("", []);
    future.then((InstanceMirror newVarMirror) {
      expect(newVarMirror, new isInstanceOf<InstanceMirror>());
      var newVar = newVarMirror.reflectee;
      expect(newVar, new isInstanceOf<ToMany>());
    });
  });
}