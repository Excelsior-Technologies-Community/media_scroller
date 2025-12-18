import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  final VoidCallback onTap;
  final Color color;
  final Animation<double>? animation;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.count,
    required this.onTap,
    this.color = Colors.white,
    this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Icon(icon, color: color, size: 28);

    if (animation != null) {
      iconWidget = ScaleTransition(
        scale: animation!,
        child: iconWidget,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          iconWidget,
          if (count.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}