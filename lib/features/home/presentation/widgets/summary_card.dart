import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expense_tracker/core/common/widgets/input_field.dart';
import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/date.dart';
import 'package:expense_tracker/features/home/domain/entities/balance.dart';
import 'package:expense_tracker/features/home/presentation/blocs/balance/balance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryCard extends StatefulWidget {
  final Balance? balance;
  final double spent;
  final DateTime date;

  final VoidCallback leftButtonAction;
  final VoidCallback rightButtonAction;

  const SummaryCard({
    super.key,
    required this.balance,
    required this.spent,
    required this.date,
    required this.leftButtonAction,
    required this.rightButtonAction,
  });

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  final TextEditingController balanceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.balance != null) {
      balanceController.text = widget.balance!.balance.toString();
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            ColorPallette.primary,
            ColorPallette.primaryShade1,
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              size: 34,
              color: ColorPallette.primaryShade3,
            ),
            onPressed: widget.leftButtonAction,
          ),
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.account_balance_outlined,
                    size: 24,
                    color: ColorPallette.greyShade4,
                  ),
                  const Icon(
                    Icons.currency_rupee_sharp,
                    size: 24,
                    color: ColorPallette.primaryShade3,
                  ),
                  Text(
                    widget.balance != null
                        ? widget.balance!.balance.toString()
                        : '0.00',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorPallette.primaryShade3,
                    ),
                  ),
                  Visibility(
                    visible: widget.balance != null,
                    child: IconButton(
                      onPressed: () => AwesomeDialog(
                        context: context,
                        dialogType: DialogType.noHeader,
                        title: 'Update balance',
                        body: Form(
                          key: _formKey,
                          child: InputField(
                            controller: balanceController,
                            hintText: 'Current balance',
                            fillColor: ColorPallette.greyShade4,
                          ),
                        ),
                        btnCancelText: 'Dismiss',
                        btnCancelOnPress: () {},
                        btnOkText: 'Update',
                        btnOkOnPress: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<BalanceBloc>(context).add(
                              UpdateBalanceEvent(
                                balanceId: widget.balance!.id,
                                balance:
                                    double.tryParse(balanceController.text) ??
                                        0,
                              ),
                            );
                          }
                        },
                      ).show(),
                      icon: const Icon(
                        Icons.add_rounded,
                        size: 30,
                        color: ColorPallette.greyShade4,
                      ),
                    ),
                  )
                ],
              ),
              const Text(
                'Current balance',
                style: TextStyle(
                  color: ColorPallette.primaryShade3,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                Date.convertDate(widget.date, 'MMMM yyyy'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: ColorPallette.primaryShade3,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.currency_rupee_sharp,
                    size: 22,
                    color: ColorPallette.primaryShade3,
                  ),
                  Text(
                    widget.spent.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: ColorPallette.primaryShade3,
                    ),
                  ),
                ],
              ),
              const Text(
                'Spent',
                style: TextStyle(
                  color: ColorPallette.primaryShade3,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_circle_right_outlined,
              size: 34,
              color: (Date.isInSameMonth(DateTime.now(), widget.date))
                  ? ColorPallette.greyShade2
                  : ColorPallette.primaryShade3,
            ),
            onPressed: (Date.isInSameMonth(DateTime.now(), widget.date))
                ? null
                : widget.rightButtonAction,
          ),
        ],
      ),
    );
  }
}
