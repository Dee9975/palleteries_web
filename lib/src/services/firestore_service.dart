import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salary_app/src/brigades/models/brigade.dart';
import 'package:salary_app/src/salaries/models/team_member.dart';
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
