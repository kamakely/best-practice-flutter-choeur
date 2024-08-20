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
    this.prefixIcon,
    this.isLoading = false,
    this.errorText,
  });

  final String title;
  final TextEditingController controller;
  final Function()? onAdd;
  final String buttonTitle;
  final Icon? prefixIcon;
  final bool isLoading;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Gap(40.h),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  errorText: errorText,
                ),
              )),
          Gap(40.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ElevatedButton(
              onPressed: onAdd,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(buttonTitle),
                  if (isLoading) Gap(20.w),
                  if (isLoading)
                    SizedBox(
                      width: 30.h,
                      height: 30.h,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1.h,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
