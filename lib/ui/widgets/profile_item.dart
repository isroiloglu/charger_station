import 'package:charge_me/core/const/colors.dart';
import 'package:flutter/material.dart';

Widget profileItem(String icon, String title, Widget suffix,
    {Color? textColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(6),
              child: Image.asset(icon, height: 24, width: 24),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? dark),
            ),
          ],
        ),
        suffix,
      ],
    ),
  );
}
