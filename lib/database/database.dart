import 'package:expensentracker/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DataBase {
  var box = Hive.box('jay'); //representation of the database
  List<ExpenseModel> allData = [
    ExpenseModel(
        category: Category.food,
        icon: Icons.local_pizza,
        taskName: "jay",
        amount: 12),
    ExpenseModel(
        category: Category.food,
        icon: Icons.local_pizza,
        taskName: "jay",
        amount: 12),
    ExpenseModel(
        category: Category.food,
        icon: Icons.local_pizza,
        taskName: "jay",
        amount: 12),
    ExpenseModel(
        category: Category.food,
        icon: Icons.local_pizza,
        taskName: "jay",
        amount: 12),
    ExpenseModel(
        category: Category.food,
        icon: Icons.local_pizza,
        taskName: "jay",
        amount: 12),
  ];

  void getData() {
    final data = box.get('database', defaultValue: []);
    if (data is List) {
      allData = List<ExpenseModel>.from(data);
    } else {
      allData = [];
    }
  }

  void update() {
    // allData.add(ex);
    box.put('database', allData);
  }

  void delete(int index) {
    box.deleteAt(index);
  }
}
