import 'package:flutter/material.dart';
import 'package:reservilla/core/colors.dart';

class DefaultDropdown extends StatefulWidget {
  final String value;
  final EdgeInsetsGeometry? margin;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  
  const DefaultDropdown({
    super.key, 
    required this.value,
    this.margin,
    required this.onChanged, 
    required this.items
  });

  @override
  State<DefaultDropdown> createState() => _DefaultDropdownState();
}

class _DefaultDropdownState extends State<DefaultDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2, 
          color: contextOrange
        )
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            value: widget.value,
            isExpanded: true,
            onChanged: widget.onChanged,
            items: widget.items,
          ),
        )
      ),
    );
  }
}

class DefaultImageDropdown extends StatefulWidget {
  final String value;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final void Function(dynamic)? onChanged;
  final List<DropdownMenuItem>? items;

  const DefaultImageDropdown({
    super.key, 
    required this.value,
    this.width,
    this.margin, 
    required this.onChanged, 
    required this.items
  });

  @override
  State<DefaultImageDropdown> createState() => _DefaultImageDropdownState();
}

class _DefaultImageDropdownState extends State<DefaultImageDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2, 
          color: contextOrange
        )
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: widget.value,
            isExpanded: true,
            onChanged: widget.onChanged,
            items: widget.items,
          ),
        )
      ),
    );
  }
}