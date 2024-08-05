import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddVoiceBottomsheet extends StatelessWidget {
  const AddVoiceBottomsheet({
    super.key,
    required this.title,
    required this.controller,
    required this.buttonTitle,
    this.onAddVoice,
  });

  final String title;
  final TextEditingController controller;
  final Function()? onAddVoice;
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
              onPressed: onAddVoice,
              child: Text(buttonTitle),
            ),
          ),
        ],
      ),
    );
  }
}
