import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<void> signInWithPhoneNumber(
    String phoneNumber, {
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(String error) onError,
  }) async {

    final completer = Completer<void>();

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
        if (!completer.isCompleted) completer.complete();
      },
      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? 'Verification failed');
        if (!completer.isCompleted) completer.completeError(e.message ?? 'Verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId, resendToken);
        if (!completer.isCompleted) completer.complete();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (!completer.isCompleted) completer.complete();
      },
    );
    return completer.future;
  }

  static Future<UserCredential> verifySmsCode(
    String smsCode,
    String verificationId,
  ) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  static Future<void> resendCode(
  String phoneNumber, {
  required Function(String verificationId, int? resendToken) onCodeSent,
  required Function(String error) onError,
  int? resendToken,
}) async {
  final completer = Completer<void>();
  await _firebaseAuth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    forceResendingToken: resendToken, 
    verificationCompleted: (PhoneAuthCredential credential) async {
      await _firebaseAuth.signInWithCredential(credential);
      if (!completer.isCompleted) completer.complete();
    },
    verificationFailed: (FirebaseAuthException e) {
      onError(e.message ?? 'Resend failed');
      if (!completer.isCompleted) completer.completeError(e.message ?? 'Resend failed');
    },
    codeSent: (String newVerificationId, int? newResendToken) {
      onCodeSent(newVerificationId, newResendToken);
      if (!completer.isCompleted) completer.complete();
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      if (!completer.isCompleted) completer.complete();
    },
  );
  return completer.future;
}


  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}