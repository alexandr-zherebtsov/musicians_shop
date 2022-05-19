import 'package:flutter/material.dart';

class SmallIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final String message;

  const SmallIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: MaterialButton(
        minWidth: 10,
        elevation: 0.0,
        focusElevation: 0.0,
        hoverElevation: 0.0,
        disabledElevation: 0.0,
        highlightElevation: 0.0,
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            icon,
            size: 22.0,
          ),
        ),
        shape: const CircleBorder(),
        onPressed: onPressed,
      ),
    );
  }
}
