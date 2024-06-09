import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/core/constants/constants.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/homemain.dart';
import 'package:kman/models/medical_model.dart';
import 'package:kman/models/medical_services_model.dart';
import 'package:kman/models/nutrition_model.dart';
import 'package:kman/models/offers_items_model.dart';
import 'package:kman/models/offers_model.dart';
import 'package:kman/models/sports_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/class/medical_times_list.dart';
import '../../../core/providers/storage_repository.dart';
import '../../../core/providers/utils.dart';
import '../../../models/prices_model.dart';
import '../repositories/benefits_repository.dart';

// ****************************Get search**************************

final getSearchMedical = StreamProvider.family((ref, String query) =>
    ref.watch(benefitsControllerProvider.notifier).searchMedical(query));

final getSearchNutiritions = StreamProvider.family((ref, String query) =>
    ref.watch(benefitsControllerProvider.notifier).searchNutiritions(query));

final getSearchSports = StreamProvider.family((ref, String query) =>
    ref.watch(benefitsControllerProvider.notifier).searchSports(query));

// ****************************Get prices**************************
final getMedicalPricesProvider = FutureProvider.family(
    (ref, String benefitsId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getMedicalPrices(benefitsId));

final getNutritionsPricesProvider = FutureProvider.family(
    (ref, String benefitsId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getNutritionPrices(benefitsId));

final getSportsPricesProvider = FutureProvider.family((ref,
        String benefitsId) =>
    ref.watch(benefitsControllerProvider.notifier).getSportsPrices(benefitsId));

//*************************for Orders******************************* */

final getMedicalOrdersDataProvider = FutureProvider.autoDispose.family(
    (ref, String storeId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getOrdersMedicalData(storeId));

//*****************************sports offers *********************** */

final getSportsOffersProvider = FutureProvider.autoDispose.family((ref,
        String storeId) =>
    ref.watch(benefitsControllerProvider.notifier).getSportsOffers(storeId));

final getSportsOffersItemsProvider = FutureProvider.autoDispose.family(
    (ref, String storeId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getSportsOffersItems(storeId));

final getSportsOffersStreamProvider = StreamProvider.autoDispose.family(
    (ref, String storeId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getSportsOffersStream(storeId));

final getSportsOffersItemsStreamProvider = StreamProvider.autoDispose.family(
    (ref, String storeId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getSportsOffersItemsStream(storeId));

//*****************************nutrition offers *********************** */

final getNutritionOffersProvider = FutureProvider.autoDispose.family((ref,
        String storeId) =>
    ref.watch(benefitsControllerProvider.notifier).getNutritionOffers(storeId));

final getNutritionOffersItemsProvider = FutureProvider.autoDispose.family(
    (ref, String storeId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getNutritionOffersItems(storeId));

final getNutritionOffersStreamProvider = StreamProvider.autoDispose.family(
    (ref, String storeId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getNutritionOffersStream(storeId));

final getNutritionOffersItemsStreamProvider = StreamProvider.autoDispose.family(
    (ref, String storeId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getNutritionOffersItemsStream(storeId));

//***************************medical Services********************* */

final getMedicalServicesProvider = FutureProvider.autoDispose.family(
    (ref, String medicalId) => ref
        .watch(benefitsControllerProvider.notifier)
        .getMedicalServices(medicalId));

// ****************************Get services**************************

final getMedicalProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(benefitsControllerProvider.notifier).getMedical());

final getNutritionProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(benefitsControllerProvider.notifier).getNutrition());

final getSportsProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(benefitsControllerProvider.notifier).getSports());

//************************for admin****************************** */

final getMedicalRequestProvider = StreamProvider.autoDispose((ref) =>
    ref.watch(benefitsControllerProvider.notifier).getMedicalRequests());

final getNutritionRequestProvider = StreamProvider.autoDispose((ref) =>
    ref.watch(benefitsControllerProvider.notifier).getNutritionRequests());

final getSportsRequestProvider = StreamProvider.autoDispose((ref) =>
    ref.watch(benefitsControllerProvider.notifier).getSportsRequests());

final benefitsControllerProvider =
    StateNotifierProvider<BenefitsController, StatusRequest>((ref) =>
        BenefitsController(
            storageRepository: ref.watch(storageRepositoryProvider),
            benefitsRepository: ref.watch(BenefitsRepositoryProvider),
            ref: ref));

class BenefitsController extends StateNotifier<StatusRequest> {
  final Ref _ref;
  final BenefitsRepository _benefitsRepository;
  final StorageRepository _storageRepository;

  BenefitsController(
      {required BenefitsRepository benefitsRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _benefitsRepository = benefitsRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(StatusRequest.success);

  double lat = 0.0;
  double long = 0.0;

  Future<List<MedicalModel>> getMedical() {
    return _benefitsRepository.getMedicals();
  }

  Future<List<NutritionModel>> getNutrition() {
    return _benefitsRepository.getNurition();
  }

  Future<List<SportsModel>> getSports() {
    return _benefitsRepository.getSports();
  }

  //********************Get sports offers************************ */

  Future<List<OffersModel>> getSportsOffers(String sportsId) {
    return _benefitsRepository.getSportsOffers(sportsId);
  }

  Future<List<OffersItemsModel>> getSportsOffersItems(String sportsId) {
    return _benefitsRepository.getSportsOffersItems(sportsId);
  }

  //for serviceProvider to see the updates live
  Stream<List<OffersModel>> getSportsOffersStream(String sportsId) {
    return _benefitsRepository.getSportsOffersStream(sportsId);
  }

  Stream<List<OffersItemsModel>> getSportsOffersItemsStream(String sportsId) {
    return _benefitsRepository.getSportsOffersItemsStream(sportsId);
  }

//********************Get nutrition offers************************ */

  Future<List<OffersModel>> getNutritionOffers(String nutritionId) {
    return _benefitsRepository.getNutritionOffers(nutritionId);
  }

  Future<List<OffersItemsModel>> getNutritionOffersItems(String nutritionId) {
    return _benefitsRepository.getNutritionOffersItems(nutritionId);
  }

  //for serviceProvider to see the updates live
  Stream<List<OffersModel>> getNutritionOffersStream(String nutritionId) {
    return _benefitsRepository.getNutritionOffersStream(nutritionId);
  }

  Stream<List<OffersItemsModel>> getNutritionOffersItemsStream(
      String nutritionId) {
    return _benefitsRepository.getNutritionOffersItemsStream(nutritionId);
  }

//***************************Get medical Services********************* */

  Future<List<MedicalServicesModel>> getMedicalServices(String medicalId) {
    return _benefitsRepository.getMedicalServices(medicalId);
  }

// ****************************Get prices**************************
  Future<PricesModel> getMedicalPrices(String benefitsId) {
    return _benefitsRepository.getMedicalPrices(benefitsId);
  }

  Future<PricesModel> getNutritionPrices(String benefitsId) {
    return _benefitsRepository.getNutritionPrices(benefitsId);
  }

  Future<PricesModel> getSportsPrices(String benefitsId) {
    return _benefitsRepository.getSportsPrices(benefitsId);
  }

  void openWhatsApp(String phone, BuildContext context) async {
    final res = await _benefitsRepository.openWhatsApp(phone);
    res.fold((l) => showSnackBar(l.message, context), (r) => null);
  }

  void openFaceBookLink(String link, BuildContext context) async {
    final res = await _benefitsRepository.openFacebookLink(link);
    res.fold((l) => showSnackBar(l.message, context), (r) => null);
  }

  void updatePrices(
      String collection,
      String benefitsId,
      List<dynamic> prices,
      List<dynamic> pricePlan,
      List<dynamic> descriptionPlan,
      List<dynamic> discount,
      List<dynamic> points,
      BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _benefitsRepository.updatePrices(collection, benefitsId,
        prices, pricePlan, points, descriptionPlan, discount);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar("Faild to update prices", context),
        (r) => showSnackBar("Your Plan has been Added", context));
  }

  void updateMedicalTimes(List<dynamic> to, List<dynamic> from,
      String medicalid, BuildContext context) async {
    state = StatusRequest.loading;
    final res =
        await _benefitsRepository.updateMedicalTimes(to, from, medicalid);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar("Faild to update prices", context),
        (r) => showSnackBar("Your Time has been Updated", context));
  }

  void activeMedical(
      String medicalid, String userId, BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _benefitsRepository.activeMedical(userId, medicalid);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => HomeMain());
    });
  }

  void activeNutrition(
      String nutritionid, String userId, BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _benefitsRepository.activeNutrition(userId, nutritionid);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => HomeMain());
    });
  }

  void activeSports(
      String sportsId, String userId, BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _benefitsRepository.activeSports(userId, sportsId);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => HomeMain());
    });
  }

  //*******************update************************ */

  void updateMedical(
      MedicalModel medicalModel, File? logo, BuildContext context) async {
    state = StatusRequest.loading;
    if (logo != null) {
      final res = await _storageRepository.storeFile(
          path: "Medical", id: medicalModel.id, file: logo);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        medicalModel.copyWith(image: r);
      });
    }
    final res = await _benefitsRepository.updateMedical(medicalModel);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => HomeMain());
    });
  }

  void updateNutrition(
      NutritionModel nutritionModel, File? logo, BuildContext context) async {
    state = StatusRequest.loading;
    if (logo != null) {
      final res = await _storageRepository.storeFile(
          path: "Nutrition", id: nutritionModel.id, file: logo);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        nutritionModel.copyWith(image: r);
      });
    }
    final res = await _benefitsRepository.updateNutrition(nutritionModel);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => const HomeMain());
    });
  }

  void updateSports(SportsModel sportsModel, File? logo, bool isPhotoUpdated,
      BuildContext context) async {
    state = StatusRequest.loading;
    if (isPhotoUpdated == true) {
      final res = await _storageRepository.storeFile(
          path: "Sports", id: sportsModel.id, file: logo);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        sportsModel.copyWith(image: r);
      });
    }
    final res = await _benefitsRepository.updateSports(sportsModel);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => const HomeMain());
    });
  }

  void updateGallery(String collection, String storeId, List<dynamic> gallery,
      BuildContext context) async {
    state = StatusRequest.loading;

    final res =
        await _benefitsRepository.updateGallery(collection, storeId, gallery);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) {
      Navigator.of(context).pop();
    });
  }

  //****************for Orders *********************************** */

  Future<MedicalModel> getOrdersMedicalData(String medicalId) {
    return _benefitsRepository.getOrdersMedicalData(medicalId);
  }

  //**************************search*******************************************

  Stream<List<MedicalModel>> searchMedical(String query) {
    return _benefitsRepository.searchMedical(query);
  }

  Stream<List<NutritionModel>> searchNutiritions(String query) {
    return _benefitsRepository.searchNutritions(query);
  }

  Stream<List<SportsModel>> searchSports(String query) {
    return _benefitsRepository.searchSports(query);
  }

  //**************************futuers only for service owner*******************************************

  void deleteSportsOffers(
      String sportsId, String offerId, BuildContext context) async {
    final res = await _benefitsRepository.deleteSportsOffers(sportsId, offerId);
    res.fold((l) => showSnackBar("Faild to delete offer", context),
        (r) => showSnackBar("Your offer has been deleted", context));
  }

  void deleteMedicalServices(
      String medicalId, String servicesId, BuildContext context) async {
    final res =
        await _benefitsRepository.deleteMedicalServices(medicalId, servicesId);
    res.fold((l) => showSnackBar("Faild to delete service", context),
        (r) => showSnackBar("Your service has been deleted", context));
  }

  setSportsOffers(String title, String description, String discount,
      String sportsId, BuildContext context, File filelogo) async {
    final id = Uuid().v1();
    String logo = "";
    state = StatusRequest.loading;

    //get image
    final res = await _storageRepository.storeFile(
        path: "sports/offers", id: id, file: filelogo);

    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      logo = r;
    });
    if (logo != "") {
      OffersModel offersModel = OffersModel(
          id: id,
          title: title,
          description: description,
          discount: discount,
          date: DateTime.now(),
          image: logo);
      final resoffers =
          await _benefitsRepository.setSportsOffers(sportsId, offersModel);
      state = StatusRequest.success;
      resoffers.fold((l) => showSnackBar(l.message, context), (r) {
        showSnackBar("Your offer Added Succefuly", context);
      });
    }
  }

  setSportsOffersItems(String title, String discount, String price,
      String sportsId, BuildContext context, File filelogo) async {
    final id = Uuid().v1();
    String logo = "";
    state = StatusRequest.loading;

    //get image
    final res = await _storageRepository.storeFile(
        path: "sports/offers", id: id, file: filelogo);

    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      logo = r;
    });
    if (logo != "") {
      OffersItemsModel offersModel = OffersItemsModel(
          id: id,
          title: title,
          price: price,
          discount: discount,
          date: DateTime.now(),
          image: logo);
      final resoffers =
          await _benefitsRepository.setSportsOffersItmes(sportsId, offersModel);
      state = StatusRequest.success;
      resoffers.fold((l) => showSnackBar(l.message, context), (r) {
        showSnackBar("Your offer Added Succefuly", context);
      });
    }
  }

  setNutritionOffers(String title, String description, String discount,
      String nutritionId, BuildContext context, File filelogo) async {
    final id = Uuid().v1();
    String logo = "";
    state = StatusRequest.loading;

    //get image
    final res = await _storageRepository.storeFile(
        path: "nutrition/offers", id: id, file: filelogo);

    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      logo = r;
    });
    if (logo != "") {
      OffersModel offersModel = OffersModel(
          id: id,
          title: title,
          description: description,
          discount: discount,
          date: DateTime.now(),
          image: logo);
      final resoffers = await _benefitsRepository.setnutritionOffers(
          nutritionId, offersModel);
      state = StatusRequest.success;
      resoffers.fold((l) => showSnackBar(l.message, context), (r) {
        showSnackBar("Your offer Added Succefuly", context);
      });
    }
  }

  setNutritionOffersItems(String title, String discount, String price,
      String nutritionId, BuildContext context, File filelogo) async {
    final id = Uuid().v1();
    String logo = "";
    state = StatusRequest.loading;

    //get image
    final res = await _storageRepository.storeFile(
        path: "nutrition/offers", id: id, file: filelogo);

    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      logo = r;
    });
    if (logo != "") {
      OffersItemsModel offersModel = OffersItemsModel(
          id: id,
          title: title,
          price: price,
          discount: discount,
          date: DateTime.now(),
          image: logo);
      final resoffers = await _benefitsRepository.setNutritionOffersItmes(
          nutritionId, offersModel);
      state = StatusRequest.success;
      resoffers.fold((l) => showSnackBar(l.message, context), (r) {
        showSnackBar("Your offer Added Succefuly", context);
      });
    }
  }

  void setMedical(
      BuildContext context,
      File? filelogo,
      String name,
      String experience,
      String benefits,
      String specialization,
      String education,
      String discount,
      String facebooklink,
      String region,
      String dynamicLink,
      String instgramLink,
      String whatssAppNumber,
      List<File> fileGallery,
      bool fromAsk) async {
    state = StatusRequest.loading;
    List<String> gallery = [];
    String id = Uuid().v1();
    int iteration = 0;
    final user = _ref.read(usersProvider);
    String logo = Constants.store1;

    //get image
    if (filelogo != null) {
      final res = await _storageRepository.storeFile(
          path: Collections.medicalCollection, id: id, file: filelogo);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        logo = r;
      });
    }

    for (var img in fileGallery) {
      String imgId = Uuid().v4();

      final res = await _storageRepository.storeFile(
          path: Collections.medicalCollection, id: "$id$iteration", file: img);
      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        gallery.add(r);
        iteration++;
      });
    }
//set data
    if (logo != "") {
      MedicalModel gymModel = MedicalModel(
          city: "Alexandria",
          region: region,
          lat: lat,
          long: long,
          from: listmedicalinitialTimesfrom,
          to: listmedicalinitialTimesto,
          gallery: gallery,
          id: id,
          userId: fromAsk ? user!.uid : "",
          image: logo,
          name: name,
          rating: 0,
          education: education,
          specialization: specialization,
          experience: experience,
          benefits: benefits,
          whatAppNum: whatssAppNumber,
          instgram: instgramLink,
          faceBook: facebooklink,
          dynamicLink: dynamicLink,
          discount: discount);

      final res = await _benefitsRepository.setMedical(gymModel, fromAsk);
      res.fold((l) => showSnackBar(l.toString(), context), (r) async {
        Get.offAll(() => const HomeMain());
        state = StatusRequest.success;
      });
    }
  }

  void setNutrition(
      BuildContext context,
      File? fileNutritionImage,
      String name,
      String about,
      String specialization,
      String faceBook,
      String instgram,
      String region,
      String whatsAppNumber,
      String dynamicLink,
      int discount,
      List<File> fileGallery,
      bool fromAsk) async {
    state = StatusRequest.loading;
    final user = _ref.read(usersProvider);
    String id = Uuid().v1();
    List<String> gallery = [];
    String photo = Constants.store1;
    int iteration = 0;
    //get image

    if (fileNutritionImage != null) {
      final res = await _storageRepository.storeFile(
          path: Collections.nutritionCollection,
          id: id,
          file: fileNutritionImage);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        photo = r;
      });
    }

    for (var img in fileGallery) {
      final res = await _storageRepository.storeFile(
          path: Collections.nutritionCollection,
          id: "$id$iteration",
          file: img);
      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        gallery.add(r);
        iteration++;
      });
    }

    if (photo != "") {
      NutritionModel nutritionModel = NutritionModel(
          city: "Alexandria",
          region: region,
          id: id,
          specialization: specialization,
          name: name,
          userId: fromAsk ? user!.uid : "",
          image: photo,
          discount: discount,
          gallery: gallery,
          long: long,
          lat: lat,
          rating: 0,
          about: about,
          faceBook: faceBook,
          instgram: instgram,
          whatsApp: whatsAppNumber,
          dynamicLink: dynamicLink);
      state = StatusRequest.success;

      final res =
          await _benefitsRepository.setNutrition(nutritionModel, fromAsk);
      res.fold((l) => showSnackBar(l.toString(), context), (r) async {
        Get.offAll(() => const HomeMain());
        showSnackBar("Your nutrition Added Succefuly", context);
      });
    }
  }

  void setSports(
      BuildContext context,
      File? fileSportsImage,
      String name,
      String about,
      String faceBook,
      String instgram,
      String whatsAppNumber,
      String dynamicLink,
      int discount,
      List<File> fileGallery,
      String region,
      bool fromAsk) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    int iteration = 0;
    final user = _ref.read(usersProvider);
    String photo = Constants.store1;
    List<String> gallery = [];
    // // get image

    if (fileSportsImage != null) {
      final res = await _storageRepository.storeFile(
          path: Collections.sportsCollection, id: id, file: fileSportsImage);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        photo = r;
      });
    }

    for (var img in fileGallery) {
      final res = await _storageRepository.storeFile(
          path: Collections.sportsCollection, id: "$id$iteration", file: img);
      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        gallery.add(r);
        iteration++;
      });
    }

    if (photo != "") {
      SportsModel sportsModel = SportsModel(
        city: "Alexandria",
        region: region,
        lat: lat,
        long: long,
        id: id,
        name: name,
        image: photo,
        discount: discount,
        rating: 0,
        about: about,
        servicePrividerId: fromAsk ? user!.uid : "",
        gallery: gallery,
        faceBook: faceBook,
        instgram: instgram,
        dynamicLink: dynamicLink,
        whatsApp: whatsAppNumber,
      );
      state = StatusRequest.success;

      final res = await _benefitsRepository.setSports(sportsModel, fromAsk);
      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        Get.offAll(() => const HomeMain());
        showSnackBar("Your sport Added Succefuly", context);
      });
    }
  }

  void setMedicalServices(String medicalId, String title, String description,
      String discount, BuildContext context) async {
    String id = Uuid().v1();

    MedicalServicesModel medicalServicesModel = MedicalServicesModel(
        id: id, title: title, description: description, discount: discount);
    final res = await _benefitsRepository.setMedicalServices(
        medicalId, medicalServicesModel);
    res.fold((l) => showSnackBar("You have a problem with connection", context),
        (r) => showSnackBar("Your service Added Succefuly", context));
  }

  //*****************************for Admin*************************************************************

  void setMedicalRequest(
    BuildContext context,
    String image,
    String name,
    String experience,
    String benefits,
    String specialization,
    String education,
    String discount,
    String facebooklink,
    String region,
    String dynamicLink,
    String instgramLink,
    String whatssAppNumber,
    double lat,
    double long,
    List<dynamic> gallery,
  ) async {
    state = StatusRequest.loading;
    List<String> gallery = [];
    String id = Uuid().v1();
    final user = _ref.read(usersProvider);

    //get image

    MedicalModel gymModel = MedicalModel(
        city: "Alexandria",
        region: region,
        lat: lat,
        long: long,
        from: listmedicalinitialTimesfrom,
        to: listmedicalinitialTimesto,
        gallery: gallery,
        id: id,
        userId: user!.uid,
        image: image,
        name: name,
        rating: 0,
        education: education,
        specialization: specialization,
        experience: experience,
        benefits: benefits,
        whatAppNum: whatssAppNumber,
        instgram: instgramLink,
        faceBook: facebooklink,
        dynamicLink: dynamicLink,
        discount: discount);

    final res = await _benefitsRepository.setMedical(gymModel, false);
    res.fold((l) => showSnackBar(l.toString(), context), (r) async {
      // Get.offAll(() => const HomeMain());
      state = StatusRequest.success;
    });
  }

  void setSportsRequest(
    BuildContext context,
    String image,
    String name,
    String about,
    String faceBook,
    String instgram,
    String whatsAppNumber,
    String dynamicLink,
    double lat,
    double long,
    int discount,
    List<dynamic> gallery,
    String region,
  ) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    final user = _ref.read(usersProvider);

    // // get image

    SportsModel sportsModel = SportsModel(
      city: "Alexandria",
      region: region,
      lat: lat,
      long: long,
      id: id,
      name: name,
      image: image,
      discount: discount,
      rating: 0,
      about: about,
      servicePrividerId: user!.uid,
      gallery: gallery,
      faceBook: faceBook,
      instgram: instgram,
      dynamicLink: dynamicLink,
      whatsApp: whatsAppNumber,
    );

    final res = await _benefitsRepository.setSports(sportsModel, false);
    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      showSnackBar(" sport Added Succefuly", context);
    });
    state = StatusRequest.success;
  }

  void setNutritionRequest(
    BuildContext context,
    String image,
    String name,
    String about,
    String faceBook,
    String instgram,
    String whatsAppNumber,
    String dynamicLink,
    double lat,
    double long,
    int discount,
    List<dynamic> gallery,
    String region,
    String specialization,
  ) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    final user = _ref.read(usersProvider);

    // // get image

    NutritionModel sportsModel = NutritionModel(
      specialization: specialization,
      city: "Alexandria",
      region: region,
      lat: lat,
      long: long,
      id: id,
      name: name,
      image: image,
      discount: discount,
      rating: 0,
      about: about,
      userId: user!.uid,
      gallery: gallery,
      faceBook: faceBook,
      instgram: instgram,
      dynamicLink: dynamicLink,
      whatsApp: whatsAppNumber,
    );
    state = StatusRequest.success;

    final res = await _benefitsRepository.setNutrition(sportsModel, false);
    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      // Get.offAll(() => const HomeMain());
      showSnackBar("Your sport Added Succefuly", context);
    });
  }

  void deleteMedicalRequest(String medicalId, BuildContext context) async {
    final res = await _benefitsRepository.deleteMedicalRequest(medicalId);
    res.fold((l) => null, (r) {
      Navigator.of(context).pop();
    });
  }

  void deleteNutritionRequest(String nutritionId, BuildContext context) async {
    final res = await _benefitsRepository.deleteNutritionRequest(nutritionId);
    res.fold((l) => null, (r) {
      Navigator.of(context).pop();
    });
  }

  void deleteSportsRequest(String sportId, BuildContext context) async {
    final res = await _benefitsRepository.deleteSportsRequest(sportId);
    res.fold((l) => null, (r) {
      Navigator.of(context).pop();
    });
  }

  Stream<List<MedicalModel>> getMedicalRequests() {
    return _benefitsRepository.getMedicalsRequest();
  }

  Stream<List<NutritionModel>> getNutritionRequests() {
    return _benefitsRepository.getNuritionRequest();
  }

  Stream<List<SportsModel>> getSportsRequests() {
    return _benefitsRepository.getSportsRequest();
  }
}
