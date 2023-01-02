import 'package:flutter/material.dart';

import '../themes/theme.dart';

class SnackBarWidget extends StatelessWidget {
  const SnackBarWidget(
      {super.key,
      required this.message,
      this.error = false,
      this.subMessage,
      this.titleStyle});

  final String message;
  final bool error;
  final String? subMessage;
  final TextStyle? titleStyle;

  Color get bgColor => error ? AppColors.fabRedBackground : AppColors.primary;

  Color get textColor => AppColors.white;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 10,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(10)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: titleStyle ??
                        AppStyles.text14Px.copyWith(color: textColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subMessage != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subMessage ?? '',
                      style: AppStyles.text12Px.copyWith(color: textColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
