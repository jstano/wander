import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final bool addShadow;
  final EdgeInsets padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 480,
    this.addShadow = true,
    this.padding = const EdgeInsets.symmetric(vertical: 24.0),
  });

  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final verticalPadding = screenHeight > 800 ? 32.0 : 16.0;

    return Container(
    color: Colors.grey[100],
      child: Center(
        child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: addShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ]
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
