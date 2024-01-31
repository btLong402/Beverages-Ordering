import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void failure(BuildContext context, String title, String message) {
  // Check if the context's widget is mounted
  if (ScaffoldMessenger.of(context).mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.failure,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
void success(BuildContext context, String title, String message) {
  // Check if the context's widget is mounted
  if (ScaffoldMessenger.of(context).mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.success,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

void warning(context, title, message) {
  if (ScaffoldMessenger.of(context).mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.warning,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
