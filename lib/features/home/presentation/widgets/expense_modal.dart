import 'package:expense_tracker/core/common/widgets/input_field.dart';
import 'package:expense_tracker/core/common/widgets/submit_button.dart';
import 'package:expense_tracker/core/constants/categories.dart';
import 'package:expense_tracker/core/dependencies/inject_dependencies.dart';
import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/date.dart';
import 'package:expense_tracker/core/utils/show_snackbar.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/presentation/blocs/expense/expense_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseModal extends StatefulWidget {
  final Expense? expense;
  const ExpenseModal({
    super.key,
    this.expense,
  });

  @override
  State<ExpenseModal> createState() => _ExpenseModalState();
}

class _ExpenseModalState extends State<ExpenseModal> {
  int? _selectedCategory;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormState>();

  final _user = serviceLocator<FirebaseAuth>().currentUser;

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expense != null) {
      amountController.text = widget.expense!.amount.toString();
      descriptionController.text = widget.expense!.description;
      _selectedCategory = widget.expense!.categoryId;
      _selectedDate = widget.expense!.date;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 14,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownMenu<int>(
              width: MediaQuery.of(context).size.width * .93,
              inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorPallette.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorPallette.primary,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorPallette.danger,
                  ),
                ),
              ),
              initialSelection: _selectedCategory,
              dropdownMenuEntries: Categories.getCategories()
                  .map(
                    (e) => DropdownMenuEntry<int>(
                      value: e.id,
                      label: e.name,
                      leadingIcon: Icon(e.icon),
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              hintText: 'Category',
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              controller: amountController,
              hintText: 'Amount',
              borderColor: ColorPallette.primary,
              textColor: ColorPallette.primary,
              keyboard: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              controller: descriptionController,
              hintText: 'Description',
              borderColor: ColorPallette.primary,
              textColor: ColorPallette.primary,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPallette.primary,
                foregroundColor: ColorPallette.primaryShade3,
                shape: const ContinuousRectangleBorder(),
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
              ),
              onPressed: () async {
                _selectedDate = await Date.selectDate(context);
                setState(() {});
              },
              label: Text(
                _selectedDate != null
                    ? Date.convertDate(
                        _selectedDate!,
                        'dd/MM/yyyy',
                      )
                    : 'Select date',
              ),
              icon: const Icon(
                Icons.calendar_month_outlined,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SubmitButton(
              onTap: () {
                if (_formKey.currentState!.validate() &&
                    _selectedDate != null &&
                    _selectedCategory != null) {
                  Navigator.pop(context);
                  if (widget.expense == null) {
                    BlocProvider.of<ExpenseBloc>(context).add(
                      AddExpenseEvent(
                        userId: _user!.uid,
                        amount: double.tryParse(amountController.text.trim()) ??
                            0.00,
                        categoryId: _selectedCategory!,
                        description: descriptionController.text,
                        date: _selectedDate!,
                      ),
                    );
                  } else {
                    BlocProvider.of<ExpenseBloc>(context).add(
                      UpdateExpenseEvent(
                        expenseId: widget.expense!.expenseId,
                        amount: double.tryParse(amountController.text.trim()) ??
                            0.00,
                        categoryId: _selectedCategory!,
                        description: descriptionController.text,
                        date: _selectedDate!,
                      ),
                    );
                  }
                } else {
                  showSnackBar(
                    context: context,
                    message: "Please fill all fields.",
                  );
                }
              },
              buttonText:
                  widget.expense == null ? 'Add Expense' : 'Update Expense',
              bgColor: ColorPallette.primary,
            ),
          ],
        ),
      ),
    );
  }
}
