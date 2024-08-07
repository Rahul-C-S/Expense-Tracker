import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/features/home/presentation/pages/chart_page.dart';
import 'package:expense_tracker/features/home/presentation/pages/dashboard_page.dart';
import 'package:expense_tracker/features/home/presentation/widgets/expense_modal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: ColorPallette.light,
          selectedItemColor: ColorPallette.primary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
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
            isScrollControlled: true,
            showDragHandle: true,
            context: context,
            builder: (context) => OrientationBuilder(
              builder: (context, orientation) => FractionallySizedBox(
                heightFactor:
                    (orientation == Orientation.landscape) ? 0.9 : 0.6,
                child: const SingleChildScrollView(
                  child: ExpenseModal(),
                ),
              ),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: ColorPallette.light,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _currentIndex == 0 ? const DashboardPage() : const ChartPage(),
    );
  }
}
