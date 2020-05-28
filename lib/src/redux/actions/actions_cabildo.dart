
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
  int cabildoId;
  SubmitCabildoSuccess(this.cabildoId);
}

class SubmitCabildoError {
  String error;
  SubmitCabildoError(this.error);
}

class FetchCabildoProfileAttempt {
  int idCabildo;
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

class PostCabildoFollowAttempt {
  int cabildoId;
  PostCabildoFollowAttempt(this.cabildoId);
}

class PostCabildoUnfollowAttempt {
  int cabildoId;
  PostCabildoUnfollowAttempt(this.cabildoId);
}
 class PostCabildoFollowError {
   String error;
   PostCabildoFollowError(this.error);
 }

 class PostCabildoFollowSuccess {
   int mode;
   int cabildoId;
   PostCabildoFollowSuccess(this.mode, this.cabildoId);
 }