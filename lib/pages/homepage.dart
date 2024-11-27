import 'package:expensentracker/database/database.dart';
import 'package:expensentracker/widget/charts.dart';
import 'package:expensentracker/widget/drawerwidget.dart';
import 'package:expensentracker/widget/listitems.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expensentracker/model/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataBase db = DataBase();
  var box = Hive.box("jay");
  TextEditingController taskName = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  void dispose() {
    taskName.dispose();
    amount.dispose();
    super.dispose();
  }

  void onRemove(int index, BuildContext c) {
    // Navigator.of(context).pop();

    setState(() {
      db.allData.removeAt(index);
      db.update();
    });
  }

  void onSubmit() {
    print("hero");
    if (taskName.text.trim().isEmpty) {
      print("Task name is empty");
      return;
    }

    if (amount.text.isEmpty || double.tryParse(amount.text) == null) {
      print("Amount is invalid");
      return;
    }

    final newExpense = ExpenseModel(
      category: selectedCategory,
      icon: categoryIcon[selectedCategory]!,
      taskName: taskName.text.trim(),
      amount: double.tryParse(amount.text)!,
    );

    setState(() {
      db.allData.add(newExpense); // Update in-memory data
      db.update();
      // db.update(); // Save to Hive database
    });

    taskName.clear();
    amount.clear();
    Navigator.of(context).pop(); // Close the dialog
  }

  @override
  void initState() {
    if (box.length != 0) {
      db.getData();
    }
    super.initState();
  }

  var selectedCategory = Category.food;
  void onAdd(BuildContext context) {
    final isTrue = MediaQuery.of(context).platformBrightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        // Use StatefulBuilder to manage state for the dialog
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              backgroundColor: isTrue
                  ? Theme.of(context).colorScheme.primaryFixed
                  : Colors.white,
              insetPadding: const EdgeInsets.all(40),
              actionsPadding: const EdgeInsets.only(
                  top: 30, bottom: 30, left: 30, right: 30),
              actions: [
                TextField(
                  controller: taskName,
                  keyboardAppearance:
                      isTrue ? Brightness.dark : Brightness.light,
                  decoration: InputDecoration(
                    label: Text(
                      "Enter the task name ",
                      style: GoogleFonts.baloo2(
                          color: isTrue ? Colors.black : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  keyboardAppearance:
                      isTrue ? Brightness.dark : Brightness.light,
                  decoration: InputDecoration(
                    label: Text(
                      "Enter the amount ",
                      style: GoogleFonts.baloo2(
                          color: isTrue ? Colors.black : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropdownButton(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryFixedDim),
                      dropdownColor:
                          isTrue ? Colors.green.shade100 : Colors.black,
                      value: selectedCategory,
                      borderRadius: BorderRadius.circular(20),
                      items: Category.values
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(
                                c.name.toString(),
                                style: GoogleFonts.baloo2(
                                    color: isTrue
                                        ? Colors.black
                                        : Theme.of(context)
                                            .colorScheme
                                            .primaryFixedDim,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (c) {
                        // Update dialog state specifically
                        setDialogState(() {
                          selectedCategory = c!;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isTrue
                            ? Colors.black
                            : Theme.of(context).colorScheme.primaryFixed,
                      ),
                      child: Text(
                        "Submit",
                        style: GoogleFonts.baloo2(
                            color: isTrue ? Colors.white : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  DrawerClass(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onAdd(context);
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Expense Tracker App"),
        ),
        body: Column(
          children: [
            const Text("children"),
            Chart(
              expenses: db.allData,
              // hashCode
              // allExpense: db.allData,
            ),
            Expanded(
              child: ListItems(
                onRemove: onRemove,
                // db: db,
                expenseList: db.allData,
              ),
            )
          ],
        ));
  }
}
