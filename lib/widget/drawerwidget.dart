import 'package:expensentracker/provider/stateprovider.dart';
import 'package:expensentracker/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerClass extends ConsumerStatefulWidget {
  const DrawerClass({super.key});

  @override
  ConsumerState<DrawerClass> createState() => _DrawerClassState();
}

class _DrawerClassState extends ConsumerState<DrawerClass> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    // final provider = ref.watch(prv);
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Drawer(
      backgroundColor: isDark
          ? Theme.of(context).colorScheme.onSecondary.withOpacity(1)
          : Theme.of(context).colorScheme.primaryFixedDim,
      width: 200,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryFixed),
            child: Row(
              children: [
                Text(
                  "Expense Tracker",
                  style: GoogleFonts.baloo2(
                      color: isDark
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.primaryFixedDim,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SwitchListTile(
            value: value,
            onChanged: (v) {
              setState(() {
                value = v;
              });
              ref.watch(themeProvider.notifier).toggleTheme();
              // ref.watch(prv.notifier).onChanged(v);
            },
            title: Text(
              "Theme",
              style: GoogleFonts.baloo2(
                  color: isDark
                      ? Colors.white
                      : Theme.of(context).colorScheme.primaryFixedDim,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
