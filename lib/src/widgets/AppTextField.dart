import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/utils/text_styles.dart';

enum TextFieldType { EMAIL, PASSWORD, NAME, ADDRESS, OTHER, PHONE, URL }

/// Default Text Form Field
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextFieldType textFieldType;

  final InputDecoration? decoration;
  final FocusNode? focus;
  final FormFieldValidator<String>? validator;
  final bool? isPassword;
  final bool? isValidationRequired;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final FocusNode? nextFocus;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool? autoFocus;
  final bool? readOnly;
  final bool? enableSuggestions;
  final int? maxLength;
  final Color? cursorColor;
  final Widget? suffix;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final Iterable<String>? autoFillHints;
  final EdgeInsets? scrollPadding;
  final double? cursorWidth;
  final double? cursorHeight;
  final Function()? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  final List<TextInputFormatter>? inputFormatters;

  final String? errorThisFieldRequired;
  final String? errorInvalidEmail;
  final String? errorMinimumPasswordLength;
  final String? errorInvalidURL;

  AppTextField({
    this.controller,
    required this.textFieldType,
    this.decoration,
    this.focus,
    this.validator,
    this.isPassword,
    this.buildCounter,
    this.isValidationRequired,
    this.textCapitalization,
    this.textInputAction,
    this.onFieldSubmitted,
    this.nextFocus,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.onChanged,
    this.cursorColor,
    this.suffix,
    this.suffixIconColor,
    this.enableSuggestions,
    this.autoFocus,
    this.readOnly,
    this.maxLength,
    this.keyboardType,
    this.autoFillHints,
    this.scrollPadding,
    this.onTap,
    this.cursorWidth,
    this.cursorHeight,
    this.inputFormatters,
    this.errorThisFieldRequired,
    this.errorInvalidEmail,
    this.errorMinimumPasswordLength,
    this.errorInvalidURL,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isPasswordVisible = false;

  FormFieldValidator<String>? applyValidation() {
    if (widget.isValidationRequired.validate(value: true)) {
      if (widget.validator != null) {
        return widget.validator;
      } else if (widget.textFieldType == TextFieldType.EMAIL) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: errorThisFieldRequired);
          if (!s.trim().validateEmail())
            return widget.errorInvalidEmail.validate(value: 'Email is invalid');
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.PASSWORD) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: errorThisFieldRequired);
          if (s.trim().length < passwordLengthGlobal)
            return widget.errorMinimumPasswordLength.validate(
                value:
                    'Minimum password length should be $passwordLengthGlobal');
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.NAME ||
          widget.textFieldType == TextFieldType.PHONE) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: errorThisFieldRequired);
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.URL) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: errorThisFieldRequired);
          if (!s.validateURL()) {
            return widget.errorInvalidURL.validate(value: 'Invalid URL');
          }
          return null;
        };
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  TextCapitalization applyTextCapitalization() {
    if (widget.textCapitalization != null) {
      return widget.textCapitalization!;
    } else if (widget.textFieldType == TextFieldType.NAME) {
      return TextCapitalization.words;
    } else if (widget.textFieldType == TextFieldType.ADDRESS) {
      return TextCapitalization.sentences;
    } else {
      return TextCapitalization.none;
    }
  }

  TextInputAction? applyTextInputAction() {
    if (widget.textInputAction != null) {
      return widget.textInputAction;
    } else if (widget.textFieldType == TextFieldType.ADDRESS) {
      return TextInputAction.newline;
    } else if (widget.nextFocus != null) {
      return TextInputAction.next;
    } else {
      return TextInputAction.done;
    }
  }

  TextInputType? applyTextInputType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType;
    } else if (widget.textFieldType == TextFieldType.EMAIL) {
      return TextInputType.emailAddress;
    } else if (widget.textFieldType == TextFieldType.ADDRESS) {
      return TextInputType.multiline;
    } else if (widget.textFieldType == TextFieldType.PASSWORD) {
      return TextInputType.visiblePassword;
    } else if (widget.textFieldType == TextFieldType.PHONE) {
      return TextInputType.number;
    } else if (widget.textFieldType == TextFieldType.URL) {
      return TextInputType.url;
    } else {
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText:
          widget.textFieldType == TextFieldType.PASSWORD && !isPasswordVisible,
      validator: applyValidation(),
      textCapitalization: applyTextCapitalization(),
      textInputAction: applyTextInputAction(),
      onFieldSubmitted: (s) {
        if (widget.nextFocus != null)
          FocusScope.of(context).requestFocus(widget.nextFocus);

        if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!.call(s);
      },
      keyboardType: applyTextInputType(),
      decoration: widget.decoration != null
          ? (widget.decoration!.copyWith(
              suffixIcon: widget.textFieldType == TextFieldType.PASSWORD
                  ? widget.suffix != null
                      ? widget.suffix
                      : Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: widget.suffixIconColor ??
                              Theme.of(context).iconTheme.color,
                        ).onTap(() {
                          isPasswordVisible = !isPasswordVisible;

                          setState(() {});
                        })
                  : widget.suffix,
            ))
          : InputDecoration(),
      focusNode: widget.focus,
      style: widget.textStyle ?? primaryTextStyle(),
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: widget.textFieldType == TextFieldType.ADDRESS
          ? null
          : widget.maxLines.validate(value: 1),
      minLines: widget.minLines.validate(value: 1),
      autofocus: widget.autoFocus ?? false,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      cursorColor: widget.cursorColor ??
          Theme.of(context).textSelectionTheme.cursorColor,
      readOnly: widget.readOnly.validate(),
      maxLength: widget.maxLength,
      enableSuggestions: widget.enableSuggestions.validate(value: true),
      autofillHints: widget.autoFillHints,
      scrollPadding: widget.scrollPadding ?? EdgeInsets.all(20),
      cursorWidth: widget.cursorWidth.validate(value: 2.0),
      cursorHeight: widget.cursorHeight,
      cursorRadius: radiusCircular(4),
      onTap: widget.onTap,
      buildCounter: widget.buildCounter,
      scrollPhysics: BouncingScrollPhysics(),
      enableInteractiveSelection: true,
      inputFormatters: widget.inputFormatters,
    );
  }
}
