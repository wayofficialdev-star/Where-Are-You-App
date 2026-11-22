import 'package:app/features/find_someone/domain/find_someone_domain.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Optional free-text note, capped at [kMatchNoteMaxLength] characters.
class NoteField extends StatefulWidget {
  const NoteField({
    required this.initialValue,
    required this.onChanged,
    super.key,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  State<NoteField> createState() => _NoteFieldState();
}

class _NoteFieldState extends State<NoteField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: radius,
        border: Border.all(color: WhereRuBrand.fieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            maxLength: kMatchNoteMaxLength,
            maxLines: 3,
            minLines: 2,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {});
            },
            buildCounter:
                (
                  context, {
                  required currentLength,
                  required isFocused,
                  required maxLength,
                }) => null,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              height: 1.45,
              color: WhereRuBrand.navy,
            ),
            cursorColor: WhereRuBrand.purple,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: context.l10n.noteHint,
              hintMaxLines: 2,
              hintStyle: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                height: 1.45,
                color: WhereRuBrand.hint,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              context.l10n.noteCounter(_controller.text.length),
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w400,
                color: WhereRuBrand.hint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
