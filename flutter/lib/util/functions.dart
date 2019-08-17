import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_tasks/exception/app_exception.dart';
import 'package:google_tasks/l10n/l10n.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:google_tasks/util/util.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:mono_kit/functions/functions.dart';

void dismissKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  AppFeedback.fromContext(context).show(L10n.of(context).copiedToPasteboard);
}

Future<bool> launchOrFallback(
  String url, {
  @required String fallbackUrl,
}) async {
  if (await canLaunch(url)) {
    return launch(url);
  } else {
    await launch(fallbackUrl);
    return false;
  }
}

String localizeError({
  @required dynamic error,
  @required L10n l10n,
}) {
  if (error == null) {
    return '';
  }
  if (error is PlatformException) {
    final code = error.code;
    switch (code) {
      case AuthErrorCodes.accountExistsWithDifferentCredential:
        return l10n.accountExistsWithDifferentCredential;
      case AuthErrorCodes.weakPassword:
      case AuthErrorCodes.wrongPassword:
        return l10n.errorInvalidPassword;
      case AuthErrorCodes.tooManyRequests:
        return l10n.errorTooManyRequests;
      case AuthErrorCodes.requiresRecentLogin:
        return l10n.errorRequiresRecentLogin;
      case AuthErrorCodes.userDisabled:
        return l10n.errorUserDisabled;
    }
    return error.message;
  }
  if (error is CloudFunctionsException) {
    return error.message;
  }
  if (error is AppException) {
    final code = error.code;
    if (code == AppErrorCodes.notImplemented) {
      return l10n.notImplemented;
    }
  }
  return error.toString();
}
