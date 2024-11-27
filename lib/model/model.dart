import 'package:flutter/material.dart';

enum Category { food, leisure, investment, fitness }

final categoryIcon = {
  Category.fitness: Icons.sports_gymnastics_sharp,
  Category.leisure: Icons.tv,
  Category.investment: Icons.attach_money,
  Category.food: Icons.local_pizza,
};

class ExpenseModel {
  final String taskName;
  final Category category;

  final IconData icon;
  final double amount;

  ExpenseModel(
      {required this.category,
      required this.icon,
      required this.taskName,
      required this.amount});
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenes});
  final Category category;

  final List<ExpenseModel> expenes;
  ExpenseBucket.forCategory(List<ExpenseModel> allExpense, this.category)
      : expenes = allExpense
            .where((expense) => expense.category == category)
            .toList();

  double get totalSum {
    double sum = 0;
    for (final expense in expenes) {
      sum += expense.amount;
    }
    return sum;
  }
}
