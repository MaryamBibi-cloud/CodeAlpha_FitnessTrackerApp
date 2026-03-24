import 'package:flutter/material.dart';

void main() {
  runApp(FitnessApp());
}

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FitnessHome(),
    );
  }
}

class FitnessEntry {
  String exercise;
  int minutes;
  int calories;

  FitnessEntry(this.exercise, this.minutes, this.calories);
}

class FitnessHome extends StatefulWidget {
  @override
  _FitnessHomeState createState() => _FitnessHomeState();
}

class _FitnessHomeState extends State<FitnessHome> {
  List<FitnessEntry> entries = [];

  final exerciseController = TextEditingController();
  final minutesController = TextEditingController();
  final caloriesController = TextEditingController();

  void addEntry() {
    if (exerciseController.text.isEmpty) return;

    setState(() {
      entries.add(
        FitnessEntry(
          exerciseController.text,
          int.tryParse(minutesController.text) ?? 0,
          int.tryParse(caloriesController.text) ?? 0,
        ),
      );
      exerciseController.clear();
      minutesController.clear();
      caloriesController.clear();
    });
  }

  int totalCalories() {
    return entries.fold(0, (sum, item) => sum + item.calories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Tracker"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: exerciseController,
              decoration: InputDecoration(labelText: "Exercise"),
            ),
            TextField(
              controller: minutesController,
              decoration: InputDecoration(labelText: "Minutes"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: caloriesController,
              decoration: InputDecoration(labelText: "Calories"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addEntry,
              child: Text("Add Entry"),
            ),
            SizedBox(height: 20),

            Text(
              "Total Calories Burned: ${totalCalories()}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final e = entries[index];
                  return Card(
                    child: ListTile(
                      title: Text(e.exercise),
                      subtitle:
                          Text("Minutes: ${e.minutes}, Calories: ${e.calories}"),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
