import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/const/colors.dart';

class ChargingDialog extends StatefulWidget {
  const ChargingDialog({super.key, required this.index});

  final int index;

  @override
  State<ChargingDialog> createState() => _ChargingDialogState();
}

class _ChargingDialogState extends State<ChargingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool fill = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      print(_controller.value);
      //  if the full duration of the animation is 8 secs then 0.5 is 4 secs
      if (_controller.value > 0.5 && fill == false) {
        setState(() {
          fill = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: greyLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/speedometer.png',
                                      width: 18,
                                      height: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      '18.50 ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      'кВт',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text('Скорость',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            const VerticalDivider(
                              width: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/battery.png',
                                      width: 18,
                                      height: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      '3107.00 ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      'кВт',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text('Потраченные',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            const VerticalDivider(
                              width: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/money.png',
                                      width: 18,
                                      height: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      '6 524 700 ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      'сум',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text('Скорость',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('10 мин время зарядки',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 24),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: greyLight,
                              borderRadius: BorderRadius.circular(23),
                            ),
                            height: 272,
                            width: 131,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(23),
                              child: Lottie.asset(
                                  'assets/lotties/charging.json',
                                  controller: _controller, onLoaded: (comp) {
                                _controller
                                  ..duration = comp.duration
                                  ..forward();
                              }, fit: BoxFit.fill),
                            )),
                        Text('53%',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: fill ? white : dark))
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: red,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 42),
              // margin: EdgeInsets.only(bottom: 42),
              height: 50,
              width: double.infinity,
              child: const Center(
                child: Text(
                  'Прекратить зарядку',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
