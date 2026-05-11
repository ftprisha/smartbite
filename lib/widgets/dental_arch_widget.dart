import 'package:flutter/material.dart';
import 'package:smartbite/models/scan_session.dart';
import 'dart:math';

class DentalArchWidget extends StatefulWidget {
  final List<ToothData> teeth;
  final bool isLive;
  final bool showGrid;

  const DentalArchWidget({
    Key? key,
    required this.teeth,
    this.isLive = false,
    this.showGrid = true,
  }) : super(key: key);

  @override
  State<DentalArchWidget> createState() => _DentalArchWidgetState();
}

class _DentalArchWidgetState extends State<DentalArchWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    if (widget.isLive) {
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) {
            return CustomPaint(
              painter: ArchPainter(
                teeth: widget.teeth,
                pulse: _pulse.value,
                isLive: widget.isLive,
              ),
              size: Size(double.infinity, 280),
            );
          },
        ),
      ),
    );
  }
}

class ArchPainter extends CustomPainter {
  final List<ToothData> teeth;
  final double pulse;
  final bool isLive;

  ArchPainter({
    required this.teeth,
    required this.pulse,
    required this.isLive,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final List<int> upperTeeth = [18, 17, 16, 15, 14, 13, 12, 11, 21, 22, 23, 24, 25, 26, 27, 28];
    final List<int> lowerTeeth = [48, 47, 46, 45, 44, 43, 42, 41, 31, 32, 33, 34, 35, 36, 37, 38];

    print('Upper teeth length: ${upperTeeth.length}');
    print('Lower teeth length: ${lowerTeeth.length}');

    final Map<int, Offset> positions = {};

    // Upper arch - curved line with teeth positioned
    for (int i = 0; i < upperTeeth.length; i++) {
      final double x = w * 0.04 + (w * 0.92 / 15) * i;
      final double t = i / 15.0;
      final double curveY = h * 0.20 * 4 * t * (1 - t);
      final double y = h * 0.35 - curveY;
      positions[upperTeeth[i]] = Offset(x, y);
    }

    // Draw upper teeth from positions map
    for (final tooth in teeth) {
      final offset = positions[tooth.fdiNumber];
      if (offset == null) {
        continue;
      }

      final double radius;
      final List<int> molars = [18, 17, 16, 28, 27, 26, 48, 47, 46, 38, 37, 36];
      final List<int> premolars = [14, 15, 24, 25, 34, 35, 44, 45];

      if (molars.contains(tooth.fdiNumber)) {
        radius = 14;
      } else if (premolars.contains(tooth.fdiNumber)) {
        radius = 11;
      } else {
        radius = 9;
      }

      Color toothColor;
      if (tooth.forceN < 100) {
        toothColor = const Color(0xFF3B82F6);
      } else if (tooth.forceN < 200) {
        toothColor = const Color(0xFF34D399);
      } else if (tooth.forceN < 650) {
        toothColor = const Color(0xFF22C55E);
      } else if (tooth.forceN < 800) {
        toothColor = const Color(0xFFF59E0B);
      } else {
        toothColor = const Color(0xFFEF4444);
      }

      final fillPaint = Paint();
      fillPaint.color = toothColor;
      fillPaint.style = PaintingStyle.fill;
      canvas.drawCircle(offset, radius, fillPaint);

      final fdiTextPainter = TextPainter(
        text: TextSpan(
          text: tooth.fdiNumber.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      fdiTextPainter.layout();
      fdiTextPainter.paint(
        canvas,
        offset - Offset(fdiTextPainter.width / 2, fdiTextPainter.height / 2),
      );

      final forceTextPainter = TextPainter(
        text: TextSpan(
          text: '${tooth.forceN.toInt()}N',
          style: TextStyle(
            color: toothColor,
            fontSize: 6,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      forceTextPainter.layout();
      forceTextPainter.paint(
        canvas,
        offset + Offset(-forceTextPainter.width / 2, radius + 3),
      );

      if (tooth.forceN > 800 && isLive) {
        final ringPaint = Paint();
        ringPaint.color = const Color(0xFFEF4444).withOpacity(pulse * 0.3);
        ringPaint.style = PaintingStyle.stroke;
        ringPaint.strokeWidth = 2;
        canvas.drawCircle(offset, radius + 5, ringPaint);
      }
    }

    // Lower arch - direct drawing section
    final List<int> lowerTeethDraw = [48, 47, 46, 45, 44, 43, 42, 41, 31, 32, 33, 34, 35, 36, 37, 38];
    for (int i = 0; i < lowerTeethDraw.length; i++) {
      final int fdi = lowerTeethDraw[i];
      final double t = i / 15.0;
      final double curveY = h * 0.20 * 4 * t * (1 - t);
      final double x = w * 0.04 + (w * 0.92 / 15.0) * i;
      final double y = h * 0.65 + curveY;
      
      ToothData? tooth;
      try {
        tooth = teeth.firstWhere((t) => t.fdiNumber == fdi);
      } catch (e) {
        tooth = null;
      }
      
      final double force = tooth?.forceN ?? 0;
      
      Color fillColor;
      if (force < 100) {
        fillColor = const Color(0xFF3B82F6);
      } else if (force < 200) {
        fillColor = const Color(0xFF34D399);
      } else if (force < 650) {
        fillColor = const Color(0xFF22C55E);
      } else if (force < 800) {
        fillColor = const Color(0xFFF59E0B);
      } else {
        fillColor = const Color(0xFFEF4444);
      }
      
      final double radius;
      if ([48, 47, 46, 38, 37, 36, 28, 27, 26, 18, 17, 16].contains(fdi)) {
        radius = 14;
      } else if ([45, 44, 43, 35, 34, 33, 25, 24, 23, 15, 14, 13].contains(fdi)) {
        radius = 11;
      } else {
        radius = 9;
      }
      
      final paint = Paint();
      paint.color = fillColor;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), radius, paint);
      
      final textPainter = TextPainter(
        text: TextSpan(text: '$fdi', style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
      
      final forcePainter = TextPainter(
        text: TextSpan(text: '${force.toInt()}N', style: TextStyle(color: fillColor, fontSize: 6)),
        textDirection: TextDirection.ltr,
      );
      forcePainter.layout();
      forcePainter.paint(canvas, Offset(x - forcePainter.width / 2, y + radius + 2));
    }

    // Draw UPPER JAW label
    final upperLabelPainter = TextPainter(
      text: const TextSpan(
        text: 'UPPER JAW',
        style: TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 9,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    upperLabelPainter.layout();
    upperLabelPainter.paint(canvas, const Offset(8, 8));

    // Draw LOWER JAW label
    final lowerLabelPainter = TextPainter(
      text: const TextSpan(
        text: 'LOWER JAW',
        style: TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 9,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    lowerLabelPainter.layout();
    lowerLabelPainter.paint(canvas, Offset(8, h - 16));
  }

  @override
  bool shouldRepaint(ArchPainter oldDelegate) {
    return true;
  }
}

