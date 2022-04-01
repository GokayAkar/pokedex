import 'package:flutter/material.dart';

extension Padding on double {
  Widget get horizontal => SizedBox(width: this);
  Widget get vertical => SizedBox(height: this);
  Widget get cube => SizedBox(height: this, width: this);
}
