class ErrorCode {
  final _value;

  const ErrorCode._internal(this._value);

  static const INVALID_PASSWORD       = const ErrorCode._internal(0);
  static const INVALID_TOKEN          = const ErrorCode._internal(1);

  @override
  String toString() {
    switch (_value) {
      case 0:
        return 'INVALID_PASSWORD';
      case 1:
        return 'INVALID_TOKEN';
      default:
        return '';
    }
  }

  static ErrorCode valueOf(int data) {
    switch (data) {
      case 0:
        return INVALID_PASSWORD;
      case 1:
        return INVALID_TOKEN;
      default:
        return null;
    }
  }

  int getValue() {
    return _value as int;
  }

}
