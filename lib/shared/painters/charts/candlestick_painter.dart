import 'package:flutter/material.dart';

/// A set of candlesticks providing OHLC candlestick for financial charts mappings natively.
class CandlestickPainter extends CustomPainter {
  final List<CandleData> candles;

  CandlestickPainter({required this.candles});

  @override
  void paint(Canvas canvas, Size size) {
    if (candles.isEmpty) return;

    final double widthStep = size.width / candles.length;
    final maxHigh = candles.map((c) => c.high).reduce((a, b) => a > b ? a : b);
    final minLow = candles.map((c) => c.low).reduce((a, b) => a < b ? a : b);
    final range = maxHigh - minLow == 0 ? 1.0 : maxHigh - minLow;

    for (int i = 0; i < candles.length; i++) {
        final candle = candles[i];
        final x = i * widthStep + (widthStep / 2);
        
        final color = candle.close >= candle.open ? Colors.green : Colors.red;
        final paint = Paint()..color = color..strokeWidth = 2.0;

        // Wick
        final yHigh = size.height - (candle.high - minLow) / range * size.height;
        final yLow = size.height - (candle.low - minLow) / range * size.height;
        canvas.drawLine(Offset(x, yHigh), Offset(x, yLow), paint);

        // Body
        final yOpen = size.height - (candle.open - minLow) / range * size.height;
        final yClose = size.height - (candle.close - minLow) / range * size.height;
        
        final bodyPaint = Paint()..color = color..style = PaintingStyle.fill;
        canvas.drawRect(
          Rect.fromLTRB(x - widthStep / 3, yOpen, x + widthStep / 3, yClose),
          bodyPaint,
        );
    }
  }

  @override
  bool shouldRepaint(covariant CandlestickPainter oldDelegate) => true;
}

class CandleData {
  final double open;
  final double high;
  final double low;
  final double close;

  CandleData({required this.open, required this.high, required this.low, required this.close});
}
