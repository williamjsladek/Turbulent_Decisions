import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roulette/roulette.dart';
import 'package:turb_desc/components/dialog_boxes/roulette_alert.dart';


class Roulette_Wheel extends StatefulWidget {

  List<String> options = [];
  Roulette_Wheel({super.key, required this.options});

  @override
  State<Roulette_Wheel> createState() => _Roulette_WheelState();
}

class _Roulette_WheelState extends State<Roulette_Wheel> with SingleTickerProviderStateMixin {
  late RouletteController _controller;

  final colors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.cyan,
    Colors.purple,
  ];

  static final _random = Random();
  @override
  void initState() {
    super.initState();

    _controller = RouletteController(
        group: RouletteGroup.uniform(
            widget.options.length,
            textBuilder: (index) => widget.options[index],
            colorBuilder: (index) => colors[index % colors.length],
            textStyleBuilder: (index) {
              return const TextStyle(color: Colors.black);
            }
        ),
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("|"),
            const Text("V"),
            Roulette(
              controller: _controller,
              style: const RouletteStyle(
                dividerThickness: 1.0,
                dividerColor: Colors.black,
                centerStickSizePercent: 0.05,
                centerStickerColor: Colors.black
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Use the controller to run the animation with rollTo method
        onPressed: () async {
          int result = _random.nextInt(4);
          await _controller.rollTo(
            result,
            clockwise: true,
            offset: _random.nextDouble()
          );
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
            RouletteAlert(alert: 'Result:', text: widget.options[result]),
          );
        },
        child: const Icon(Icons.refresh_rounded)
      )
    );
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
