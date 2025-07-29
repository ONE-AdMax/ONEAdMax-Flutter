import 'package:flutter/material.dart';

/// InterstitialExtras class
/// Get extra configuration for Interstitial
/// - backgroundColor: set background color for Interstitial
/// - isHideCloseButton: hide close button
/// - isDisableBackButton: disable back button
/// - closeBtnMargin: set margin for close button
/// - endingText: set ending text for Interstitial
class InterstitialExtras {
  Color? backgroundColor;
  bool isHideCloseButton;

  bool isDisableBackButton;

  CloseBtnMargin closeBtnMargin;
  EndingText endingText;

  InterstitialExtras({
    this.backgroundColor,
    this.isHideCloseButton = false,
    this.isDisableBackButton = false,
    this.closeBtnMargin = const CloseBtnMargin(),
    this.endingText = const EndingText(null, 0, null, null, false),
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (backgroundColor != null) {
      data['backgroundColor'] = "#${backgroundColor?.toARGB32().toRadixString(16).padLeft(8, '0')}";
    }
    if (isHideCloseButton != false) {
      data['hideCloseBtn'] = isHideCloseButton;
    }
    if (isDisableBackButton != false) {
      data['disableBackBtn'] = isDisableBackButton;
    }
    data.addAll(closeBtnMargin.toMap());
    data.addAll(endingText.toMap());
    return data;
  }
}

class CloseBtnMargin {
  final int top;
  final int left;
  final int right;
  final int bottom;

  const CloseBtnMargin({
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (top != 0) {
      data['closeBtnTopMargin'] = top;
    }
    if (left != 0) {
      data['closeBtnLeftMargin'] = left;
    }
    if (right != 0) {
      data['closeBtnRightMargin'] = right;
    }
    if (bottom != 0) {
      data['closeBtnBottomMargin'] = bottom;
    }
    return data;
  }
}

class EndingText {
  final String? text;
  final int size;
  final Color? color;
  final TextAlign? align;
  final bool isShow;

  const EndingText(
    this.text,
    this.size,
    this.color,
    this.align,
    this.isShow,
  );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (text != null && text != '') {
      data['endingText'] = text;
    }
    if (size != 0) {
      data['endingTextSize'] = size;
    }
    if (color != null) {
      data['endingTextColor'] = color?.toARGB32().toRadixString(16);
    }
    if (align != null) {
      data['endingTextGravity'] = align?.toString();
    }
    if (isShow != false) {
      data['isEndingAd'] = isShow;
    }
    return data;
  }
}
