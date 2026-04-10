import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/shared/widgets/feedback/progress_indicator_kit.dart';
import 'package:flutter_ui_kits/shared/widgets/lists/error_state.dart';

/// A list providing built-in pagination logic and loading/error states natively.
class InfiniteScrollList extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Future<void> Function() onLoadMore;
  final bool hasMore;
  final bool isLoading;
  final bool hasError;
  final VoidCallback? onRetry;
  final Widget? loadingIndicator;
  final double scrollThreshold;

  const InfiniteScrollList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onLoadMore,
    this.hasMore = true,
    this.isLoading = false,
    this.hasError = false,
    this.onRetry,
    this.loadingIndicator,
    this.scrollThreshold = 200.0,
  });

  @override
  State<InfiniteScrollList> createState() => _InfiniteScrollListState();
}

class _InfiniteScrollListState extends State<InfiniteScrollList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - widget.scrollThreshold) {
      if (widget.hasMore && !widget.isLoading && !widget.hasError) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.itemCount + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.itemCount) {
          if (widget.hasError) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ErrorState(
                isFullScreen: false,
                onRetry: widget.onRetry,
              ),
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: widget.loadingIndicator ?? const ProgressIndicatorKit(variant: ProgressVariant.dots),
            ),
          );
        }
        return widget.itemBuilder(context, index);
      },
    );
  }
}
