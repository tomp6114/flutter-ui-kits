import 'package:flutter/material.dart';

/// A subtle adaptive parallax scrolling image mapping to viewport offsets elegantly natively.
class ParallaxImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double parallaxSpeed;

  const ParallaxImage({
    super.key,
    required this.imageUrl,
    this.height = 300,
    this.parallaxSpeed = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Flow(
            delegate: _ParallaxFlowDelegate(
              scrollable: Scrollable.of(context),
              listItemContext: context,
              speed: parallaxSpeed,
            ),
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: constraints.maxWidth,
                // The image should be taller than the container to allow for parallax movement.
                height: height * 1.5, 
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final double speed;

  _ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.speed,
  }) : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Get the position of this list item relative to the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );

    // Determine the percent of the way this item has scrolled.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background based on scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert alignment to a pixel offset.
    final backgroundSize = context.getChildSize(0)!;
    final listItemSize = context.size;
    final childRect = verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(0, childRect.top * speed),
      ).transform,
    );
  }

  @override
  bool shouldRepaint(_ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        speed != oldDelegate.speed;
  }
}
