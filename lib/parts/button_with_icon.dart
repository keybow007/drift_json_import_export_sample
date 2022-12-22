import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;
  final Color color;

  ButtonWithIcon({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            //20220905：primary / onPrimaryはFlutter3.3以降非推奨に
            //https://github.com/flutter/flutter/pull/105291
            backgroundColor: color,
            //primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            )
          ),
          onPressed: onPressed,
          icon: icon,
          label: Text(
            label,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
