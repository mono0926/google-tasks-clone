// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "accountExistsWithDifferentCredential":
            MessageLookupByLibrary.simpleMessage(
                "同一のメールアドレスに紐付いた他のアカウントで登録済みなので、そちらからログインしてください。"),
        "buttonDone": MessageLookupByLibrary.simpleMessage("DONE"),
        "buttonUndo": MessageLookupByLibrary.simpleMessage("UNDO"),
        "copiedToPasteboard": MessageLookupByLibrary.simpleMessage("コピーしました。"),
        "errorInvalidPassword":
            MessageLookupByLibrary.simpleMessage("パスワードが違います"),
        "errorOccurred": MessageLookupByLibrary.simpleMessage("エラーが発生しました"),
        "errorRequiresRecentLogin":
            MessageLookupByLibrary.simpleMessage("その操作を実行するためには、再ログインが必要です。"),
        "errorTooManyRequests":
            MessageLookupByLibrary.simpleMessage("連続してログインに失敗したため、しばらく利用できません"),
        "errorUserDisabled":
            MessageLookupByLibrary.simpleMessage("アプリの利用制限がかかっているため、ご利用できません。"),
        "notImplemented": MessageLookupByLibrary.simpleMessage("未実装です"),
        "taskDeleted": MessageLookupByLibrary.simpleMessage("1件のタスクを削除しました"),
        "welcomeTitle": MessageLookupByLibrary.simpleMessage("Welcome to Tasks")
      };
}
