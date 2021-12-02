import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'text_widget.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final TextDirection? hintTextDirection;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final String? errorText;
  final String? fontFamily;
  final FocusNode? focusNode;
  final bool? isObscure;
  final TextEditingController controller;
  final FormFieldValidator<String>? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final Function? onFieldTap;
  final Function(String)? onTextChanged;
  final String? label;
  final String? richS1;
  final String? richS2;
  final bool? hasDecoration;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final bool? enabled;
  final bool? autoFocus;
  final bool? filled;
  final Color? filledColor;
  final bool? hasFocus;
  final bool? isRequired;
  final String? obscureSymbol;
  final InputBorder? border;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final bool? wantListeners;
  final Function(bool)? onFocusChange;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? showCounter;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final TextCapitalization textCapitalization;
  final TextStyle? style;

  const TextFormFieldWidget({
    required this.controller,
    Key? key,
    this.hintText,
    this.hintTextDirection,
    this.hintStyle,
    this.focusNode,
    this.textInputType,
    this.defaultText,
    this.fontFamily,
    this.errorText,
    this.isObscure = false,
    this.functionValidate,
    this.parametersValidate,
    this.actionKeyboard = TextInputAction.next,
    this.onSaved,
    this.onFieldSubmitted,
    this.onFieldTap,
    this.onTextChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.richS1 = '',
    this.richS2 = '',
    this.hasDecoration = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.autoFocus = false,
    this.filled = false,
    this.filledColor = Colors.white,
    this.hasFocus = false,
    this.isRequired = false,
    this.obscureSymbol,
    this.border,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.wantListeners = false,
    this.onFocusChange,
    this.inputFormatters,
    this.maxLength,
    this.showCounter,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
    this.textAlign,
    this.textCapitalization = TextCapitalization.none,
    this.style,
  }) : super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  static var roundedBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(5.0),
  );

  @override
  void initState() {
    super.initState();

    if (widget.wantListeners == true) {
      widget.focusNode?.addListener(() {
        widget.onFocusChange?.call(widget.focusNode!.hasFocus);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return EnsureVisible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: widget.label == null,
            child: RichLabel(s1: widget.richS1!, s2: widget.richS2!),
          ),
          Visibility(
            visible: widget.label != null,
            child: Column(
              children: [
                Label(widget.label, fontSize: 14.0, isRequired: widget.isRequired!),
                const SizedBox(height: 6.0),
              ],
            ),
          ),
          TextFormField(
            key: widget.key,
            showCursor: true,
            cursorColor: Theme.of(context).primaryColor,
            obscureText: widget.isObscure!,
            keyboardType: widget.textInputType,
            textInputAction: widget.actionKeyboard,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            autofocus: widget.autoFocus!,
            textCapitalization: widget.textCapitalization,
            style: widget.style ??
                Texts.customTextStyle(
                  fontSize: 15.0,
                  fontFamily: widget.fontFamily,
                ),
            strutStyle: const StrutStyle(
              fontSize: 15.0,
              forceStrutHeight: true,
            ),
            initialValue: widget.defaultText,
            onChanged: widget.onTextChanged,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            keyboardAppearance: Theme.of(context).brightness,
            textAlign: widget.textAlign ?? TextAlign.start,
            buildCounter: (context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              filled: widget.filled,
              fillColor: widget.filled! ? widget.filledColor : null,
              hintText: widget.hintText,
              hintTextDirection: widget.hintTextDirection,
              hintStyle: widget.hintStyle ?? Texts.customTextStyle(color: Colors.grey, fontSize: 12.0),
              border: widget.hasDecoration! ? widget.border ?? roundedBorder : InputBorder.none,
              errorBorder: widget.hasDecoration!
                  ? widget.errorBorder ??
                      roundedBorder.copyWith(borderSide: const BorderSide(color: Colors.red))
                  : InputBorder.none,
              focusedBorder: widget.hasDecoration!
                  ? widget.focusedBorder ??
                      roundedBorder.copyWith(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      )
                  : InputBorder.none,
              focusedErrorBorder: widget.hasDecoration!
                  ? widget.focusedErrorBorder ??
                      roundedBorder.copyWith(
                        borderSide: const BorderSide(color: Colors.red),
                      )
                  : InputBorder.none,
              enabledBorder: widget.hasDecoration! ? widget.enabledBorder ?? roundedBorder : InputBorder.none,
              disabledBorder: widget.hasDecoration!
                  ? widget.disabledBorder ??
                      roundedBorder.copyWith(
                        borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                      )
                  : InputBorder.none,
              contentPadding: widget.contentPadding,
              isDense: true,
              errorText: widget.errorText,
              errorMaxLines: 2,
              errorStyle: Texts.customTextStyle(
                color: Colors.red,
                fontSize: 12.0,
                letterSpacing: 1.2,
              ),
            ),
            controller: widget.controller,
            validator: widget.functionValidate,
            maxLength: widget.maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            inputFormatters: widget.inputFormatters,
            onSaved: widget.onSaved,
            onFieldSubmitted: widget.onFieldSubmitted,
            onTap: () {
              if (widget.onFieldTap != null) widget.onFieldTap?.call();
            },
          ),
        ],
      ),
    );
  }
}

class RichLabel extends StatelessWidget {
  final String? s1;
  final String? s2;

  final Color? color;
  final double? fontSize;
  final String? fontFamily;

  const RichLabel({
    Key? key,
    this.s1,
    this.s2,
    this.color,
    this.fontSize = 13.0,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (s1 == null || s1?.isEmpty == true) {
      return const SizedBox();
    }
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: s1,
            style: Texts.customTextStyle(
              color: Colors.black,
              fontSize: fontSize!,
            ),
          ),
          TextSpan(
            text: s2,
            style: Texts.customTextStyle(
              color: Colors.red,
              fontSize: fontSize!,
            ),
          ),
        ],
      ),
    );
  }
}

class Label extends StatelessWidget {
  final String? label;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final bool isRequired;

  const Label(
    this.label, {
    Key? key,
    this.color,
    this.fontSize = 14.0,
    this.isRequired = false,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isRequired)
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Texts(
              "*",
              color: Colors.red,
              fontSize: fontSize!,
              fontFamily: fontFamily,
            ),
          ),
        Flexible(
          child: Texts(
            label!,
            color: color ?? Colors.black,
            fontSize: fontSize!,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

void changeFocus(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

class EnsureVisible extends StatefulWidget {
  final Widget child;

  const EnsureVisible({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _EnsureVisibleState createState() => _EnsureVisibleState();
}

class _EnsureVisibleState extends State<EnsureVisible> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.focusManager.addListener(autoScroll);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    WidgetsBinding.instance!.focusManager.removeListener(autoScroll);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    autoScroll();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void autoScroll() async {
    var focussedNode = WidgetsBinding.instance!.focusManager.primaryFocus;
    if (focussedNode != null) {
      var v = focussedNode.context?.findAncestorWidgetOfExactType<EnsureVisible>();
      if (v == widget) {
        // Flutter ALSO tries to adjust the focus / scroll
        await Future.delayed(const Duration(
          milliseconds: 50,
        ));
        // Make sure it's not past the bottom
        Scrollable.ensureVisible(
          context,
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
        );
        // // ...nor the top
        Scrollable.ensureVisible(
          context,
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
        );
      }
    }
  }
}
