import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../framework/widgets/date_picker.dart';

class AddEventBottomsheet extends StatelessWidget {
  const AddEventBottomsheet({
    super.key,
    required this.title,
    required this.nameController,
    required this.dateController,
    required this.buttonTitle,
    this.onAdd,
  });

  final String title;
  final TextEditingController nameController;
  final TextEditingController dateController;
  final Function()? onAdd;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ).copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(title),
          Gap(20.h),
          TextField(
            decoration:
                const InputDecoration(label: Text("Nom de l'événement")),
            controller: nameController,
          ),
          Gap(20.h),
          DatePicker(label: "date de l'événement",
           controller: dateController,),
          Gap(20.h),
          SizedBox(
            width: 400.w,
            child: ElevatedButton(
              onPressed: onAdd,
              child: Text(buttonTitle),
            ),
          ),
        ],
      ),
    );
  }
}
