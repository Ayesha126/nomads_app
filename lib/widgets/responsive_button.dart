import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nomads/misc/colors.dart';
import 'package:nomads/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  ResponsiveButton({Key? key,this.width=120 ,this.isResponsive = false }): super (key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: isResponsive==true?double.maxFinite :width,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainColor
        ) ,
        child: Row (
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            AppText(text:  "Book Trip Now",color: Colors.white),
          ],
        ),
      ),
    )  ;
  }
}
