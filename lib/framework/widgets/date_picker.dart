import 'package:chorale_fva/framework/utils.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../../core/constants/constants.dart';
import '../utils/logger_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    this.onChanged,
    this.errorText,
    this.controller,
    this.lastDate,
    this.label,
  });

  final String? errorText;
  final TextEditingController? controller;
  final void Function(DateTime?)? onChanged;
  final DateTime? lastDate;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: label != null ? InputDecoration(label: Text(label!)) : null,
      controller: controller,
      readOnly: true,
      onTap: () async {
        var date = controller?.text != null && controller!.text.isNotEmpty
            ? Utils.dateTimeFromString(controller!.text)!
            : DateTime.now();
        var results = await showOmniDateTimePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
          lastDate: DateTime.now().add(
            const Duration(days: 3652),
          ),
          is24HourMode: true,
          isShowSeconds: true,
          minutesInterval: 1,
          secondsInterval: 1,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          constraints: const BoxConstraints(
            maxWidth: 350,
            maxHeight: 650,
          ),
          transitionBuilder: (context, anim1, anim2, child) {
            return FadeTransition(
              opacity: anim1.drive(
                Tween(
                  begin: 0,
                  end: 1,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          selectableDayPredicate: (dateTime) {
            // Disable 25th Feb 2023
            if (dateTime == DateTime(2023, 2, 25)) {
              return false;
            } else {
              return true;
            }
          },
        );
        controller?.text = DateFormat(Constants.dateFormat, 'fr').format(
          results ?? DateTime.now(),
        );
        onChanged?.call(
          results ?? DateTime.now(),
        );
        LoggerUtils.info('datePicker ----> $results');
      },
      // suffixIcon: Icon(
      //   Icons.calendar_today_outlined,
      //   size: 20.h,
      //   color: AppColors.gray500,
      // ),
    );
  }
}
