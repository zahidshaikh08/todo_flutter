import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/base/extension/common_extentions.dart';

import 'text_field_widget.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onTextChanged;
  final VoidCallback? onFilter;
  final String? hint;
  final Widget? suffixIcon;

  const SearchTextField({
    Key? key,
    required this.controller,
    this.onTextChanged,
    this.hint,
    this.onFilter,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? debouncer;

  bool isRequested = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormFieldWidget(
        hintText: widget.hint ?? "Search",
        controller: widget.controller,
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.done,
        onTextChanged: onSearchInputChange,
        hasDecoration: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(30),
        ),
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.all(17.0),
        //   child: SvgImage(
        //     Assets.svgSearch,
        //     width: 10,
        //     height: 10,
        //     color: Theme.of(context).primaryColor,
        //   ),
        // ),
        // maxLines: 1,
        // contentPadding: EdgeInsetsDirectional.only(
        //   start: isRTL ? 20 : 15,
        //   end: isRTL ? 20 : 35,
        //   bottom: 15,
        //   top: 15,
        // ),
        onFieldSubmitted: (value) {},
      ),
    );
  }

  void onSearchInputChange(String value) {
    if (value.trim().removeSpaces().isEmpty) {
      debouncer?.cancel();
      if (isRequested == false) {
        isRequested = true;
        widget.onTextChanged?.call(value.trim());
      }
      return;
    }

    if (debouncer?.isActive ?? false) {
      debouncer!.cancel();
    }

    debouncer = Timer(const Duration(milliseconds: 500), () {
      isRequested = false;
      widget.onTextChanged?.call(value.trim());
    });
  }
}
