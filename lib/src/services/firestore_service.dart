import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salary_app/src/brigades/models/brigade.dart';
import 'package:salary_app/src/salaries/models/team_member.dart';
import 'package:salary_app/src/salaries/models/worker.dart';
import 'package:salary_app/src/settings/models/settings_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Team>> findTeams() async {
    final ref = _db.collection("teams").orderBy("createDate");
    final snapshot = await ref.get();
    final data = snapshot.docs.map((e) => e.data());
    final teams = data.map((e) => Team.fromJson(e));
    return teams.toList();
  }

  Future<void> addTeam(Team team) async {
    final ref = _db.collection("teams");
    await ref.add(team.toJson());
  }

  Future<void> createSettings(SettingsModel settingsModel) async {
    final ref = _db.collection("settings");
    await ref.add(settingsModel.toJson());
  }

  Future<void> updateSettings(SettingsModel settingsModel) async {
    final ref = _db.collection("settings");
    final snapshot = await ref.get();
    await ref.doc(snapshot.docs.first.id).set(
          settingsModel.toJson(),
          SetOptions(merge: true),
        );
  }

  Future<SettingsModel> getSettings() async {
    final ref = _db.collection("settings");
    final snapshot = await ref.get();
    final data = snapshot.docs.first;
    final settings = data.data();
    return SettingsModel.fromJson(settings);
  }

  Future<List<Brigade>> getBrigades() async {
    final ref = _db.collection("brigades");
    final snapshot = await ref.get();
    final data = snapshot.docs.map((e) => e.data());
    final brigades = data.map((e) => Brigade.fromJson(e)).toList();
    return brigades;
  }

  Future<void> addBrigade(Brigade brigade) async {
    final ref = _db.collection("brigades");
    await ref.add(brigade.toJson());
  }

  Future<void> updateTeam(Team team) async {
    final ref = _db.collection("teams");
    final snapshot = await ref.get();
    String id = "";
    for (final t in snapshot.docs) {
      if (Team.fromJson(t.data()).id == team.id) {
        id = t.id;
      }
    }

    if (id.isEmpty) {
      return;
    }

    await ref.doc(id).set(team.toJson());
  }

  Future<void> removeTeam(Team team) async {
    final ref = _db.collection("teams");
    final snapshot = await ref.get();
    final data = snapshot.docs.map((e) => e.data());
    int index = 0;
    for (final item in data) {
      if (item["id"] == team.id) {
        ref.doc(snapshot.docs[index].id).delete();
        return;
      }
      index++;
    }
  }

  Future<void> addEmployee(String name) async {
    final ref = _db.collection("employees");
    final Employee e = Employee(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
    );
    await ref.add(e.toJson());
  }

  Future<List<Employee>> getEmployees() async {
    final ref = _db.collection("employees").orderBy("name");
    final snapshot = await ref.get();
    final data = snapshot.docs.map((e) => e.data());
    final employees = data.map((e) => Employee.fromJson(e)).toList();
    return employees;
  }

  Future<void> removeEmployee(Employee e) async {
    final ref = _db.collection("employees");
    final snapshot = await ref.get();
    final data = snapshot.docs.map((e) => e.data());
    int index = 0;
    for (final item in data) {
      if (item["id"] == e.id) {
        ref.doc(snapshot.docs[index].id).delete();
        return;
      }
      index++;
    }
  }

  Future<void> removeBrigade(int id) async {
    final ref = _db.collection("brigades");
    final snapshot = await ref.get();
    final data = snapshot.docs.map((e) => e.data());
    int index = 0;
    for (final item in data) {
      if (item["id"] == id) {
        ref.doc(snapshot.docs[index].id).delete();
        return;
      }
      index++;
    }
  }
}
