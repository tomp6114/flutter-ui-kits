import 'package:flutter/material.dart';

/// A scrolling text widget that moves horizontally when content overflows, providing smooth marquee effects natively.
class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration velocity;
  final double gap;

  const MarqueeText({
    super.key,
    required this.text,
    this.style,
    this.velocity = const Duration(seconds: 5),
    this.gap = 50.0,
  });

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = AnimationController(
      vsync: this,
      duration: widget.velocity,
    )..addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _controller.value * maxScroll;
      _scrollController.jumpTo(currentScroll);
    }
  }

  void _startScrolling() {
    if (_scrollController.hasClients && _scrollController.position.maxScrollExtent > 0) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          Text(widget.text, style: widget.style),
          SizedBox(width: widget.gap),
          Text(widget.text, style: widget.style), // Repeat for seamless loop
        ],
      ),
    );
  }
}
