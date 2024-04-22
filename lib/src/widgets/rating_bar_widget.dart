import 'package:flutter/material.dart';

/// Callback function signature for rating change events.
typedef RatingChangeCallback = void Function(double rating);

/// A widget for displaying and interacting with a rating bar.
// ignore: must_be_immutable
class RatingBarWidget extends StatefulWidget {
  /// The initial rating value.
  double rating;

  /// The total number of rating items.
  final int itemCount;

  /// Callback function for when the rating changes.
  final RatingChangeCallback? onRatingChanged;

  /// The color of active rating items.
  final Color? activeColor;

  /// The color of inactive rating items.
  final Color? inActiveColor;

  /// The size of each rating item.
  final double size;

  /// Flag indicating whether half ratings are allowed.
  final bool allowHalfRating;

  /// The icon data for filled rating items.
  final IconData? filledIconData;

  /// The icon data for half-filled rating items.
  final IconData? halfFilledIconData;

  /// The default icon data for empty rating items.
  final IconData? defaultIconData;

  /// The spacing between rating items.
  final double spacing;

  /// Flag indicating whether the rating bar is disabled.
  final bool disable;

  RatingBarWidget({
    this.itemCount = 5,
    this.spacing = 0.0,
    this.rating = 0.0,
    this.defaultIconData,
    required this.onRatingChanged,
    this.activeColor = Colors.yellow,
    this.inActiveColor,
    this.size = 25,
    this.filledIconData,
    this.halfFilledIconData,
    this.allowHalfRating = false,
    this.disable = false,
    super.key,
  });

  @override
  _RatingBarWidgetState createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  /// Build rating bar widget
  Widget _buildItem(BuildContext context, int index) {
    Icon icon;
    if (index >= widget.rating) {
      icon = Icon(
        widget.defaultIconData ??
            (widget.halfFilledIconData ?? Icons.star_border),
        color: widget.inActiveColor ?? Colors.grey,
        size: widget.size,
      );
    } else if (index > widget.rating - (widget.allowHalfRating ? 0.5 : 1.0) &&
        index < widget.rating) {
      icon = Icon(
        widget.halfFilledIconData ?? Icons.star_half,
        color: widget.activeColor ?? Colors.grey,
        size: widget.size,
      );
    } else {
      icon = Icon(
        widget.filledIconData ?? Icons.star,
        color: widget.activeColor ?? Colors.grey,
        size: widget.size,
      );
    }

    return GestureDetector(
      onTap: () {
        widget.rating = index + 1.0;

        if (widget.onRatingChanged != null) {
          widget.onRatingChanged!(widget.rating);
        }

        setState(() {});
      },
      onHorizontalDragUpdate: (dragDetails) {
        RenderBox box = context.findRenderObject() as RenderBox;
        var _pos = box.globalToLocal(dragDetails.globalPosition);

        var i = _pos.dx / widget.size;
        var newRating = widget.allowHalfRating ? i : i.round().toDouble();
        if (newRating > widget.itemCount) {
          newRating = widget.itemCount.toDouble();
        }
        if (newRating < 0) {
          newRating = 0.0;
        }

        widget.rating = newRating;

        if (widget.onRatingChanged != null) {
          widget.onRatingChanged!(newRating);
        }

        setState(() {});
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.disable,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: widget.spacing,
        children: List.generate(
          widget.itemCount,
          (index) => _buildItem(context, index),
        ),
      ),
    );
  }
}
