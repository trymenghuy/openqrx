import 'package:flutter/material.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/app/util/txt.dart';

class FloorTest extends StatelessWidget {
  const FloorTest({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    // final homeLength = w * 2;
    xPrint(w);
    final unit = w / 8;
    final floorWidth = unit * 1.2;
    final floorHeight = unit * 0.6;
    final oneCaro = Container(
      width: 0.6 * unit - 1,
      height: 1.2 * unit - 1,
      color: xColor.outline,
    );
    final oneRowCaro = Container(
      width: 1.2 * unit - 1,
      height: 0.6 * unit - 1,
      color: xColor.outline,
    );
    final oneColumnBlack = Container(
      width: 0.1 * unit - 1,
      height: 1.2 * unit - 1,
      color: xColor.surface,
    );
    final oneColumnGrey = Container(
      width: 0.1 * unit - 1,
      height: 1.2 * unit - 1,
      color: xColor.outline,
    );
    final oneRowBlack = Container(
      height: 0.1 * unit,
      width: 1.2 * unit - 1,
      color: xColor.surface,
    );
    final oneRowGrey = Container(
      height: 0.1 * unit,
      width: 1.2 * unit - 1,
      color: xColor.outline,
    );
    final spaces = [0, 2, 15, 17];
    final borderSide = BorderSide(width: 0.1 * unit, color: xColor.surface);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 120),
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 12 * unit,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            // color: xColor.outline,
                            child: Row(
                              children: [
                                // SizedBox(
                                //   width: 0.1 * unit,
                                //   child: Wrap(
                                //     runSpacing: 1,
                                //     children:
                                //         List.generate(10, (i) => oneColumnGrey),
                                //   ),
                                // ),
                                Expanded(
                                  child: Wrap(
                                    runSpacing: 1,
                                    children: List.generate(10, (_) => oneCaro),
                                  ),
                                ),
                                // Container(
                                //   width: 0.1 * unit,
                                //   color: xColor.surface,
                                // ),
                                // SizedBox(
                                //   width: 0.1 * unit,
                                //   child: Wrap(
                                //     runSpacing: 1,
                                //     children: List.generate(
                                //         10, (i) => oneColumnBlack),
                                //   ),
                                // ),
                                Expanded(
                                  flex: 2,
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    runSpacing: 1,
                                    children: List.generate(17, (index) {
                                      return Column(
                                        children: [
                                          oneRowCaro,
                                          oneRowBlack, // You can customize the divider properties if needed
                                        ],
                                      );
                                    }).expand((widget) => [widget]).toList(),
                                  ),
                                ),
                                // Container(
                                //   width: 0.1 * unit,
                                //   color: xColor.outline,
                                // ),

                                // Expanded(
                                //   child: Wrap(
                                //     runSpacing: 1,
                                //     children: List.generate(10, (_) => oneCaro),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 0.1 * unit,
                        //   color: xColor.surface,
                        // )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    height: 12 * unit,
                  ),
                ),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 8 / 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 1,
                        runSpacing: 1,
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          15,
                          (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
                        ),
                      ),
                      Wrap(
                        spacing: 1,
                        runSpacing: 1,
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          15,
                          (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
                        ),
                      ),
                      Wrap(
                        spacing: 1,
                        runSpacing: 1,
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          15,
                          (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
                        ),
                      ),
                      Wrap(
                        spacing: 1,
                        runSpacing: 1,
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          15,
                          (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
                        ),
                      ),
                      Wrap(
                        spacing: 1,
                        runSpacing: 1,
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          15,
                          (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin:
                        EdgeInsets.only(right: 0.4 * unit, bottom: 1 * unit),
                    decoration: BoxDecoration(
                      border: Border(
                        left: borderSide,
                        right: borderSide,
                        bottom: borderSide,
                        top: borderSide,
                      ),
                    ),
                    width: 2.5 * unit,
                    height: 1.4 * unit,
                  ),
                ),
                Center(
                  child: Container(
                    margin:
                        EdgeInsets.only(right: 0.4 * unit, bottom: 1 * unit),
                    decoration: BoxDecoration(
                      border: Border(
                        left: borderSide,
                        right: borderSide,
                        bottom: borderSide,
                        top: borderSide,
                      ),
                    ),
                    width: 3.7 * unit,
                    height: 2.6 * unit,
                  ),
                ),
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border: Border(
                //             left: borderSide,
                //             right: borderSide,
                //             bottom: borderSide)),
                //     width: 4 * unit,
                //     height: 4 * unit,
                //   ),
                // ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    color: xColor.surface,
                    width: 2 * unit,
                    height: 0.6 * unit,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: xColor.surface,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30))),
                    width: 0.8 * unit,
                    height: 0.8 * unit,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        color: xColor.surface,
                        width: 0.8 * unit,
                        height: 0.8 * unit,
                      ),
                      Container(
                        color: xColor.surface,
                        width: 1.2 * unit,
                        height: 0.5 * unit,
                      ),
                      Container(
                        color: xColor.surface,
                        width: 0.8 * unit,
                        height: 0.8 * unit,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -1.6 * unit,
                  left: 1.4 * unit,
                  child: SizedBox(
                    width: 3.6 * unit,
                    height: 2.4 * unit,
                    child: Wrap(
                      spacing: 1,
                      runSpacing: 1,
                      alignment: WrapAlignment.start,
                      children: List.generate(
                        12,
                        (i) => oneCaro,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AspectRatio oneByOne(
      List<int> spaces,
      Container oneColumnGrey,
      Container oneCaro,
      double unit,
      Container oneRowBlack,
      Container oneRowGrey) {
    return AspectRatio(
      aspectRatio: 8 / 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 1,
            runSpacing: 1,
            alignment: WrapAlignment.start,
            children: List.generate(
              15,
              (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 0.1 * unit,
            child: Wrap(
              spacing: 1,
              children: List.generate(
                6,
                (i) => i.isOdd ? oneRowBlack : oneRowGrey,
              ),
            ),
          ),
          Wrap(
            spacing: 1,
            runSpacing: 1,
            alignment: WrapAlignment.start,
            children: List.generate(
              15,
              (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 0.1 * unit,
            child: Wrap(
              spacing: 1,
              children: List.generate(
                6,
                (i) => i.isEven ? oneRowBlack : oneRowGrey,
              ),
            ),
          ),
          Wrap(
            spacing: 1,
            runSpacing: 1,
            alignment: WrapAlignment.start,
            children: List.generate(
              15,
              (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 0.1 * unit,
            child: Wrap(
              spacing: 1,
              children: List.generate(
                6,
                (i) => i.isOdd ? oneRowBlack : oneRowGrey,
              ),
            ),
          ),
          Wrap(
            spacing: 1,
            runSpacing: 1,
            alignment: WrapAlignment.start,
            children: List.generate(
              15,
              (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 0.1 * unit,
            child: Wrap(
              spacing: 1,
              children: List.generate(
                6,
                (i) => i.isEven ? oneRowBlack : oneRowGrey,
              ),
            ),
          ),
          Wrap(
            spacing: 1,
            runSpacing: 1,
            alignment: WrapAlignment.start,
            children: List.generate(
              15,
              (i) => spaces.contains(i) ? oneColumnGrey : oneCaro,
            ),
          ),
        ],
      ),
    );
  }
}
