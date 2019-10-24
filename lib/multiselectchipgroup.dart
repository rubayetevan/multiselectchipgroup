library multiselectchipgroup;

import 'package:flutter/material.dart';

class MultiSelectChipGroup extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelectionChanged;
  final List<IconData> leftIcons;

  final Color selectedColor;
  final Color disabledColor;
  final Color labelSelectedColor;
  final Color labelDisabledColor;
  final Color iconDisabledColor;
  final Color iconSelectedColor;
  final IconData leftCommonIcon;
  final double leftIconSize;
  final EdgeInsetsGeometry padding;
  final double labelFontSize;
  final double horizontalChipSpacing;
  final double verticalChipSpacing;

  MultiSelectChipGroup(
      {@required this.items,
      @required this.selectedColor,
      @required this.disabledColor,
      this.onSelectionChanged,
      this.labelSelectedColor,
      this.labelDisabledColor,
      this.leftCommonIcon,
      this.padding,
      this.labelFontSize,
      this.leftIconSize,
      this.iconDisabledColor,
      this.iconSelectedColor,
      this.leftIcons,
      this.horizontalChipSpacing,
      this.verticalChipSpacing});

  @override
  _MultiSelectChipGroupState createState() => _MultiSelectChipGroupState();
}

class _MultiSelectChipGroupState extends State<MultiSelectChipGroup> {
  final List<String> selectedChoices = List<String>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> choiceChips = List<Widget>();
    widget.items.asMap().forEach((index, item) {
      choiceChips.add(choiceChip(item,
          leftIcon: widget.leftIcons != null ? widget.leftIcons[index] : null));
    });

    return Wrap(
      spacing: widget.horizontalChipSpacing == null
          ? 0
          : widget.horizontalChipSpacing,
      runSpacing:
          widget.verticalChipSpacing == null ? 0 : widget.verticalChipSpacing,
      children: choiceChips,
    );
  }

  Widget choiceChip(String item, {IconData leftIcon}) {
    return ChoiceChip(
      labelStyle: TextStyle(
          fontSize: widget.labelFontSize == null ? 14 : widget.labelFontSize,
          color: selectedChoices.contains(item)
              ? widget.labelSelectedColor == null
                  ? widget.disabledColor
                  : widget.labelSelectedColor
              : widget.labelDisabledColor == null
                  ? widget.selectedColor
                  : widget.labelDisabledColor),
      selectedColor: widget.selectedColor,
      disabledColor: widget.disabledColor,
      backgroundColor: widget.disabledColor,
      labelPadding: widget.padding,
      padding: widget.padding,
      avatar: widget.leftCommonIcon == null && leftIcon == null
          ? null
          : Icon(
              leftIcon == null ? widget.leftCommonIcon : leftIcon,
              color: selectedChoices.contains(item)
                  ? widget.iconSelectedColor == null
                      ? widget.disabledColor
                      : widget.iconSelectedColor
                  : widget.iconDisabledColor == null
                      ? widget.selectedColor
                      : widget.iconDisabledColor,
              size: widget.leftIconSize == null ? 16 : widget.leftIconSize,
            ),
      label: Text(item),
      selected: selectedChoices.contains(item) ? true : false,
      onSelected: (selected) {
        setState(() {
          selectedChoices.contains(item)
              ? selectedChoices.remove(item)
              : selectedChoices.add(item);
          if (widget.onSelectionChanged != null)
            widget.onSelectionChanged(selectedChoices); // +added
        });
      },
    );
  }
}
