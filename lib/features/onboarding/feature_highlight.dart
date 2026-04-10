import 'package:flutter/material.dart';

/// A premium spotlight overlay providing coach marks mappings natively.
class FeatureHighlight extends StatelessWidget {
  final Widget child;
  final bool show;
  final String title;
  final String description;
  final VoidCallback onDismiss;

  const FeatureHighlight({
    super.key,
    required this.child,
    required this.show,
    required this.title,
    required this.description,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (show)
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: onDismiss,
                child: CustomPaint(
                  painter: _SpotlightPainter(),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.lightbulb_outline, size: 64, color: Colors.white),
                          const SizedBox(height: 20),
                          Text(
                            title,
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            description,
                            style: const TextStyle(color: Colors.white70, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: onDismiss,
                            child: const Text('Got it!'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: 0.8);
    
    // Draw the dark overlay excluding the center spotlight
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 100)),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
