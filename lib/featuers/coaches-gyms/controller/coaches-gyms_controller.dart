import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/core/constants/constants.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/homemain.dart';
import 'package:kman/models/coache_model.dart';
import 'package:kman/models/gym_locations_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/storage_repository.dart';
import '../../../core/providers/utils.dart';
import '../../../models/gym_model.dart';
import '../../../models/prices_model.dart';
import '../repositories/coaches-gyms_repository.dart';

final getCoachesProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(coachesGymsControllerProvider.notifier).getCoaches());

final getGymsProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(coachesGymsControllerProvider.notifier).getGyms());

final getGymLocationsProvider = FutureProvider.autoDispose.family((ref,
        String gymId) =>
    ref.watch(coachesGymsControllerProvider.notifier).getGymLocations(gymId));

//***********************for Orders********************** */

final getCoachOrdersDataProvider = FutureProvider.autoDispose.family(
    (ref, String coachId) => ref
        .watch(coachesGymsControllerProvider.notifier)
        .getOrdersCoachData(coachId));

final getGymOrdersDataProvider = FutureProvider.autoDispose.family((ref,
        String gymId) =>
    ref.watch(coachesGymsControllerProvider.notifier).getOrdersGymData(gymId));

//****************************************search******************* */

final getSearchCoachesProvider = StreamProvider.family((ref, String query) =>
    ref.watch(coachesGymsControllerProvider.notifier).searchCoach(query));

final getSearchGymsProvider = StreamProvider.family((ref, String query) =>
    ref.watch(coachesGymsControllerProvider.notifier).searchGym(query));

//**********************for admin*********************** */
final getCoachesRequestsProvider = StreamProvider.autoDispose((ref) =>
    ref.watch(coachesGymsControllerProvider.notifier).getCoachRequest());

final getgymRequestsProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(coachesGymsControllerProvider.notifier).getgymRequest());

final coachesGymsControllerProvider =
    StateNotifierProvider<CoachesGymsController, StatusRequest>((ref) =>
        CoachesGymsController(
            storageRepository: ref.watch(storageRepositoryProvider),
            coachesGymsRepository: ref.watch(CoachesGymsRepositoryProvider),
            ref: ref));

class CoachesGymsController extends StateNotifier<StatusRequest> {
  final Ref _ref;
  final CoachesGymsRepository _coachesGymsRepository;
  final StorageRepository _storageRepository;

  CoachesGymsController(
      {required CoachesGymsRepository coachesGymsRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _coachesGymsRepository = coachesGymsRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(StatusRequest.success);

  double lat = 0.0;
  double long = 0.0;

  Future<List<CoacheModel>> getCoaches() {
    return _coachesGymsRepository.getCoaches();
  }

  Future<List<GymModel>> getGyms() {
    return _coachesGymsRepository.getGyms();
  }

  Future<List<GymLocationsModel>> getGymLocations(String gymId) {
    return _coachesGymsRepository.getGymLocations(gymId);
  }
// ****************************Get prices**************************

  void openWhatsApp(String phone, BuildContext context) async {
    final res = await _coachesGymsRepository.openWhatsApp(phone);
    res.fold((l) => showSnackBar(l.message, context), (r) => null);
  }

  void openLink(String link, BuildContext context) async {
    final res = await _coachesGymsRepository.openLink(link);
    res.fold((l) => showSnackBar(l.message, context), (r) => null);
  }

  void updatePricesCoach(
      String collection,
      String gymId,
      List<dynamic> prices,
      List<dynamic> pricePlan,
      List<dynamic> points,
      List<dynamic> descriptionPlan,
      List<dynamic> discount,
      List<dynamic> isGroup,
      List<dynamic> reservisionTimes,
      BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _coachesGymsRepository.updatePricesCoaches(
        collection,
        gymId,
        prices,
        pricePlan,
        points,
        descriptionPlan,
        discount,
        isGroup,
        reservisionTimes);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar("Faild to update prices", context),
        (r) => showSnackBar("Your Plan has been Added", context));
  }

  void updatePrices(
      String collection,
      String gymId,
      String gymLocationsId,
      List<dynamic> prices,
      List<dynamic> pricePlan,
      List<dynamic> points,
      List<dynamic> descriptionPlan,
      List<dynamic> discount,
      List<dynamic> ismix,
      List<dynamic> planTime,
      BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _coachesGymsRepository.updatePrices(
        collection,
        gymId,
        gymLocationsId,
        prices,
        pricePlan,
        points,
        descriptionPlan,
        discount,
        ismix,
        planTime);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar("Faild to update prices", context),
        (r) => showSnackBar("Your Plan has been Added", context));
  }

  void activeCoach(String coachid, String userId, BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _coachesGymsRepository.activeCoach(userId, coachid);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => HomeMain());
    });
  }

  void activegym(String gymid, String userId, BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _coachesGymsRepository.activeGym(userId, gymid);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => HomeMain());
    });
  }
//*******************************update*********************************** */

  void updateCoach(
      CoacheModel coachmodel, File? logo, BuildContext context) async {
    state = StatusRequest.loading;
    if (logo != null) {
      final res = await _storageRepository.storeFile(
          path: "Coach", id: coachmodel.id, file: logo);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        coachmodel.copyWith(image: r);
      });
    }
    final res = await _coachesGymsRepository.updateCoach(coachmodel);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => const HomeMain());
    });
  }

  void updategymLocation(
      GymLocationsModel gymLocationModel, BuildContext context) async {
    state = StatusRequest.loading;
    final res =
        await _coachesGymsRepository.updateGymLocation(gymLocationModel);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => const HomeMain());
    });
  }

  void updateGallery(
      String storeId,
      String collection,
      List<dynamic> gallery,
      List<File> addGallery,
      int iteration,
      String gymLocationId,
      BuildContext context) async {
    state = StatusRequest.loading;
    int iter = iteration;
    if (addGallery.isNotEmpty) {
      for (var img in addGallery) {
        final res = await _storageRepository.storeFile(
            path: collection, id: "$storeId$iteration", file: img);
        res.fold((l) => showSnackBar(l.toString(), context), (r) {
          gallery.add(r);
          iter++;
        });
      }
    }
    final res = await _coachesGymsRepository.updateGallery(
        storeId, collection, gallery, gymLocationId);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Navigator.of(context).pop();
    });
  }

  //**************************search*******************************************

  Stream<List<CoacheModel>> searchCoach(String query) {
    return _coachesGymsRepository.searchCoaches(query);
  }

  Stream<List<GymModel>> searchGym(String query) {
    return _coachesGymsRepository.searchGyms(query);
  }

  //**************************for orders******************** */

  Future<GymModel> getOrdersGymData(String gymId) {
    return _coachesGymsRepository.getOrdersGymData(gymId);
  }

  Future<CoacheModel> getOrdersCoachData(String gymId) {
    return _coachesGymsRepository.getOrdersCoachData(gymId);
  }

  //**************************futuers only for owner*******************************************

  setPricesCoaches(String coachId, BuildContext context) async {
    PricesModel pricesModel = PricesModel(
        prices: [],
        planDescriptions: [],
        planName: [],
        discount: [],
        points: []);
    final res =
        await _coachesGymsRepository.setPricesCoaches(coachId, pricesModel);
    res.fold((l) => showSnackBar(l.message, context), (r) {
      showSnackBar("Your Coach Added Succefuly", context);
      Get.to(() => const HomeMain());
    });
  }

  void setGyms(BuildContext context, File? filelogo, String name, bool ismix,
      bool fromAsk) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();

    String logo = Constants.store1;

    if (filelogo != null) {
      final res = await _storageRepository.storeFile(
          path: "Gyms", id: id, file: filelogo);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        logo = r;
      });
    }

//set data
    GymModel gymModel =
        GymModel(id: id, name: name, image: logo, ismix: ismix, userId: "");
    final res = await _coachesGymsRepository.setGym(gymModel, fromAsk);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.toString(), context), (r) async {
      Get.offAll(() => const HomeMain());
      showSnackBar("Your reserve Added Succefuly", context);
    });
  }

  void setGymsLocations(
    BuildContext context,
    String name,
    String gymId,
    String address,
    String image,
    String mainGymId,
    String facebooklink,
    String dynamicLink,
    String region,
    bool ismix,
    List<File> fileGallery,
    String instgramLink,
    String whatssAppNumber,
  ) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    List<String> gallery = [];
    int iteration = 0;
    GymLocationsModel gymLocationModel = GymLocationsModel(
      image: image,
      mainGymId: mainGymId,
      id: id,
      city: "Alexandria",
      region: region,
      name: name,
      userId: "",
      gallery: gallery,
      fitnessisMix: [],
      fitnessisSpecial: [],
      fitnessplanTime: [],
      offersSpecial: [],
      offersisMix: [],
      offersplanTime: [],
      servicesdisMix: [],
      servicesisSpecial: [],
      weightLiftisMix: [],
      weightLiftisSpecial: [],
      offerspoints: [],
      offersprices: [],
      offersplanDescriptions: [],
      offersPlanName: [],
      offersdiscount: [],
      fitnesspoints: [],
      fitnessprices: [],
      fitnessplanDescriptions: [],
      fitnessplanName: [],
      fitnessdiscount: [],
      weightLiftpoints: [],
      weightLiftprices: [],
      weightLiftplanDescriptions: [],
      weightLiftplanName: [],
      weightLiftdiscount: [],
      weightLiftplanTime: [],
      servicespoints: [],
      servicesprices: [],
      servicesplanDescriptions: [],
      servicesplanName: [],
      servicesdiscount: [],
      servicesplanTime: [],
      facebook: facebooklink,
      instgram: instgramLink,
      dynamicLink: dynamicLink,
      whatsAppNum: whatssAppNumber,
      rating: 0.0,
      ismix: ismix,
      address: address,
      long: long,
      lat: lat,
    );
    for (var img in fileGallery) {
      final res = await _storageRepository.storeFile(
          path: "gymsGallery", id: "$id$iteration", file: img);
      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        gallery.add(r);
        iteration++;
      });
    }
    final res =
        await _coachesGymsRepository.setGymLocations(gymLocationModel, gymId);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.toString(), context), (r) async {
      showSnackBar("Your reserve Added Succefuly", context);
      Get.offAll(() => const HomeMain());
    });
  }

  void setCoache(
      String name,
      BuildContext context,
      String education,
      String facebooklink,
      String dynamicLink,
      String instgramLink,
      String whatssAppNumber,
      String categoriry,
      String experience,
      File? fileCoacheImage,
      List<File> fileCvs,
      String benefits,
      bool fromask) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    String photo = Constants.defpro;
    int iteration = 0;
    final user = _ref.read(usersProvider);
    List<String> cvs = [];

    if (fileCoacheImage != null) {
      final res = await _storageRepository.storeFile(
          path: "Coach", id: id, file: fileCoacheImage);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        photo = r;
      });
    }

    CoacheModel coacheModel = CoacheModel(
      whatsAppNum: whatssAppNumber,
      instgram: instgramLink,
      faceBook: facebooklink,
      dynamicLink: dynamicLink,
      id: id,
      name: name,
      rating: 0,
      userId: fromask ? user!.uid : "",
      image: photo,
      education: education,
      categoriry: categoriry,
      experience: experience,
      benefits: benefits,
      gallery: cvs,
      onlineSpecial: [],
      onlinepoints: [],
      onlineprices: [],
      onlineplanDescriptions: [],
      onlinePlanName: [],
      onlinediscount: [],
      onlineisGroup: [],
      onlineReservisionTimes: [],
      offlineSpecial: [],
      offlinepoints: [],
      offlineprices: [],
      offlineplanDescriptions: [],
      offlinePlanName: [],
      offlinediscount: [],
      offlineisGroup: [],
      offlineReservisionTimes: [],
    );

    for (var img in fileCvs) {
      String imgId = Uuid().v4();

      final res = await _storageRepository.storeFile(
          path: "products", id: "$id$iteration", file: img);
      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        cvs.add(r);
        iteration++;
      });
    }

    final res = await _coachesGymsRepository.setCoache(coacheModel, fromask);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      Get.offAll(() => HomeMain());
      setPricesCoaches(id, context);
      showSnackBar("Your reserve Added Succefuly", context);
    });
  }

//****************************for Admin*******************************************************
  void setCoacheRequest(
    String name,
    BuildContext context,
    String education,
    String facebooklink,
    String dynamicLink,
    String instgramLink,
    String whatssAppNumber,
    String categoriry,
    String experience,
    String fileCoacheImage,
    List<dynamic> fileCvs,
    String benefits,
  ) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    final user = _ref.read(usersProvider);

    CoacheModel coacheModel = CoacheModel(
      whatsAppNum: whatssAppNumber,
      instgram: instgramLink,
      faceBook: facebooklink,
      dynamicLink: dynamicLink,
      id: id,
      name: name,
      rating: 0,
      userId: user!.uid,
      image: fileCoacheImage,
      education: education,
      categoriry: categoriry,
      experience: experience,
      benefits: benefits,
      gallery: fileCvs,
      onlineSpecial: [],
      onlinepoints: [],
      onlineprices: [],
      onlineplanDescriptions: [],
      onlinePlanName: [],
      onlinediscount: [],
      onlineisGroup: [],
      onlineReservisionTimes: [],
      offlineSpecial: [],
      offlinepoints: [],
      offlineprices: [],
      offlineplanDescriptions: [],
      offlinePlanName: [],
      offlinediscount: [],
      offlineisGroup: [],
      offlineReservisionTimes: [],
    );

    final res = await _coachesGymsRepository.setCoache(coacheModel, false);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      showSnackBar("Your reserve Added Succefuly", context);
    });
  }

  void setGymsRequests(
    BuildContext context,
    String image,
    String name,
    bool ismix,
  ) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();

    GymModel gymModel =
        GymModel(id: id, name: name, image: image, ismix: ismix, userId: "");
    final res = await _coachesGymsRepository.setGym(gymModel, false);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.toString(), context), (r) async {
      showSnackBar("Your reserve Added Succefuly", context);
    });
  }

  void deleteCoachRequest(
    String coachId,
    BuildContext context,
  ) async {
    final res = await _coachesGymsRepository.deleteCoachRequest(coachId);
    res.fold((l) => null, (r) {
      Navigator.of(context).pop();
    });
  }

  void deletegymRequest(
    String gymId,
    BuildContext context,
  ) async {
    final res = await _coachesGymsRepository.deletegymRequest(gymId);
    res.fold((l) => null, (r) {
      Navigator.of(context).pop();
    });
  }

  Stream<List<CoacheModel>> getCoachRequest() {
    return _coachesGymsRepository.getCoachRequest();
  }

  Stream<List<GymModel>> getgymRequest() {
    return _coachesGymsRepository.getgymRequest();
  }
}
