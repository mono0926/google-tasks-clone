#!/usr/bin/env bash

# arbファイル(文言リソースのJSONファイル)の作成
flutter packages pub run intl_translation:extract_to_arb \
    --locale=messages \
    --output-dir=lib/l10n \
    lib/l10n/messages.dart

# 生成された雛形のintl_messages.arbをコピーしてintl_en.arbを作成
# 警告抑制のため、@@localeだけ指定
# 言語リソースが見つからなかったらIntl.messageに指定されている文言が使われるので
# デフォルト文言のarbは不要かも
cat lib/l10n/intl_messages.arb | \
    sed -e 's/"@@locale": "messages"/"@@locale": "en"/g' > \
    lib/l10n/intl_en.arb

# このタイミングで、必要に応じて、メインの言語以外のarbファイルを用意

# arbファイル群から多言語対応に必要なクラスを生成
flutter packages pub run intl_translation:generate_from_arb \
    --output-dir=lib/l10n \
    --no-use-deferred-loading \
    lib/l10n/messages.dart \
    lib/l10n/intl_*.arb
