import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

/// Rounded, filled input used by the Where RU auth screens.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.autofillHints,
    this.isCompact = true,
    this.verticalPadding = 19,
    this.radius = 16,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final Iterable<String>? autofillHints;
  final bool isCompact;
  final double verticalPadding;
  final double radius;

  static const Color _errorColor = Color(0xFFE5484D);

  @override
  Widget build(BuildContext context) {
    final fontSize = isCompact ? 15.0 : 16.0;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      autofillHints: autofillHints,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        height: 1.25,
        letterSpacing: .1,
        color: WhereRuBrand.navy,
      ),
      cursorColor: WhereRuBrand.purple,
      cursorWidth: 1.6,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: WhereRuBrand.fieldFill,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          height: 1.25,
          letterSpacing: .1,
          color: WhereRuBrand.hint,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 18, right: 12),
          child: Icon(icon, size: 20, color: WhereRuBrand.fieldIcon),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 50,
          minHeight: 20,
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(minWidth: 48),
        contentPadding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: 4,
        ),
        border: _border(WhereRuBrand.fieldBorder),
        enabledBorder: _border(WhereRuBrand.fieldBorder),
        focusedBorder: _border(const Color(0xFFB9A6FF), width: 1.3),
        errorBorder: _border(_errorColor),
        focusedErrorBorder: _border(_errorColor, width: 1.3),
        errorStyle: TextStyle(
          fontSize: isCompact ? 11.5 : 12.5,
          height: 1.3,
          color: _errorColor,
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
