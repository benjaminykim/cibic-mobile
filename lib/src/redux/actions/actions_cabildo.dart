
import 'package:flutter/material.dart';

class SubmitCabildoAttempt {
  String name;
  String desc;
  String location;
  String tag;
  BuildContext context;
  SubmitCabildoAttempt(this.name, this.desc, this.location, this.tag, this.context);
}

class SubmitCabildoSuccess {
  int cabildoId;
  SubmitCabildoSuccess(this.cabildoId);
}

class SubmitCabildoError {
  String error;
  SubmitCabildoError(this.error);
}