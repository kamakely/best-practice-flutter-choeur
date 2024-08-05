import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddBottomsheet extends StatelessWidget {
  const AddBottomsheet({
    super.key,
    required this.title,
    required this.controller,
    required this.buttonTitle,
    this.onAdd,
  });

  final String title;
  final TextEditingController controller;
  final Function()? onAdd;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(title),
          Gap(20.h),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                autofocus: true,
                controller: controller,
              )),
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
