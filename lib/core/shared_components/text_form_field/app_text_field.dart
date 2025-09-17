import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/app_colors/app_colors.dart';
import '../../common/app_font_style/app_font_style_global.dart';
import '../app_text/app_text.dart';
import '../app_text/models/app_text_model.dart';
import 'models/app_text_field_model.dart';

class AppTextField extends StatefulWidget {
  final AppTextFieldModel model;

  const AppTextField({super.key, required this.model});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
      } else {}
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.model.label != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: AppText(
              text: widget.model.label!,
              model: AppTextModel(
                style: AppFontStyleGlobal(Locale("en")).bodyMedium2.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        TextFormField(
          textAlign: widget.model.isRtl ? TextAlign.right : TextAlign.left,
          validator: widget.model.validator,
          cursorColor: AppColors.primaryColor,
          onTapOutside: (pointerDownEvent) {
            _focusNode.unfocus();
            FocusScope.of(context).unfocus();
          },
          onEditingComplete: () {
            _focusNode.unfocus();
            FocusScope.of(context).unfocus();
          },
          cursorWidth: 2.5,
          cursorHeight: 17,
          focusNode: _focusNode,
          controller: widget.model.controller,
          initialValue: widget.model.initialValue,
          inputFormatters: widget.model.inputFormatter,
          obscuringCharacter: '*',
          obscureText: widget.model.obscureInputText,
          readOnly: widget.model.readOnly,
          onChanged: widget.model.onChangeInput,
          onTap: widget.model.onTap,
          onFieldSubmitted: widget.model.onFieldSubmitted,
          maxLines: widget.model.maxLines,
          minLines: widget.model.minLines,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: widget.model.keyboardType,
          textInputAction: widget.model.textInputAction,
          decoration: widget.model.decoration,
          expands: widget.model.expands!,

          style:
              widget.model.style ??
              AppFontStyleGlobal(Locale("en")).bodyRegular1.copyWith(
                color: AppColors.grayColor,
                height:
                    widget.model.minLines > 1 &&
                        widget.model.controller!.text.isNotEmpty
                    ? null
                    : 1,
              ),
          // autovalidateMode: widget.model.autoValidateMode,
        ),
        if (widget.model.errorText != null) ...[
          if (widget.model.errorText!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsetsDirectional.only(start: 15.w, top: 5),
              child: AppText(
                text: widget.model.errorText.toString(),
                model: AppTextModel(
                  style: AppFontStyleGlobal(
                    Locale("en"),
                  ).smallTab.copyWith(color: AppColors.error, fontSize: 12.sp),
                ),
              ),
            ),
          ],
        ] else ...[
          if (widget.model.helperText != null &&
              widget.model.helperText!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsetsDirectional.only(start: 15.w, top: 5),
              child: AppText(
                text: widget.model.helperText.toString(),
                model: AppTextModel(
                  style: AppFontStyleGlobal(Locale("en")).smallTab.copyWith(
                    color: AppColors.txtGreyColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ],
      ],
    );
  }
}
