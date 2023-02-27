import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? textEditingController;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final FocusNode? focusNode;
  final String? hintText;
  final bool autoFocus;

  const SearchBar({
    @required this.textEditingController,
    @required this.onChange,
    @required this.onSubmit,
    @required this.focusNode,
    this.hintText,
    this.autoFocus = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool enableDarkMode=Theme.of(context).scaffoldBackgroundColor==AppStyles.grey;
    return Container(
      decoration: BoxDecoration(
        color: enableDarkMode ? Colors.white12 : const Color(0xffF5F6F7),
        borderRadius: BorderRadius.circular(30),
      ),
      width: double.infinity,
      height: 40.h,
      alignment: Alignment.center,
      child: TextFormField(
        controller: textEditingController,
        autofocus: autoFocus,
        style: AppStyles.title(
          context,
          fontSize: 15,
        ),
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        autocorrect: false,
        textInputAction: TextInputAction.search,
        focusNode: focusNode ?? FocusNode(),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(bottom: 2),
            icon: const Icon(
              Icons.keyboard_voice,
              color: Colors.blue,
              size: 18,
            ),
            onPressed: () {},
          ),
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:  BorderSide(color: enableDarkMode ? Colors.white12 : const Color(0xffF5F6F7)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:  BorderSide(color: enableDarkMode ? Colors.white12 : const Color(0xffF5F6F7)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:  BorderSide(
                color: enableDarkMode ? Colors.white12 : const Color(0xffF5F6F7)
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10),
          hintText: hintText ?? 'searchHintTextField',
          // LocaleKeys.searchHintTextField.tr(),
          hintStyle: AppStyles.copyStyle(
            color: Const.colorSubtext,
          ),
          // prefixIcon: Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 1),
          //   child: SvgPicture.asset(MyIcons.ic_search),
          // ),
        ),
      ),
    );
  }
}
