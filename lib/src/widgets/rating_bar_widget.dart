import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

/// RatingBarWidget
// ignore: must_be_immutable
class RatingBarWidget extends StatefulWidget {
  // Initial Rating
  double rating;

  final int itemCount;
  final RatingChangeCallback? onRatingChanged;
  final Color? activeColor;
  final Color? inActiveColor;
  final double size;
  final bool allowHalfRating;
  final IconData? filledIconData;
  final IconData? halfFilledIconData;
  final IconData? defaultIconData;
  final double spacing;
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
    Key? key,
  }) : super(key: key);

  @override
  _RatingBarWidgetState createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  Widget _buildItem(BuildContext context, int index) {
    Icon icon;
    if (index >= widget.rating) {
      icon = Icon(
        widget.defaultIconData != null
            ? widget.defaultIconData
            : (widget.halfFilledIconData ?? Icons.star_border),
        color: widget.inActiveColor ?? Colors.grey,
        size: widget.size,
      );
    } else if (index > widget.rating - (widget.allowHalfRating ? 0.5 : 1.0) &&
        index < widget.rating) {
      icon = Icon(
        widget.halfFilledIconData != null
            ? widget.halfFilledIconData
            : Icons.star_half,
        color: widget.activeColor ?? Colors.grey,
        size: widget.size,
      );
    } else {
      icon = Icon(
        widget.filledIconData != null ? widget.filledIconData : Icons.star,
        color: widget.activeColor ?? Colors.grey,
        size: widget.size,
      );
    }

    return GestureDetector(
      onTap: () {
        widget.rating = index + 1.0;

        if (this.widget.onRatingChanged != null)
          widget.onRatingChanged!(widget.rating);

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

        if (this.widget.onRatingChanged != null)
          widget.onRatingChanged!(newRating);

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
            widget.itemCount, (index) => _buildItem(context, index)),
      ),
    );
  }
}
