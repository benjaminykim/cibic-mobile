
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
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
  String idCabildo;
  SubmitCabildoSuccess(this.idCabildo);
}

class SubmitCabildoError {
  String error;
  SubmitCabildoError(this.error);
}

class FetchCabildoProfileAttempt {
  String idCabildo;
  FetchCabildoProfileAttempt(this.idCabildo);
}

class FetchCabildoProfileSuccess {
  CabildoModel cabildo;
  FeedModel feed;
  FetchCabildoProfileSuccess(this.cabildo, this.feed);
}

class FetchCabildoProfileError {
  String error;
  FetchCabildoProfileError(this.error);
}

class FetchCabildoProfileClear {}