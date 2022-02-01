import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salary_app/src/monthly_salaries/controllers/monthly_salaries_controller.dart';

class MonthlySalaryFilter extends StatelessWidget {
  const MonthlySalaryFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MonthlySalariesController());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Card(
          child: Container(
            width: context.width * 0.4,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Izvelies datumus!",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 24.0,
                ),
                FormBuilder(
                  child: Column(
                    children: [
                      FormBuilderDateRangePicker(
                        name: 'date_range',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (DateTimeRange? d) {
                          controller.dateRangeFilter = d;
                        },
                        firstDate: DateTime.utc(2022, 1, 1),
                        lastDate: DateTime.utc(2023, 1, 1),
                        format: DateFormat("dd/MM/yyyy"),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.calculateSalaries();
                        },
                        child: Text("Aprekinat"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
