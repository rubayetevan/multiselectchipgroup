library multiselectchipgroup;

import 'package:flutter/material.dart';

class MultiSelectChipGroup extends StatefulWidget {
  final List<String> items;
  final Function(List<String>)? onSelectionChanged;
  final List<IconData>? leftIcons;
  final WrapAlignment? alignment;
  final WrapAlignment? runAlignment;
  final Color selectedColor;
  final Color disabledColor;
  final Color? labelSelectedColor;
  final Color? labelDisabledColor;
  final Color? iconDisabledColor;
  final Color? iconSelectedColor;
  final IconData? leftCommonIcon;
  final double? leftIconSize;
  final EdgeInsetsGeometry? padding;
  final double? labelFontSize;
  final double? horizontalChipSpacing;
  final double? verticalChipSpacing;
  final List<String>? preSelectedItems;

  MultiSelectChipGroup(
      {required this.items,
      required this.selectedColor,
      required this.disabledColor,
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
      this.verticalChipSpacing,
      this.preSelectedItems,
      this.alignment,
      this.runAlignment});

  @override
  _MultiSelectChipGroupState createState() =>
      _MultiSelectChipGroupState(preSelectedItems, onSelectionChanged);
}

class _MultiSelectChipGroupState extends State<MultiSelectChipGroup> {
  List<String> selectedChoices = <String>[];

  _MultiSelectChipGroupState(List<String>? preSelectedItems,
      Function(List<String>)? onSelectionChanged) {
    if (preSelectedItems != null) {
      selectedChoices = preSelectedItems;
      if (onSelectionChanged != null) onSelectionChanged(selectedChoices);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> choiceChips = <Widget>[];
    widget.items.asMap().forEach((index, item) {
      choiceChips.add(choiceChip(item,
          leftIcon: widget.leftIcons != null ? widget.leftIcons![index] : null));
    });

    return Wrap(
      alignment: widget.alignment ?? WrapAlignment.start,
      runAlignment: widget.runAlignment ?? WrapAlignment.start,
      spacing: widget.horizontalChipSpacing == null
          ? 0
          : widget.horizontalChipSpacing!,
      runSpacing:
          widget.verticalChipSpacing == null ? 0 : widget.verticalChipSpacing!,
      children: choiceChips,
    );
  }

  Widget choiceChip(String item, {IconData? leftIcon}) {
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
            widget.onSelectionChanged!(selectedChoices); // +added
        });
      },
    );
  }
}
