import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/utils/media_query_values.dart';

class ErrorWidgets extends StatelessWidget {
  const ErrorWidgets({Key? key, this.onPressed}) : super(key: key);
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: AppColors.primary,
            size: 160,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppStrings.somethingWentWrong,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppStrings.pleaseTryAgain,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
            minWidth: context.width * 0.55,
            color: AppColors.primary,
            onPressed: onPressed,
            child: Text(
              AppStrings.reloadScreen,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
