import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/brigades/screens/brigades_list.dart';
import 'package:salary_app/src/employees/screens/employee_editor.dart';
import 'package:salary_app/src/history/screens/team_history.dart';
import 'package:salary_app/src/monthly_salaries/screens/monthly_salary_filter.dart';
import 'package:salary_app/src/salaries/screens/salary_calculator.dart';
import 'package:salary_app/src/settings/screens/settings.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SalaryCalculator(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => SalaryCalculator(),
        ),
        GetPage(
          name: "/history",
          page: () => TeamHistory(),
        ),
        GetPage(
          name: "/settings",
          page: () => Settings(),
        ),
        GetPage(
          name: "/brigades",
          page: () => BrigadesList(),
        ),
        GetPage(
          name: "/monthly_salaries_filter",
          page: () => MonthlySalaryFilter(),
        ),
        GetPage(
          name: "/employee_editor",
          page: () => EmployeeEditor(),
        ),
      ],
    );
  }
}
