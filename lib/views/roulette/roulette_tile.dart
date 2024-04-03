import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RouletteTile extends StatelessWidget {
  final String optionName;

  const RouletteTile({super.key, required this.optionName});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: ((context) {
              // delete tile
            }),
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Text(optionName),
          ],
        ),
      ),
    );
  }
}
