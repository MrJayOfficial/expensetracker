import 'package:expensentracker/model/model.dart';
import 'package:flutter/material.dart';
import 'package:expensentracker/database/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListItems extends StatefulWidget {
  ListItems({super.key, required this.expenseList,required this.onRemove});

  List<ExpenseModel> expenseList;
  // final DataBase db;
  Function(int index, BuildContext) onRemove;

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      itemCount: widget.expenseList.length,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                onPressed:(c){
                  widget.onRemove(index,c);
                  },
                icon: Icons.delete,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primaryFixedDim,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.expenseList[index].taskName,
                  style: GoogleFonts.baloo2(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  widget.expenseList[index].icon,
                  color: isDark ? Colors.black : Colors.white,
                ),
                Text(
                  "\$${widget.expenseList[index].amount.toString()}",
                  style: GoogleFonts.baloo2(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
