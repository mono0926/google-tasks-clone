import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin Messages {
  String get buttonUndo => Intl.message(
        'UNDO',
        name: 'buttonUndo',
      );
  String get buttonDone => Intl.message(
        'DONE',
        name: 'buttonDone',
      );
  String get welcomeTitle => Intl.message(
        'Welcome to Tasks',
        name: 'welcomeTitle',
      );
  String get copiedToPasteboard => Intl.message(
        'コピーしました。',
        name: 'copiedToPasteboard',
      );

  String get accountExistsWithDifferentCredential => Intl.message(
        '同一のメールアドレスに紐付いた他のアカウントで登録済みなので、'
        'そちらからログインしてください。',
        name: 'accountExistsWithDifferentCredential',
      );
  String get errorInvalidPassword => Intl.message(
        'パスワードが違います',
        name: 'errorInvalidPassword',
      );
  String get errorTooManyRequests => Intl.message(
        '連続してログインに失敗したため、しばらく利用できません',
        name: 'errorTooManyRequests',
      );
  String get errorRequiresRecentLogin => Intl.message(
        'その操作を実行するためには、再ログインが必要です。',
        name: 'errorRequiresRecentLogin',
      );
  String get errorUserDisabled => Intl.message(
        'アプリの利用制限がかかっているため、ご利用できません。',
        name: 'errorUserDisabled',
      );
  String get notImplemented => Intl.message(
        '未実装です',
        name: 'notImplemented',
      );

  String get errorOccurred => Intl.message(
        'エラーが発生しました',
        name: 'errorOccurred',
      );
  String get taskDeleted => Intl.message(
        '1件のタスクを削除しました',
        name: 'taskDeleted',
      );

  String timeOfDay(TimeOfDay time) => '';
}
