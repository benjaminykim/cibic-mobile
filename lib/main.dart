import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/onboard/app.dart';

Future<bool> addSelfSignedCertificate() async {
  ByteData data = await rootBundle.load('assets/cert/Cibic_Io.pem');
  SecurityContext context = SecurityContext.defaultContext;
  context.setTrustedCertificatesBytes(data.buffer.asUint8List());
  return true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  assert(await addSelfSignedCertificate());
  runApp(App());
}