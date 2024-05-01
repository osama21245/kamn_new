import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kman/core/constants/firebase_constants.dart';
import 'package:kman/core/providers/firebase_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/constants.dart';
import '../../../core/faliure.dart';
import '../../../core/type_def.dart';
import '../../../models/reserved_model.dart';
import '../../../models/user_model.dart';

final AuthRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.watch(FirestoreProvider),
    auth: ref.watch(Provider((ref) => FirebaseAuth.instance)),
    googleSignIn: ref.watch(GoogleProvider)));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _firestore = firestore,
        _googleSignIn = googleSignIn,
        _auth = auth;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
  CollectionReference get _appstate =>
      _firestore.collection(FirebaseConstants.appStateCollection);
  String verifyid = "";
  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureVoid verifyPhone(String phone) async {
    try {
      return right(FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+20$phone',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          left(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyid = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      ));
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserCredential> sendCode(String code) async {
    try {
      UserCredential userCredential;
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verifyid, smsCode: code);
      userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          return right(userCredential);
        } else {
          return right(userCredential);
        }
      } else {
        return left(Failure("Erorr with code"));
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid verifyyPhone(String phone) async {
    try {
      return right(FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+20$phone',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          left(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyid = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      ));
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> saveUserModelToPrefs(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert UserModel to JSON and save it in shared preferences
    String userModelJson = json.encode(userModel.toJson());
    prefs.setString('userModel', userModelJson);
  }

  FutureEither<UserModel> signinWithGoogle(bool isFromLogin, String status,
      String region, String age, String gender) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: (googleAuth).accessToken, idToken: (googleAuth).idToken);
      UserCredential userCredential;
      if (isFromLogin) {
        userCredential = await _auth.signInWithCredential(credential);
      } else {
        userCredential =
            await _auth.currentUser!.linkWithCredential(credential);
      }

      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        print("===================================");

        userModel = UserModel(
            kamnGoldDiscount: 0,
            region: region,
            backGroundProfilePic: Constants.bannerDefault,
            isactive: true,
            ingroup: [],
            isonline: false,
            name: userCredential.user!.displayName ?? "No Name",
            profilePic: Constants.avatarDefault,
            phone: userCredential.user!.phoneNumber ?? "",
            age: age,
            uid: userCredential.user!.uid,
            isAuthanticated: true,
            points: 0,
            followers: [],
            city: "Alexandria",
            country: "Egypt",
            myGrounds: [],
            state: status,
            gender: gender,
            awards: ['gold']);
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      FirebaseMessaging.instance.subscribeToTopic("users");
      FirebaseMessaging.instance.subscribeToTopic("users${userModel.uid}");

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<ReserveModel>> getUserResevisions(String uid) {
    return _users.doc(uid).collection("reserve").snapshots().map((value) {
      List<ReserveModel> reservisions = [];
      for (var document in value.docs) {
        reservisions
            .add(ReserveModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return reservisions;
    });
  }

  FutureEither<UserModel> signInAsGuest() async {
    try {
      var userCredential = await _auth.signInAnonymously();

      UserModel userModel = UserModel(
          kamnGoldDiscount: 0,
          region: "default",
          backGroundProfilePic: Constants.bannerDefault,
          isactive: true,
          followers: [],
          name: 'Guest',
          profilePic: Constants.avatarDefault,
          uid: userCredential.user!.uid,
          isAuthanticated: false,
          points: 0,
          phone: "",
          age: "Enter Your Age",
          awards: [],
          city: "Set Your City",
          country: "Set Your City",
          myGrounds: [],
          state: "0",
          gender: "male",
          isonline: false,
          ingroup: []);

      await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      FirebaseMessaging.instance.subscribeToTopic("users");
      FirebaseMessaging.instance.subscribeToTopic("users${userModel.uid}");
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: "kamn$email@gmail.com", password: password);

      if (userCredential.user != null) {
        return right(userCredential);

        // Perform actions for a successful login
      } else {
        // userCredential.user is null, indicating unsuccessful login
        throw "Invalid email or password";

        // Perform actions for an unsuccessful login
      }
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> getAnyUserData(String email) async {
    try {
      UserModel? userdata;
      await _users.doc(email).get().then((value) {
        userdata = UserModel.fromMap(value.data() as Map<String, dynamic>);

        return userdata;
      });
      return right(userdata!);
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  getAppStatus() {
    try {
      bool? inUpdate;
      _appstate.doc("state").snapshots().map((value) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        inUpdate = data["inUpdate"];
        return inUpdate;
      });
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {}
  }

  FutureVoid editUser(UserModel userModel) async {
    try {
      return right(_users.doc(userModel.uid).update(userModel.toMap()));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  createAccountWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: "kamn$email@gmail.com", password: password);
      return right(userCredential);
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setUserData(UserModel userModel, String email) async {
    try {
      return right(_users.doc(email).set(userModel.toMap()));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<UserModel> getUserDataFuture(String uid) {
    return _users.doc(uid).get().then(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  FutureVoid updateUserState(String uid, bool isonline) async {
    try {
      if (isonline == true) {
        return right(_users.doc(uid).update({"isonline": isonline}));
      } else {
        return right(_users.doc(uid).update({"isonline": isonline}));
      }
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateUserServiceState(String uid, String state) async {
    try {
      return right(_users.doc(uid).update({"state": state}));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
