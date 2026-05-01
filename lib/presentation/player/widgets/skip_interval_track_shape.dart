import 'package:flutter/material.dart';
import '../../../../domain/anime.dart'; // Проверь правильность пути

class SkipIntervalTrackShape extends RoundedRectSliderTrackShape {
  final List<SkipIntervalDb>? intervals;
  final double durationInSeconds;
  final Color skipColor;
  final double gapWidth;

  SkipIntervalTrackShape({
    required this.intervals,
    required this.durationInSeconds,
    this.skipColor = const Color(0xFFE0E0E0), // Светло-серый цвет блока опенинга (как на фото)
    this.gapWidth = 3.0, // Ширина прозрачного зазора между блоками
  });

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 2.0, // Оставляем для совместимости с Flutter
  }) {
    // Если длительность неизвестна, ничего не рисуем
    if (durationInSeconds <= 0) return;

    // Получаем стандартные границы (размеры) ползунка
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Canvas canvas = context.canvas;
    
    // Цвета из темы Slider'а
    final Color activeColor = sliderTheme.activeTrackColor ?? Colors.redAccent;
    final Color inactiveColor = sliderTheme.inactiveTrackColor ?? Colors.white24;

    // Если таймкодов нет — рисуем единой стандартной линией
    if (intervals == null || intervals!.isEmpty) {
      _drawSegment(canvas, trackRect.left, trackRect.right, trackRect, thumbCenter.dx, activeColor, inactiveColor);
      return;
    }

    double currentX = trackRect.left;

    // Сортируем интервалы по времени на всякий случай
    final sortedIntervals = List<SkipIntervalDb>.from(intervals!)
      ..sort((a, b) => (a.startTime ?? 0).compareTo(b.startTime ?? 0));

    for (var interval in sortedIntervals) {
      if (interval.startTime == null || interval.endTime == null) continue;

      // Переводим секунды в проценты
      double startPercent = (interval.startTime! / durationInSeconds).clamp(0.0, 1.0);
      double endPercent = (interval.endTime! / durationInSeconds).clamp(0.0, 1.0);

      // Переводим проценты в пиксели по оси X
      double skipStartX = (trackRect.left + trackRect.width * startPercent).clamp(trackRect.left, trackRect.right);
      double skipEndX = (trackRect.left + trackRect.width * endPercent).clamp(trackRect.left, trackRect.right);

      // 1. Рисуем ОБЫЧНУЮ часть ДО опенинга/эндинга
      // (Отнимаем половину gapWidth, чтобы сделать разрыв)
      if (skipStartX - (gapWidth / 2) > currentX) {
        _drawSegment(
          canvas, 
          currentX, 
          skipStartX - (gapWidth / 2), 
          trackRect, 
          thumbCenter.dx, 
          activeColor, 
          inactiveColor
        );
      }

      // 2. Рисуем сам ОПЕНИНГ / ЭНДИНГ
      // (Добавляем и отнимаем gapWidth, чтобы зазоры были с обеих сторон)
      if (skipEndX - (gapWidth / 2) > skipStartX + (gapWidth / 2)) {
        _drawSegment(
          canvas, 
          skipStartX + (gapWidth / 2), 
          skipEndX - (gapWidth / 2), 
          trackRect, 
          thumbCenter.dx, 
          activeColor, 
          skipColor // <- ИСПОЛЬЗУЕМ ВЫДЕЛЯЮЩИЙСЯ СВЕТЛО-СЕРЫЙ ЦВЕТ
        );
      }

      currentX = skipEndX + (gapWidth / 2);
    }

    // 3. Рисуем оставшуюся ОБЫЧНУЮ часть ПОСЛЕ последнего опенинга/эндинга
    if (currentX < trackRect.right) {
      _drawSegment(
        canvas, 
        currentX, 
        trackRect.right, 
        trackRect, 
        thumbCenter.dx, 
        activeColor, 
        inactiveColor
      );
    }
  }

  // Вспомогательный метод для отрисовки кусочка трека
  void _drawSegment(Canvas canvas, double left, double right, Rect trackRect, double thumbX, Color activeCol, Color inactiveCol) {
    if (left >= right) return;

    // Скругление краев у каждого кусочка
    final double radius = trackRect.height / 2;

    // Считаем активную (заполненную цветом) часть куска
    double activeRight = left < thumbX ? (right < thumbX ? right : thumbX) : left;
    
    // Рисуем заполненную часть, если ползунок уже зашел на этот кусок
    if (activeRight > left) {
      final RRect activeRRect = RRect.fromLTRBR(left, trackRect.top, activeRight, trackRect.bottom, Radius.circular(radius));
      canvas.drawRRect(activeRRect, Paint()..color = activeCol);
    }

    // Считаем неактивную (еще не просмотренную) часть куска
    double inactiveLeft = right > thumbX ? (left > thumbX ? left : thumbX) : right;
    
    // Рисуем неактивную часть
    if (inactiveLeft < right) {
      final RRect inactiveRRect = RRect.fromLTRBR(inactiveLeft, trackRect.top, right, trackRect.bottom, Radius.circular(radius));
      canvas.drawRRect(inactiveRRect, Paint()..color = inactiveCol);
    }
  }
}