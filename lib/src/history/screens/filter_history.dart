import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salary_app/src/history/controllers/TeamHistoryController.dart';
import 'package:salary_app/src/history/screens/team_history.dart';
import 'package:salary_app/src/salaries/models/plank.dart';
import 'package:salary_app/src/salaries/models/team_member.dart';
import 'package:salary_app/src/salaries/models/worker.dart';
import 'package:salary_app/src/salaries/screens/update_salaries.dart';

class FilterHistory extends StatelessWidget {
  const FilterHistory({
    Key? key,
    required this.planks,
    required this.members,
    required this.teams,
  }) : super(key: key);

  final List<Plank> planks;
  final List<TeamMember> members;
  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Filter"),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Teams"),
              ),
              Tab(
                child: Text("Planks"),
              ),
              Tab(
                child: Text("Employees"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: teams.length,
              itemBuilder: (context, i) {
                Team el = teams[i];
                double totalVolume = 0.0;
                for (var value in el.planks) {
                  totalVolume += value.volume;
                }
                return GestureDetector(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: Text(
                          DateFormat("dd/M/yyyy").format(el.createDate),
                        ),
                        scrollable: true,
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              el.brigade.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TeamTable(
                              team: el,
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Tara",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SelectableText(
                              "Kopeja kubatura: " +
                                  totalVolume.toStringAsFixed(3),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            PlankTable(planks: el.planks),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Container(
                      width: context.width,
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            DateFormat("dd/M/yyyy").format(el.createDate),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16.0),
                          Text(
                            el.brigade.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          IconButton(
                            onPressed: () => Get.to(
                              () => UpdateSalaries(team: el),
                            ),
                            icon: Icon(Icons.edit),
                          ),
                          SizedBox(width: 8.0),
                          IconButton(
                            onPressed: () =>
                                TeamHistoryController.to.removeTeam(el),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  PlankTable(planks: planks),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
