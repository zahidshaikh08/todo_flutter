import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class AppDropdown extends StatefulWidget {
  final List<String> valuesList;
  final Function onSelected;
  final String selectedValue;

  final Color? themeColor;
  final Color? canvasColor;
  final Color? themeTextColor;
  final Color? dropdownColor;
  final double vPadding;
  final double hPadding;
  final String? errorText;
  final Widget? arrowWidget;
  final bool validateGender;
  final double textSize;
  final bool isExpanded;
  final bool isDense;
  final bool isDecoration;
  final String? hint;
  final FocusNode? focusNode;
  final Color? focusColor;
  final VoidCallback onTap;
  final TextStyle? hintTextStyle;
  final TextStyle? dropDownTextStyle;
  final String? hintFontFamily;
  final String? dropDownFontFamily;

  const AppDropdown({
    Key? key,
    required this.valuesList,
    required this.onSelected,
    required this.selectedValue,
    required this.onTap,
    this.arrowWidget,
    this.validateGender = false,
    this.canvasColor = Colors.white,
    this.themeColor,
    this.themeTextColor,
    this.dropdownColor,
    this.vPadding = 0.0,
    this.hPadding = 0.0,
    this.errorText = '',
    this.textSize = 16.0,
    this.isExpanded = true,
    this.isDense = true,
    this.isDecoration = false,
    this.hint = '',
    this.focusNode,
    this.focusColor,
    this.hintTextStyle,
    this.dropDownTextStyle,
    this.hintFontFamily,
    this.dropDownFontFamily,
  }) : super(key: key);

  @override
  _AppDropdownState createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectedValue;
  }

  @override
  void didUpdateWidget(AppDropdown oldWidget) {
    if (dropdownValue != widget.selectedValue) {
      setState(() {
        dropdownValue = widget.selectedValue;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.valuesList.isEmpty || !widget.valuesList.contains(dropdownValue)) {
      dropdownValue = widget.selectedValue;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        !widget.isDecoration ? _buttonThemeWidget() : _buttonThemeWidgetWithUnderline(),
        _errorWidget(),
      ],
    );
  }

  Widget _errorWidget() {
    return Visibility(
      visible: (widget.errorText == null || widget.errorText == '') ? false : true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Texts(
              widget.errorText!,
              fontSize: 12.0,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonThemeWidget() {
    return ButtonTheme(
      alignedDropdown: true,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: widget.vPadding, horizontal: widget.hPadding),
        child: DropdownButtonHideUnderline(
          child: Listener(
            onPointerDown: (_) => FocusScope.of(context).unfocus(),
            child: DropdownButton<String>(
              dropdownColor: widget.dropdownColor,
              value: dropdownValue,
              isExpanded: widget.isExpanded,
              iconSize: 30,
              isDense: widget.isDense,
              icon: widget.arrowWidget,
              iconDisabledColor: widget.themeTextColor,
              iconEnabledColor: widget.themeTextColor,
              focusNode: widget.focusNode,
              focusColor: widget.focusColor,
              autofocus: false,
              onTap: widget.onTap,
              onChanged: (String? data) {
                setState(() {
                  dropdownValue = data!;
                  widget.onSelected(dropdownValue);
                });
              },
              style: TextStyle(
                color: widget.themeTextColor,
                fontSize: widget.textSize,
                fontFamily: widget.hintFontFamily,
              ),
              hint: Texts(
                widget.hint!,
                color: Colors.grey,
                fontFamily: widget.hintFontFamily,
              ),
              items: widget.valuesList.isNotEmpty
                  ? widget.valuesList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Texts(
                          value,
                          softWrap: true,
                          color: widget.themeTextColor,
                          fontSize: widget.textSize,
                          fontFamily: widget.dropDownFontFamily,
                        ),
                      );
                    }).toList()
                  : [dropdownValue].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Texts(
                          value,
                          softWrap: true,
                          color: widget.themeTextColor,
                          fontSize: widget.textSize,
                          fontFamily: widget.dropDownFontFamily,
                        ),
                      );
                    }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonThemeWidgetWithUnderline() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: widget.vPadding),
      child: DropdownMenuItem(
        child: Listener(
          onPointerDown: (_) => FocusScope.of(context).unfocus(),
          child: DropdownButton<String>(
            value: dropdownValue,
            isExpanded: widget.isExpanded,
            iconSize: 25,
            isDense: widget.isDense,
            icon: widget.arrowWidget,
            iconDisabledColor: widget.themeTextColor,
            iconEnabledColor: widget.themeTextColor,
            style: Texts.customTextStyle(
              color: widget.themeTextColor,
              fontSize: widget.textSize,
              fontFamily: widget.hintFontFamily,
            ),
            onChanged: (String? data) {
              setState(() {
                dropdownValue = data!;
                widget.onSelected(dropdownValue);
              });
            },
            items: widget.valuesList.isNotEmpty
                ? widget.valuesList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Texts(
                        value,
                        softWrap: true,
                        color: widget.themeTextColor,
                        fontSize: widget.textSize,
                        fontFamily: widget.dropDownFontFamily,
                      ),
                    );
                  }).toList()
                : [dropdownValue].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Texts(
                        value,
                        color: widget.themeTextColor,
                        fontSize: widget.textSize,
                        softWrap: true,
                        fontFamily: widget.dropDownFontFamily,
                      ),
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }
}
