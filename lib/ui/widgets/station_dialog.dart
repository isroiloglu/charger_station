import 'dart:developer';

import 'package:charge_me/ui/widgets/charging_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/const/colors.dart';
import '../pages/map_page.dart';

class StationDialog extends StatefulWidget {
  const StationDialog({super.key, required this.index});

  final int index;

  @override
  State<StationDialog> createState() => _StationDialogState();
}

class _StationDialogState extends State<StationDialog> {
  int i = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Станция ${widget.index + 1}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Улица Мирзо Улугбек. Ташкент',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            i != 1 ? i = 1 : i = -1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: i == 1
                                  ? primary.withOpacity(0.15)
                                  : greyLight,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              )),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'A порт',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: i == 1
                                      ? primary.withOpacity(0.8)
                                      : blue.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    i == 1 ? 'Выбрано' : 'Свободен',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: i == 1 ? white : blueDark,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const Divider(),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          setState(() {
                            i != 2 ? i = 2 : i = -1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: i == 2
                                  ? primary.withOpacity(0.15)
                                  : greyLight,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              )),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'B порт',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: i == 2
                                      ? primary.withOpacity(0.8)
                                      : blue.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    i == 2 ? 'Выбрано' : 'Свободен',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: i == 2 ? white : blueDark,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (i != -1) {
                Navigator.pop(context);
                showBottomSheetDialog(
                    context, ChargingDialog(index: widget.index));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: i == -1 ? greyLight : primary,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 42),
              // margin: EdgeInsets.only(bottom: 42),
              height: 50,
              width: double.infinity,
              child: Center(
                child: Text(
                  i == -1 ? 'Выберите порт из списка' : 'Начать зарядку',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: i == -1 ? dark : white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
