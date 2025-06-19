import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

InkWell pop_widget(BuildContext context) {
  return InkWell(
    onTap: (){
      Navigator.of(context).pop();
    },
    child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("|",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.white),),
            Text("<",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w900,color: Colors.white),),
          ],
        )),
  );
}