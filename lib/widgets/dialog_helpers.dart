import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showComingSoonDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Center(
          child: Icon(
            Icons.warning_outlined,
            size: 48.sp,
            color: Color(0xFF90C02A),
          ),
        ),
        content: Text('Coming Soon...', style: TextStyle(fontSize: 16.sp)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'OK',
              style: TextStyle(color: Color(0xFF36AC19)),
            ),
          ),
        ],
      );
    },
  );
}
