import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Search bar kit with voice icon, clear button, and recent searches overlay.
class SearchBarKit extends StatefulWidget {
  final String hint;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onVoicePrefixTap;
  final List<String> recentSearches;
  final ValueChanged<String>? onRecentSearchTap;
  final ValueChanged<String>? onRecentSearchDelete;

  const SearchBarKit({
    super.key,
    this.hint = 'Search...',
    this.onSearch,
    this.onVoicePrefixTap,
    this.recentSearches = const [],
    this.onRecentSearchTap,
    this.onRecentSearchDelete,
  });

  @override
  State<SearchBarKit> createState() => _SearchBarKitState();
}

class _SearchBarKitState extends State<SearchBarKit> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClear = _controller.text.isNotEmpty;
      });
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus && widget.recentSearches.isNotEmpty) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width - (AppSpacing.lg * 2), // Rough approx based on padding typical
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0.0, 56.0), // Below search bar
            child: Material(
              elevation: 4.0,
              borderRadius: AppRadius.radiusMd,
              color: context.colorScheme.surface,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.recentSearches.length,
                  itemBuilder: (context, index) {
                    final search = widget.recentSearches[index];
                    return ListTile(
                      leading: const Icon(Icons.history, size: 20),
                      title: Text(search, style: context.textTheme.bodyMedium),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: () {
                          widget.onRecentSearchDelete?.call(search);
                          // Must trigger rebuild internally if list passed directly or require parent state shift. 
                          // As stateless parent holds list, calling hide/show re-renders it securely.
                        },
                      ),
                      onTap: () {
                        _controller.text = search;
                        _focusNode.unfocus();
                        widget.onRecentSearchTap?.call(search);
                        widget.onSearch?.call(search);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hideOverlay();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5) ?? AppColors.dividerLight.withValues(alpha: 0.2),
          borderRadius: AppRadius.radiusMd,
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: widget.onSearch,
          decoration: InputDecoration(
            hintText: widget.hint,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14.0), // Center vertically
            prefixIcon: const Icon(Icons.search),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_showClear)
                  IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      _controller.clear();
                      widget.onSearch?.call('');
                    },
                  ),
                if (widget.onVoicePrefixTap != null && !_showClear)
                  IconButton(
                    icon: const Icon(Icons.mic, size: 20),
                    onPressed: widget.onVoicePrefixTap,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
