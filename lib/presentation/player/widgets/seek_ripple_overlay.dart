import 'package:flutter/material.dart';

class SeekRippleOverlay extends StatefulWidget {
  final bool isLeft;
  final bool isRight;
  final int seconds;

  const SeekRippleOverlay({
    super.key,
    required this.isLeft,
    required this.isRight,
    required this.seconds,
  });

  @override
  State<SeekRippleOverlay> createState() => _SeekRippleOverlayState();
}

class _SeekRippleOverlayState extends State<SeekRippleOverlay> with TickerProviderStateMixin {
  // Контроллер для фона (Волны) и бегущих стрелочек (600мс)
  late final AnimationController _rippleController;
  
  // Контроллер для упругого прыжка текста (300мс)
  late final AnimationController _textPulseController;

  // --- Анимации Фона ---
  late final Animation<double> _rippleScale;
  late final Animation<double> _rippleOpacity;

  // --- Анимации Стрелочек ---
  late final Animation<double> _arrow1;
  late final Animation<double> _arrow2;
  late final Animation<double> _arrow3;

  // --- Анимация Текста ---
  late final Animation<double> _textScale;

  @override
  void initState() {
    super.initState();

    // 1. Инициализация контроллеров
    _rippleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _textPulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    // 2. Ripple Layer (Фоновая рябь)
    _rippleScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOutCubic),
    );
    _rippleOpacity = Tween<double>(begin: 0.25, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    // 3. Icon Sequence (Группа индикаторов - бегущая волна)
    // Функция-помощник: стрелка загорается, держится и гаснет
    Animation<double> buildArrowAnimation(double startDelay) {
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.0), weight: 20),
        TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 30),
        TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.0), weight: 50),
      ]).animate(
        CurvedAnimation(
          parent: _rippleController,
          curve: Interval(startDelay, startDelay + 0.6, curve: Curves.linear),
        ),
      );
    }

    _arrow1 = buildArrowAnimation(0.0);
    _arrow2 = buildArrowAnimation(0.15);
    _arrow3 = buildArrowAnimation(0.30);

    // 4. Label Layer (Текстовый аккумулятор)
    _textScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _textPulseController, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(covariant SeekRippleOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // При каждом новом тапе перезапускаем обе анимации с нуля
    if (widget.seconds != oldWidget.seconds && widget.seconds != 0) {
      _rippleController.forward(from: 0.0);
      _textPulseController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _textPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children:[
          // === ЛЕВАЯ ВОЛНА ===
          if (widget.isLeft) _buildSide(isRight: false),

          // === ПРАВАЯ ВОЛНА ===
          if (widget.isRight) _buildSide(isRight: true),
        ],
      ),
    );
  }

  Widget _buildSide({required bool isRight}) {
    // В зависимости от стороны, точка масштабирования будет слева или справа
    final align = isRight ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: align,
      child: FractionallySizedBox(
        widthFactor: 0.35, // Волна занимает 35% ширины экрана
        heightFactor: 1.0, // На всю высоту экрана
        child: Stack(
          alignment: align,
          children:[
            // === 1. RIPPLE LAYER ===
            ScaleTransition(
              alignment: align,
              scale: _rippleScale,
              child: FadeTransition(
                opacity: _rippleOpacity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Прозрачность контролируется FadeTransition (максимум 0.25)
                    borderRadius: BorderRadius.only(
                      topLeft: isRight ? const Radius.circular(1000) : Radius.zero,
                      bottomLeft: isRight ? const Radius.circular(1000) : Radius.zero,
                      topRight: !isRight ? const Radius.circular(1000) : Radius.zero,
                      bottomRight: !isRight ? const Radius.circular(1000) : Radius.zero,
                    ),
                  ),
                ),
              ),
            ),

            // === 2. CONTENT LAYER (Иконки и Текст) ===
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                  _buildIconSequence(isRight: isRight),
                  const SizedBox(height: 12),
                  _buildLabelLayer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === ICON SEQUENCE ===
  Widget _buildIconSequence({required bool isRight}) {
    // Единичная стрелочка (отражаем по горизонтали, если мотаем назад)
    Widget buildArrow(bool right) {
      return Transform.scale(
        scaleX: right ? 1.0 : -1.0,
        child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36),
      );
    }

    // Собираем массив стрелочек. 
    // Если вправо: ->(1) ->(2) ->(3)
    // Если влево: <-(3) <-(2) <-(1) (первой загорается та, что ближе к центру)
    List<Widget> arrows =[
      FadeTransition(opacity: _arrow1, child: buildArrow(isRight)),
      FadeTransition(opacity: _arrow2, child: buildArrow(isRight)),
      FadeTransition(opacity: _arrow3, child: buildArrow(isRight)),
    ];

    if (!isRight) {
      arrows = arrows.reversed.toList();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: arrows,
    );
  }

  // === LABEL LAYER ===
  Widget _buildLabelLayer() {
    return ScaleTransition(
      scale: _textScale,
      child: Text(
        "${widget.seconds > 0 ? '+' : ''}${widget.seconds} sec",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          shadows:[
            Shadow(color: Colors.black54, blurRadius: 6, offset: Offset(0, 2))
          ],
        ),
      ),
    );
  }
}