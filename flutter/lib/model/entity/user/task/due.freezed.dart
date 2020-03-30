// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'due.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Due _$DueFromJson(Map<String, dynamic> json) {
  return _Due.fromJson(json);
}

class _$DueTearOff {
  const _$DueTearOff();

  _Due call(@TimestampConverter() DateTime dateTime,
      {bool includeTime = false}) {
    return _Due(
      dateTime,
      includeTime: includeTime,
    );
  }
}

// ignore: unused_element
const $Due = _$DueTearOff();

mixin _$Due {
  @TimestampConverter()
  DateTime get dateTime;
  bool get includeTime;

  Map<String, dynamic> toJson();
  $DueCopyWith<Due> get copyWith;
}

abstract class $DueCopyWith<$Res> {
  factory $DueCopyWith(Due value, $Res Function(Due) then) =
      _$DueCopyWithImpl<$Res>;
  $Res call({@TimestampConverter() DateTime dateTime, bool includeTime});
}

class _$DueCopyWithImpl<$Res> implements $DueCopyWith<$Res> {
  _$DueCopyWithImpl(this._value, this._then);

  final Due _value;
  // ignore: unused_field
  final $Res Function(Due) _then;

  @override
  $Res call({
    Object dateTime = freezed,
    Object includeTime = freezed,
  }) {
    return _then(_value.copyWith(
      dateTime: dateTime == freezed ? _value.dateTime : dateTime as DateTime,
      includeTime:
          includeTime == freezed ? _value.includeTime : includeTime as bool,
    ));
  }
}

abstract class _$DueCopyWith<$Res> implements $DueCopyWith<$Res> {
  factory _$DueCopyWith(_Due value, $Res Function(_Due) then) =
      __$DueCopyWithImpl<$Res>;
  @override
  $Res call({@TimestampConverter() DateTime dateTime, bool includeTime});
}

class __$DueCopyWithImpl<$Res> extends _$DueCopyWithImpl<$Res>
    implements _$DueCopyWith<$Res> {
  __$DueCopyWithImpl(_Due _value, $Res Function(_Due) _then)
      : super(_value, (v) => _then(v as _Due));

  @override
  _Due get _value => super._value as _Due;

  @override
  $Res call({
    Object dateTime = freezed,
    Object includeTime = freezed,
  }) {
    return _then(_Due(
      dateTime == freezed ? _value.dateTime : dateTime as DateTime,
      includeTime:
          includeTime == freezed ? _value.includeTime : includeTime as bool,
    ));
  }
}

@JsonSerializable()
class _$_Due with DiagnosticableTreeMixin implements _Due {
  const _$_Due(@TimestampConverter() this.dateTime, {this.includeTime = false})
      : assert(dateTime != null),
        assert(includeTime != null);

  factory _$_Due.fromJson(Map<String, dynamic> json) => _$_$_DueFromJson(json);

  @override
  @TimestampConverter()
  final DateTime dateTime;
  @JsonKey(defaultValue: false)
  @override
  final bool includeTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Due(dateTime: $dateTime, includeTime: $includeTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Due'))
      ..add(DiagnosticsProperty('dateTime', dateTime))
      ..add(DiagnosticsProperty('includeTime', includeTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Due &&
            (identical(other.dateTime, dateTime) ||
                const DeepCollectionEquality()
                    .equals(other.dateTime, dateTime)) &&
            (identical(other.includeTime, includeTime) ||
                const DeepCollectionEquality()
                    .equals(other.includeTime, includeTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(dateTime) ^
      const DeepCollectionEquality().hash(includeTime);

  @override
  _$DueCopyWith<_Due> get copyWith =>
      __$DueCopyWithImpl<_Due>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DueToJson(this);
  }
}

abstract class _Due implements Due {
  const factory _Due(@TimestampConverter() DateTime dateTime,
      {bool includeTime}) = _$_Due;

  factory _Due.fromJson(Map<String, dynamic> json) = _$_Due.fromJson;

  @override
  @TimestampConverter()
  DateTime get dateTime;
  @override
  bool get includeTime;
  @override
  _$DueCopyWith<_Due> get copyWith;
}
