import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum OAMCloseEvent {
  UNKNOWN,
  CLICK_CLOSE_BTN,
  PRESSED_BACK_KEY,
  AUTO_CLOSE;

  factory OAMCloseEvent.fromJson(String value) {
    switch (value) {
      case "CLICK_CLOSE_BTN":
        return CLICK_CLOSE_BTN;
      case "PRESSED_BACK_KEY":
        return PRESSED_BACK_KEY;
      case "AUTO_CLOSE":
        return AUTO_CLOSE;
      default:
        return UNKNOWN;
    }
  }
}
