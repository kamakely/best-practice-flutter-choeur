import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/models/label_provider.dart';

class DropdownWidget<T> extends StatefulWidget {
  final List<T> items;
  final void Function(T?)? itemCallBack;
  final T? currentItem;
  final String? hintText;
  final String? errorText;
  final double? width;

  const DropdownWidget({
    super.key,
    required this.items,
    this.itemCallBack,
    required this.currentItem,
    this.hintText,
    this.errorText,
    this.width,
  });

  @override
  State<StatefulWidget> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<DropdownWidget<T>> {
  List<DropdownMenuItem<T>> dropDownItems = [];
  T? currentItem;

  @override
  void initState() {
    super.initState();
    currentItem = widget.currentItem;
    for (T item in widget.items) {
      dropDownItems.add(DropdownMenuItem<T>(
        value: item,
        child: Text(
          _getItem(item),
          softWrap: true,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
            color: AppColors.gray600,
          ),
        ),
      ));
    }
  }

  String _getItem(T item) {
    if (item is LabelProvider) {
      return item.getLabel();
    } else if (item is String) {
      return item;
    }
    return '';
  }

  @override
  void didUpdateWidget(DropdownWidget<T> oldWidget) {
    if (currentItem != widget.currentItem) {
      setState(() {
        currentItem = widget.currentItem;
      });
    }
    if (dropDownItems != widget.items) {
      setState(() {
        dropDownItems = [];
        for (T item in widget.items) {
          dropDownItems.add(DropdownMenuItem<T>(
            value: item,
            child: Text(
              _getItem(item),
              softWrap: true,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
                color: AppColors.gray600,
              ),
            ),
          ));
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.width ?? double.infinity,
          padding: EdgeInsets.all(
            16.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: widget.errorText == null
                  ? AppColors.gray300
                  : AppColors.red500,
              width: widget.errorText != null ? 2.w : 1.w,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isDense: true,
              isExpanded: true,
              menuMaxHeight: 300,
              value: currentItem,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 40.h,
              ),
              items: dropDownItems,
              onChanged: (selectedItem) {
                setState(() {
                  currentItem = selectedItem;
                });
                widget.itemCallBack?.call(currentItem);
              },
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
                color: AppColors.gray600,
              ),
              hint: widget.hintText != null
                  ? Text(
                      widget.hintText!,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                        color: AppColors.gray600,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorText!,
              style: GoogleFonts.roboto(
                color: AppColors.red500,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
      ],
    );
  }
}
