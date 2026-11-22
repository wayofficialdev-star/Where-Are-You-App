import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

/// Applies a [Gradient] to its text with a [ShaderMask].
class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.style,
    this.gradient = WhereRuBrand.accentGradient,
    this.textAlign = TextAlign.center,
    super.key,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: gradient.createShader,
      child: Text(
        text,
        textAlign: textAlign,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
