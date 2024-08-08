import 'package:expense_tracker/core/dependencies/inject_dependencies.dart';
import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/date.dart';
import 'package:expense_tracker/core/utils/loader.dart';
import 'package:expense_tracker/core/utils/show_snackbar.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/presentation/blocs/expense/expense_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final _user = serviceLocator<FirebaseAuth>().currentUser;

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  void _fetchExpenses() {
    if (_user != null) {
      context.read<ExpenseBloc>().add(FetchExpenseEvent(userId: _user.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 14),
        child: BlocConsumer<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            if (state is ExpenseLoading) {
              Loader.circular(context);
            } else {
              Loader.hide(context);
            }
            if (state is ExpenseFailure) {
              showSnackBar(context: context, message: state.error);
            }
            if(state is ExpenseAddSuccess){
              _fetchExpenses();
            }
          },
          builder: (context, state) {
            if (state is ExpensesFetchSuccess) {
              return _buildChart(state.expenses);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildChart(List<Expense> expenses) {
    final chartData = _processExpenses(expenses);
    final chartDataList = _prepareChartData(chartData);
    final maxY = chartDataList.map((e) => e['y'] as double).reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          border: const Border(
            left: BorderSide(color: ColorPallette.primaryShade2),
            bottom: BorderSide(color: ColorPallette.primaryShade2),
          ),
        ),
        backgroundColor: ColorPallette.primaryShade3,
        minY: 0,
        maxY: maxY * 1.2, // Add some padding to the top
        titlesData: _getTitlesData(chartDataList),
        barGroups: _createBarGroups(chartDataList, maxY),
      ),
    );
  }

  FlTitlesData _getTitlesData(List<Map<String, dynamic>> chartDataList) {
    return FlTitlesData(
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(
              value.toInt().toString(),
              style: const TextStyle(fontSize: 10, color: ColorPallette.primaryShade2),
            ),
          ),
          reservedSize: 40,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(
              chartDataList[value.toInt()]['x'],
              style: const TextStyle(fontSize: 10, color: ColorPallette.primaryShade2),
            ),
          ),
          reservedSize: 30,
        ),
      ),
    );
  }

  Map<String, double> _processExpenses(List<Expense> expenses) {
    final Map<String, double> chartData = {};
    for (final expense in expenses) {
      final String month = Date.convertDate(expense.date, 'MMMM');
      chartData[month] = (chartData[month] ?? 0) + expense.amount;
    }
    return chartData;
  }

  List<Map<String, dynamic>> _prepareChartData(Map<String, double> chartData) {
    return chartData.entries
        .map((entry) => {'x': entry.key, 'y': entry.value})
        .toList();
  }

  List<BarChartGroupData> _createBarGroups(
      List<Map<String, dynamic>> chartDataList, double maxY) {
    return List.generate(chartDataList.length, (index) {
      final data = chartDataList[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data['y'],
            color: ColorPallette.primary,
            width: 24,
            borderRadius: BorderRadius.circular(2),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              color: ColorPallette.primaryShade3,
              toY: maxY,
            ),
          ),
        ],
      );
    });
  }
}