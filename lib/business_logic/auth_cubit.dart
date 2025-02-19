import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  void setIsLoadingTrue() {
    isLoading = true;
    emit(AuthLoading());
  }

  void setIsLoadingFalse() {
    isLoading = false;
    emit(AuthInitial());
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  Future signInWithEmail({String? email, String? password}) async {
    setIsLoadingTrue();
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email:email?? emailController.text,
        password: password?? passwordController.text,
      );
      if(userCredential.user != null){
        Helpers.showColoredToast(color: Colors.greenAccent,message: 'Logged in successfully');

        return null;
      }else{
        Helpers.showColoredToast(color: Colors.redAccent,message: 'Failed to log in');

        return false;
      }

    } catch (e) {
      Helpers.showColoredToast(color: Colors.redAccent,message: e.toString());
      return false;
    } finally {
      setIsLoadingFalse();
    }
  }

  Future signUpWithEmail({String? email, String? password}) async {
    if((password??passwordController.text) != passwordConfirmationController.text){
      Helpers.showColoredToast(color: Colors.redAccent,message: 'Passwords do not match');
      return;
    }
    setIsLoadingTrue();
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email:email?? emailController.text,
        password: password?? passwordController.text,
      );
      if(userCredential.user != null){
        Helpers.showColoredToast(color: Colors.greenAccent,message: 'Account created successfully');
        emit(AuthSuccess(userCredential.user!));
        return null;
      }
      else{
        Helpers.showColoredToast(color: Colors.redAccent,message: 'Failed to create account');
        emit(AuthFailure('Account creation failed'));
        return false;
      }

    } catch (e) {
      Helpers.showColoredToast(color: Colors.redAccent,message: e.toString());
      emit(AuthFailure(e.toString()));
      return false;
    } finally {
      setIsLoadingFalse();
    }
  }

  Future<void> signOut() async {
    setIsLoadingTrue();
    try {
      await _firebaseAuth.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    } finally {
      setIsLoadingFalse();
    }
  }

  Future<void> resetPassword({String? email}) async {
    setIsLoadingTrue();
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email??emailController.text);
      emit(AuthInitial());
      Helpers.showColoredToast(color: Colors.greenAccent,message: 'Password reset email sent successfully');
    } catch (e) {
      Helpers.showColoredToast(color: Colors.redAccent,message: e.toString());
      emit(AuthFailure(e.toString()));
    } finally {
      setIsLoadingFalse();
    }
  }


  File? _selectedPdf;
  File? get selectedPdf => _selectedPdf;

  Future<void> pickPdf() async {
    _selectedPdf = null;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      _selectedPdf = File(result.files.single.path!);

    }
    emit(AuthInitial());
  }

  /// **CREATE User Profile in Firestore**
  Future<void> createUserProfile() async {
    setIsLoadingTrue();
    try {
      String userId = _firebaseAuth.currentUser!.uid;
      await _firestore.collection("users").doc(userId).set({
        "email": emailController.text,
        "uid": userId,
        "user_type": "consultant",
        "name": nameController.text,
        "phone": phoneController.text,
        "aboutMe": aboutMeController.text,
        "major": majorController.text,
        "createdAt": FieldValue.serverTimestamp(),
      });

      Helpers.showColoredToast(color: Colors.greenAccent, message: 'Profile created successfully');
      emit(AuthSuccess(_firebaseAuth.currentUser!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    } finally {
      setIsLoadingFalse();
    }
  }
}
