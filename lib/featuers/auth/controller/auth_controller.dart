import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/core/constants/services/services.dart';
import 'package:kman/featuers/auth/screens/finish_screen.dart';
import 'package:kman/featuers/auth/screens/login_screen.dart';
import 'package:kman/homemain.dart';
import '../../../core/constants/constants.dart';
import '../../../core/providers/storage_repository.dart';
import '../../../core/utils.dart';
import '../../../models/reserved_model.dart';
import '../../../models/user_model.dart';
import '../repositories/auth_repository.dart';

final authStateCahngeProvider = StreamProvider((ref) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.getUserData(uid);
});
final getUserDataFutureProvider = FutureProvider.family((ref, String uid) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.getUserFutureData(uid);
});

final getUserReservisionss = StreamProvider(
    (ref) => ref.watch(authControllerProvider.notifier).getUserResevisions());

StateProvider<UserModel?> usersProvider =
    StateProvider<UserModel?>((ref) => null);

StateNotifierProvider<AuthController, StatusRequest> authControllerProvider =
    StateNotifierProvider<AuthController, StatusRequest>((ref) =>
        AuthController(
            authRepository: ref.watch(AuthRepositoryProvider),
            ref: ref,
            storageRepository: ref.watch(storageRepositoryProvider)));

class AuthController extends StateNotifier<StatusRequest> {
  final Ref _ref;
  final AuthRepository _authRepository;
  final StorageRepository _storageRepository;
  AuthController(
      {required AuthRepository authRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _authRepository = authRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(StatusRequest.success);
  bool? inUpdate;
  UserModel? userModel;

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  Future<UserModel> getUserFutureData(String uid) {
    return _authRepository.getUserDataFuture(uid);
  }

  Stream<List<ReserveModel>> getUserResevisions() {
    final user = _ref.watch(usersProvider);
    return _authRepository.getUserResevisions(user!.uid);
  }

  signinWithGoogle(BuildContext context, bool isFromLogin, String status,
      String region, String age, String gender) async {
    state = StatusRequest.loading;
    final user = await _authRepository.signinWithGoogle(
        isFromLogin, status, region, age, gender);
    state = StatusRequest.success;
    MyServices myServices = Get.find();
    user.fold((l) => showSnackBar(l.message, context), (userModel) async {
      myServices.sharedPreferences.setString("step", "2");
      myServices.sharedPreferences.setString("check", "1");
      myServices.sharedPreferences.setString("step", "2");
      final res = await _authRepository.getAnyUserData(
        userModel.uid,
      );
      res.fold((l) => showSnackBar(l.message, context), (r) async {
        print(r.state);
        await _authRepository.saveUserModelToPrefs(r);
        Get.offAll(() => HomeMain());
      });
    });
  }

  void signInAsGuest(BuildContext context) async {
    state = StatusRequest.loading;
    final user = await _authRepository.signInAsGuest();
    MyServices myServices = Get.find();
    state = StatusRequest.success;

    user.fold((l) => showSnackBar(l.message, context), (userModel) async {
      myServices.sharedPreferences.setString("step", "2");
      _authRepository.saveUserModelToPrefs(userModel);
      _ref.read(usersProvider.notifier).update((state) => userModel);
      Get.offAll(() => HomeMain());
    });
  }

  void editUser(
      {required File? profileFile,
      required BuildContext context,
      required UserModel userModel,
      required WidgetRef ref}) async {
    state = StatusRequest.loading;

    if (profileFile != null) {
      final res = await _storageRepository.storeFile(
          path: "user/profile", id: userModel.name, file: profileFile);

      res.fold((l) => showSnackBar(l.toString(), context),
          (r) => userModel = userModel.copyWith(profilePic: r));
    }

    final res = await _authRepository.editUser(userModel);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.message, context), (r) async {
      await _authRepository.saveUserModelToPrefs(userModel);
      await ref.read(usersProvider.notifier).update((state) => userModel);
      Get.back();
    });
  }

  getAppState() async {
    final res = await _authRepository.getAppStatus();
    res.fold((l) {}, (r) {
      inUpdate = r;
    });
  }

  setUserData(
      String name,
      String uid,
      String phone,
      String age,
      String city,
      String region,
      String country,
      String gender,
      BuildContext context) async {
    state = StatusRequest.loading;
    UserModel userModel = UserModel(
        kamnGoldDiscount: 0,
        region: region,
        backGroundProfilePic: Constants.bannerDefault,
        isactive: false,
        followers: [],
        name: '$name',
        profilePic: Constants.avatarDefault,
        uid: uid,
        isAuthanticated: true,
        points: 0,
        phone: phone,
        age: "$age",
        awards: [],
        city: "$city",
        country: "$country",
        myGrounds: [],
        state: "0",
        gender: "$gender",
        isonline: false,
        ingroup: []);
    MyServices myServices = Get.find();

    final res = await _authRepository.setUserData(userModel, uid);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) async {
      myServices.sharedPreferences.setString("step", "2");
      await _authRepository.saveUserModelToPrefs(userModel);
      Get.offAll(HomeMain());
    });
  }

  // void createAccountWithEmailAndPassword(
  //   String uid,
  //     String email,
  //     String password,
  //     BuildContext context,
  //     String name,
  //     String phone,
  //     String age,
  //     String city,
  //     String country,
  //     String gender) async {
  //   state = StatusRequest.loading;

  //   // final res = await _authRepository.createAccountWithEmailAndPassword(
  //   //     email, password);
  //  final res =  await setUserData(name, uid, phone, age, city, country,
  //         gender, context);
  //     state = StatusRequest.success;

  // }

  getAnyUserData(String email, BuildContext context) async {
    final res = await _authRepository.getAnyUserData(email);
    res.fold((l) => showSnackBar(l.message, context), (r) {
      userModel = r;
    });
  }

  UserModel? loadUserModelFromPrefs() {
    MyServices myServices =
        Get.find(); // Retrieve the UserModel from shared preferences
    String? userModelJson = myServices.sharedPreferences.getString('userModel');
    if (userModelJson != null) {
      // If UserModel exists in shared preferences, parse and return it
      return UserModel.fromJson(json.decode(userModelJson));
    } else {
      // If UserModel doesn't exist, return null or a default value
      return null;
    }
  }

  void signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    state = StatusRequest.loading;
    final res =
        await _authRepository.signInWithEmailAndPassword(email, password);
    state = StatusRequest.success;
    MyServices myServices = Get.find();

    res.fold((l) => showSnackBar(l.message, context), (r) async {
      final res = await _authRepository.getAnyUserData(email);
      res.fold((l) => showSnackBar(l.message, context), (userModel) async {
        myServices.sharedPreferences.setString("step", "2");
        await _ref.read(usersProvider.notifier).update((state) => userModel);
        await _authRepository.saveUserModelToPrefs(userModel);
        Get.offAll(HomeMain());
      });
    });
  }

  void verifyPhone(BuildContext context, String phone) async {
    final res = await _authRepository.verifyPhone(phone);
    state = StatusRequest.success;
    res.fold(
        (l) => showSnackBar("There is a problem with phone number", context),
        (r) {});
  }

  void sendCode(String code, BuildContext context, String phone) async {
    state = StatusRequest.loading;
    UserModel usermodel;
    final res = await _authRepository.sendCode(code);
    state = StatusRequest.success;
    MyServices myServices = Get.find();
    res.fold((l) => showSnackBar(l.message, context), (r) async {
      if (r.additionalUserInfo!.isNewUser) {
        Get.off(() => FinishScreen(
              uid: r.user!.uid,
              phone: phone,
            ));
      } else {
        myServices.sharedPreferences.setString("step", "2");
        final res = await _authRepository.getAnyUserData(
          r.user!.uid,
        );
        res.fold((l) => showSnackBar(l.message, context), (r) async {
          print(r.state);
          await _authRepository.saveUserModelToPrefs(r);
          Get.offAll(() => HomeMain());
        });
      }
    });
  }

  Future<void> logOut() async {
    MyServices myServices = Get.find();
    _authRepository.logOut();
    if (myServices.sharedPreferences.getString("check") == "1") {
      await myServices.sharedPreferences.clear();
      await myServices.sharedPreferences.setString("step", "1");
      await myServices.sharedPreferences.setString("check", "1");
    } else {
      myServices.sharedPreferences.clear();
      myServices.sharedPreferences.setString("step", "1");
    }

    Get.offAll(() => LoginScreen());
  }

  void updateUserStatus(bool isonline, BuildContext context) async {
    final uid = _ref.read(usersProvider)!.uid;
    final res = await _authRepository.updateUserState(uid, isonline);
    res.fold((l) => showSnackBar(l.message, context), (r) async {});
  }

  void updateUserServiceStatus(
      String state, String userId, BuildContext context) async {
    final user = _ref.read(usersProvider);
    final res = await _authRepository.updateUserServiceState(userId, state);
    res.fold((l) => showSnackBar(l.message, context), (r) async {
      await _ref
          .read(usersProvider.notifier)
          .update((u) => user!.copyWith(state: state));
      await _authRepository.saveUserModelToPrefs(user!.copyWith(state: state));
    });
  }
}
