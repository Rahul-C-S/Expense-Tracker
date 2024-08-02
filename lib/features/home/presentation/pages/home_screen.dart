import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/features/home/presentation/pages/dashboard_screen.dart';
import 'package:expense_tracker/features/home/presentation/widgets/add_expense_modal.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          backgroundColor: ColorPallette.light,
          selectedItemColor: ColorPallette.primary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              label: '',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPallette.primary,
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) => const AddExpenseModal(),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: ColorPallette.light,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const DashboardScreen(),
    );
  }
}
