import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class SearchBox extends StatefulWidget {
  final String? hints;
  final Color? backgroundColor, borderColor;
  final Function(String) onChanged;
  const SearchBox(
      {super.key,
      this.hints,
      this.backgroundColor,
      this.borderColor,
      required this.onChanged});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();
  bool hastext = false;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        if (controller.text.isNotEmpty) {
          hastext = true;
        } else {
          hastext = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SizedBox(
        height: 50.h,
        child: TextFormField(
          focusNode: node,
          controller: controller,
          onChanged: (v) {
            widget.onChanged(v);
          },
          decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: widget.backgroundColor ?? AppColors.white,
              suffixIcon: hastext
                  ? InkWell(
                      onTap: () {
                        controller.text = "";
                        widget.onChanged("");
                        node.unfocus();
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColors.errorColor,
                      ),
                    )
                  : Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.lightGray,
                    width: 1.w),
                borderRadius: BorderRadius.circular(4.r),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 1.w),
                  borderRadius: BorderRadius.circular(4.r)),
              hintText: widget.hints),
        ),
      ),
    );
  }
}
