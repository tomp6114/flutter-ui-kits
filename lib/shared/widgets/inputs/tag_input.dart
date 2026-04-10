import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/chip_button.dart';

/// Tag input where user types and presses enter to create deletable chips.
class TagInput extends StatefulWidget {
  final List<String> initialTags;
  final ValueChanged<List<String>> onChanged;
  final String hint;

  const TagInput({
    super.key,
    this.initialTags = const [],
    required this.onChanged,
    this.hint = 'Add a tag...',
  });

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  late List<String> _tags;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.initialTags);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTag(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty && !_tags.contains(trimmed)) {
      setState(() {
        _tags.add(trimmed);
      });
      _controller.clear();
      widget.onChanged(_tags);
    }
  }

  void _removeTag(String value) {
    setState(() {
      _tags.remove(value);
    });
    widget.onChanged(_tags);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hint,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: _addTag,
        ),
        if (_tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _tags.map((tag) {
                return ChipButtonKit(
                  label: tag,
                  type: ChipType.input,
                  onDeleted: () => _removeTag(tag),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
