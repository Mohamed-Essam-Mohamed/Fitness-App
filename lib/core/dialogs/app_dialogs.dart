import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  // Show a loading dialog
  static void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            // backgroundColor: Colors.transparent,
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(message ?? LocaleKeys.Loading.tr()),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Show a message dialog with two actions
  static void showMessage({
    required BuildContext context,
    required String title,
    required TextStyle titleStyle,
    required String message,
    required TextStyle messageStyle,
    required VoidCallback onPressedAction1,
    required VoidCallback onPressedAction2,
    required String titleAction1,
    required String titleAction2,
    // required TextStyle titleAction1Style,
    // required TextStyle titleAction2Style,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: _buttonAction(
                    onPressed: onPressedAction1,
                    context: context,
                    title: titleAction1,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buttonAction(
                    onPressed: onPressedAction2,
                    title: titleAction2,
                    context: context,
                    colorBackground: Colors.transparent,
                    colorText: AppColors.orange,
                    haveBorder: true,
                  ),
                ),
              ],
            ),
          ],
          contentTextStyle: messageStyle,
          titleTextStyle: titleStyle,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: AppColors.white,
          elevation: 0,
        );
      }),
    );
  }

  static Widget _buttonAction({
    required String title,
    required VoidCallback onPressed,
    required BuildContext context,
    double? radius,
    Color? colorBackground,
    Color? colorText,
    FontWeight? fontWeight,
    bool haveBorder = false,
  }) {
    return MaterialButton(
      elevation: 0,
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 50),
        side: BorderSide(
          color: haveBorder ? AppColors.orange : Colors.transparent,
          width: 1,
        ),
      ),
      onPressed: onPressed,
      color: colorBackground ?? AppColors.orange,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: colorText ?? AppColors.white,
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
      ),
    );
  }

  static void showSuccessDialog(
    BuildContext context, {
    required String message,
    String? buttonText,
    String? nextActionTitle,
    VoidCallback? nextAction,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(message),
            ],
          ),
          actions: [
            if (nextActionTitle != null)
              TextButton(
                onPressed: nextAction,
                child: Text(nextActionTitle),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(buttonText ?? LocaleKeys.Ok.tr()),
            ),
          ],
        );
      },
    );
  }

  // Show a failure dialog
  static void showFailureDialog(
    BuildContext context, {
    required String message,
    String? buttonText,
    VoidCallback? nextAction,
    String? nextActionTitle,
    String? title,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: Text(title ?? LocaleKeys.Error,style: TextStyle(color: AppColors.orange),),
          content: Text(message ,style: TextStyle(color: AppColors.orange)),

          actions: [
            if (nextAction != null && nextActionTitle != null)
              TextButton(
                onPressed: nextAction,
                child: Text(nextActionTitle),
              ),
            TextButton(
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              child: Text(
                buttonText ?? LocaleKeys.Ok,
                style: const TextStyle(color: AppColors.orange),
              ),
            ),
          ],
        );
      },
    );
  }
}


typedef DialogOnConfirm = void Function();

class AppCustomDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const AppCustomDialog({
    Key? key,
    required this.title,
    this.message,
    this.confirmButtonText = 'OK',
    this.cancelButtonText = 'Cancel',
    required this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: const Color(0xFF424242),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 12.0),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14.0,
                ),
              ),
            ],
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      onCancel?.call();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(0.5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Text(
                      cancelButtonText.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF4F00),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      elevation: 0,
                    ),
                    child: Text(
                      confirmButtonText.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


