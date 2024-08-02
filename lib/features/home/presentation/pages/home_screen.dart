import 'package:chorale_fva/features/home/presentation/controllers/home_binding.dart';
import 'package:chorale_fva/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBinding().dependencies();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Azela'),
          backgroundColor: const Color(0xFF62D9F7),
         
        ),
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                ),
                itemCount: controller.menu.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: InkWell(
                      onTap: controller.menu[index].onTap,
                      child: Center(
                          child: Text(
                        controller.menu[index].name,
                        style: GoogleFonts.roboto(
                            fontSize: 24.sp, fontWeight: FontWeight.w500),
                      )),
                    ),
                  );
                }),
          ),
        ));
  }
}
