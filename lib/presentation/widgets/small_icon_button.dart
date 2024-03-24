import 'package:flutter/material.dart';

class SmallIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String message;
  final Color? color;

  const SmallIconButton({
    required this.icon,
    required this.onPressed,
    required this.message,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: MaterialButton(
        minWidth: 10,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            icon,
            size: 22,
            color: color,
          ),
        ),
      ),
    );
  }
}
