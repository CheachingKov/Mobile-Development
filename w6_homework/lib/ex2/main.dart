import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom buttons'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomButton(label: 'Submit', icon: Icons.check),
              CustomButton(label: 'Time', icon: Icons.timer, iconPosition: Position.right, buttonType: Type.secondary),
              CustomButton(label: 'Account', icon: Icons.account_tree, iconPosition: Position.right, buttonType: Type.disabled)
            ],
          ),
        ),
      ),
    ),
  );
}

enum Type {primary, secondary, disabled}
enum Position {left, right}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Position iconPosition;
  final Type buttonType;

  const CustomButton({super.key, required this.label, required this.icon, this.iconPosition = Position.left, this.buttonType = Type.primary});

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.blue;
    if (buttonType == Type.secondary) {
      bgColor = Colors.green;
    } else if (buttonType == Type.disabled) {
      bgColor = Colors.grey;
    }

    List<Widget> buttonContent = [
      Icon(icon, color: Colors.white),
      SizedBox(width: 8),
      Text(label, style: TextStyle(color: Colors.white, fontSize: 18)),
    ];

    if (iconPosition == Position.right) {
      buttonContent = [
        Text(label, style: TextStyle(color: Colors.white, fontSize: 18)),
        SizedBox(width: 8),
        Icon(icon, color: Colors.white),
      ];
    }

    return Container(
      margin:  EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttonContent,
        ),
      );
  }
}