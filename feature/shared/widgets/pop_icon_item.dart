import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class PopIconItem<T> extends PopupMenuItem<T> {
  final IconData icon;
  final String text;

  PopIconItem({
    super.key,
    required this.icon,
    required this.text,
    super.onTap,
  }) : super(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: x8, right: x15),
                child: Icon(icon),
              ),
              Expanded(child: Text(text)),
            ],
          ),
        );
}
