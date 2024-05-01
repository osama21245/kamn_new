import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/constants/services/collection_constants.dart';
import 'package:kman/core/faliure.dart';
import 'package:kman/core/providers/firebase_providers.dart';
import 'package:kman/core/type_def.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:kman/models/medical_model.dart';
import 'package:kman/models/nutrition_model.dart';
import 'package:kman/models/sports_model.dart';
import 'package:kman/theme/pallete.dart';
import '../../../models/medical_services_model.dart';
import '../../../models/offers_items_model.dart';
import '../../../models/offers_model.dart';
import '../../../models/prices_model.dart';
import '../../../models/qr_order_model.dart';

final BenefitsRepositoryProvider = Provider(
    (ref) => BenefitsRepository(firestore: ref.watch(FirestoreProvider)));

class BenefitsRepository {
  final FirebaseFirestore _firestore;

  BenefitsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _medical => _firestore.collection("medical");
  CollectionReference get _nutrition => _firestore.collection("nutrition");
  CollectionReference get _sports => _firestore.collection("sports");
  CollectionReference get _medicalRequest =>
      _firestore.collection("medicalRequest");
  CollectionReference get _nutritionRequest =>
      _firestore.collection("nutritionRequest");
  CollectionReference get _sportsRequest =>
      _firestore.collection("sportsRequest");
  CollectionReference get _qrOrders => _firestore.collection("qrOrders");

  FutureVoid openWhatsApp(String phone) async {
    final whatsappUrl = 'https://wa.me/+20$phone';
    try {
      return right(launchUrl(
        Uri.parse(whatsappUrl),
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: Pallete.primaryColor,
          ),
          shareState: CustomTabsShareState.on,
          urlBarHidingEnabled: true,
          showTitle: true,
          closeButton: CustomTabsCloseButton(
            icon: CustomTabsCloseButtonIcons.back,
          ),
        ),
        safariVCOptions: SafariViewControllerOptions(
          preferredBarTintColor: Pallete.primaryColor,
          preferredControlTintColor: Pallete.whiteColor,
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      ));
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      return left(Failure(e.toString()));
    }
  }

  FutureVoid openFacebookLink(String link) async {
    final String facebookLink = "https://www.facebook.com/$link";

    try {
      return right(launchUrl(
        Uri.parse(facebookLink),
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: Pallete.primaryColor,
          ),
          shareState: CustomTabsShareState.on,
          urlBarHidingEnabled: true,
          showTitle: true,
          closeButton: CustomTabsCloseButton(
            icon: CustomTabsCloseButtonIcons.back,
          ),
        ),
        safariVCOptions: SafariViewControllerOptions(
          preferredBarTintColor: Pallete.primaryColor,
          preferredControlTintColor: Pallete.whiteColor,
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      ));
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      return left(Failure(e.toString()));
    }
  }

  Future<PricesModel> getMedicalPrices(String benefitsId) {
    return _medical
        .doc(benefitsId)
        .collection("prices")
        .doc("medical")
        .get()
        .then((value) {
      PricesModel medicals;
      medicals = PricesModel.fromMap(value.data() as Map<String, dynamic>);

      return medicals;
    });
  }

  Future<PricesModel> getNutritionPrices(String benefitsId) {
    return _nutrition
        .doc(benefitsId)
        .collection("prices")
        .doc("nutrition")
        .get()
        .then((value) {
      PricesModel nutrition;
      nutrition = PricesModel.fromMap(value.data() as Map<String, dynamic>);

      return nutrition;
    });
  }

  Future<PricesModel> getSportsPrices(String benefitsId) {
    return _sports
        .doc(benefitsId)
        .collection("prices")
        .doc("sports")
        .get()
        .then((value) {
      PricesModel sports;
      sports = PricesModel.fromMap(value.data() as Map<String, dynamic>);

      return sports;
    });
  }

  Either updatePrices(
      String collection,
      String benefitsId,
      List<dynamic> prices,
      List<dynamic> pricePlan,
      List<dynamic> points,
      List<dynamic> descriptionPlan,
      List<dynamic> discount) {
    try {
      return collection == "medical"
          ? right(_medical
              .doc(benefitsId)
              .collection("prices")
              .doc("medical")
              .update({
              "points": points,
              "prices": prices,
              "planName": pricePlan,
              "planDescriptions": descriptionPlan,
              "discount": discount
            }))
          : collection == "coach"
              ? right(_firestore
                  .collection("coaches")
                  .doc(benefitsId)
                  .collection("prices")
                  .doc("coaches")
                  .update({
                  "points": points,
                  "prices": prices,
                  "planName": pricePlan,
                  "planDescriptions": descriptionPlan,
                  "discount": discount
                }))
              : collection == "nutrition"
                  ? right(_nutrition
                      .doc(benefitsId)
                      .collection("prices")
                      .doc("nutrition")
                      .update({
                      "points": points,
                      "prices": prices,
                      "planName": pricePlan,
                      "planDescriptions": descriptionPlan,
                      "discount": discount
                    }))
                  : right(_sports
                      .doc(benefitsId)
                      .collection("prices")
                      .doc("sports")
                      .update({
                      "points": points,
                      "prices": prices,
                      "planName": pricePlan,
                      "planDescriptions": descriptionPlan,
                      "discount": discount
                    }));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<List<OffersModel>> getSportsOffers(String sportsId) {
    return _sports.doc(sportsId).collection("offers").get().then((value) {
      List<OffersModel> medicals = [];
      for (var document in value.docs) {
        medicals
            .add(OffersModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }

  Future<List<OffersItemsModel>> getSportsOffersItems(String sportsId) {
    return _sports.doc(sportsId).collection("offersItems").get().then((value) {
      List<OffersItemsModel> offers = [];
      for (var document in value.docs) {
        offers.add(
            OffersItemsModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return offers;
    });
  }

  // that for service provider to see the updates live
  Stream<List<OffersModel>> getSportsOffersStream(String sportsId) {
    return _sports.doc(sportsId).collection("offers").snapshots().map((value) {
      List<OffersModel> offers = [];
      for (var document in value.docs) {
        offers
            .add(OffersModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return offers;
    });
  }

  Stream<List<OffersItemsModel>> getSportsOffersItemsStream(String sportsId) {
    return _sports
        .doc(sportsId)
        .collection("offersItems")
        .snapshots()
        .map((value) {
      List<OffersItemsModel> offers = [];
      for (var document in value.docs) {
        offers.add(
            OffersItemsModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return offers;
    });
  }

  Future<List<OffersModel>> getNutritionOffers(String nutritionId) {
    return _nutrition.doc(nutritionId).collection("offers").get().then((value) {
      List<OffersModel> offers = [];
      for (var document in value.docs) {
        offers
            .add(OffersModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return offers;
    });
  }

  Future<List<OffersItemsModel>> getNutritionOffersItems(String nutritionId) {
    return _nutrition
        .doc(nutritionId)
        .collection("offersItems")
        .get()
        .then((value) {
      List<OffersItemsModel> offers = [];
      for (var document in value.docs) {
        offers.add(
            OffersItemsModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return offers;
    });
  }

  // that for service provider to see the updates live
  Stream<List<OffersModel>> getNutritionOffersStream(String nutritionId) {
    return _nutrition
        .doc(nutritionId)
        .collection("offers")
        .snapshots()
        .map((value) {
      List<OffersModel> nutrition = [];
      for (var document in value.docs) {
        nutrition
            .add(OffersModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return nutrition;
    });
  }

  Stream<List<OffersItemsModel>> getNutritionOffersItemsStream(
      String nutritionId) {
    return _nutrition
        .doc(nutritionId)
        .collection("offersItems")
        .snapshots()
        .map((value) {
      List<OffersItemsModel> nutrition = [];
      for (var document in value.docs) {
        nutrition.add(
            OffersItemsModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return nutrition;
    });
  }

  Future<List<MedicalServicesModel>> getMedicalServices(String medicalId) {
    return _medical
        .doc(medicalId)
        .collection("medical_services")
        .get()
        .then((value) {
      List<MedicalServicesModel> medicalServices = [];
      for (var document in value.docs) {
        medicalServices.add(MedicalServicesModel.fromMap(
            document.data() as Map<String, dynamic>));
      }
      return medicalServices;
    });
  }

  Stream<List<QrOrderModel>> getuserQrOrder(
      String userId, String sportsStoreId) {
    return _qrOrders
        .where("userId", isEqualTo: userId)
        .where("storeId", isEqualTo: sportsStoreId)
        .snapshots()
        .map((event) {
      List<QrOrderModel> medicals = [];
      for (var community in event.docs) {
        medicals.add(
            QrOrderModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }

  FutureVoid deleteSportsOffers(String sportsId, String offerId) async {
    try {
      return right(
          _sports.doc(sportsId).collection("offers").doc(offerId).delete());
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteMedicalServices(String medicalId, String servicesId) async {
    try {
      return right(_medical
          .doc(medicalId)
          .collection("medical_services")
          .doc(servicesId)
          .delete());
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateMedicalTimes(
      List<dynamic> to, List<dynamic> from, String medicalid) async {
    try {
      return right(_medical.doc(medicalid).update({"from": from, "to": to}));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid activeMedical(String userId, String medicalid) async {
    try {
      return right(_medical.doc(medicalid).update({"userId": userId}));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid activeSports(String userId, String sportId) async {
    try {
      return right(_sports.doc(sportId).update({"servicePrividerId": userId}));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid activeNutrition(String userId, String nutritionid) async {
    try {
      return right(_nutrition.doc(nutritionid).update({"userId": userId}));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //***************************update*********************** */

  FutureVoid updateMedical(MedicalModel medicalModel) async {
    try {
      return right(_medical.doc(medicalModel.id).update(medicalModel.toMap()));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateSports(SportsModel sportsModel) async {
    try {
      return right(_sports.doc(sportsModel.id).update(sportsModel.toMap()));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateNutrition(NutritionModel nutritionModel) async {
    try {
      return right(
          _nutrition.doc(nutritionModel.id).update(nutritionModel.toMap()));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateGallery(
      String collection, String storeId, List<dynamic> gallery) async {
    try {
      if (collection == Collections.sportsCollection) {
        return right(_sports.doc(storeId).update({"gallery": gallery}));
      } else if (collection == Collections.medicalCollection) {
        return right(_medical.doc(storeId).update({"gallery": gallery}));
      } else {
        return right(_nutrition.doc(storeId).update({"gallery": gallery}));
      }
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<List<MedicalModel>> getMedicals() {
    return _medical.get().then((value) {
      List<MedicalModel> medicals = [];
      for (var document in value.docs) {
        medicals
            .add(MedicalModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }

  Future<List<NutritionModel>> getNurition() {
    return _nutrition.get().then((value) {
      List<NutritionModel> nutritions = [];
      for (var document in value.docs) {
        nutritions.add(
            NutritionModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return nutritions;
    });
  }

  Future<List<SportsModel>> getSports() {
    return _sports.get().then((value) {
      List<SportsModel> sports = [];
      for (var document in value.docs) {
        sports
            .add(SportsModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return sports;
    });
  }

  //****************for Orders ********************* */

  Future<MedicalModel> getOrdersMedicalData(String medicalId) {
    // return _gyms.doc(gymId).collection("gymLocations").get().then((value) {
    return _medical.doc(medicalId).get().then((value) {
      return MedicalModel.fromMap(value.data() as Map<String, dynamic>);
    });
  }

  //*************** Search *******************

  Stream<List<MedicalModel>> searchMedical(String query) {
    return _medical
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<MedicalModel> medicals = [];
      for (var community in event.docs) {
        medicals.add(
            MedicalModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }

  Stream<List<NutritionModel>> searchNutritions(String query) {
    return _nutrition
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<NutritionModel> nutritions = [];
      for (var community in event.docs) {
        nutritions.add(
            NutritionModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return nutritions;
    });
  }

  Stream<List<SportsModel>> searchSports(String query) {
    return _sports
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<SportsModel> sports = [];
      for (var community in event.docs) {
        sports
            .add(SportsModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return sports;
    });
  }

  //futures only for serviceProvider
  FutureVoid setSportsOffers(String sportsId, OffersModel offersModel) async {
    try {
      return right(_sports
          .doc(sportsId)
          .collection("offers")
          .doc(offersModel.id)
          .set(offersModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setSportsOffersItmes(
      String sportsId, OffersItemsModel offersModel) async {
    try {
      return right(_sports
          .doc(sportsId)
          .collection("offersItems")
          .doc(offersModel.id)
          .set(offersModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setnutritionOffers(
      String nutritionId, OffersModel offersModel) async {
    try {
      return right(_nutrition
          .doc(nutritionId)
          .collection("offers")
          .doc(offersModel.id)
          .set(offersModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setNutritionOffersItmes(
      String nutritionId, OffersItemsModel offersModel) async {
    try {
      return right(_nutrition
          .doc(nutritionId)
          .collection("offersItems")
          .doc(offersModel.id)
          .set(offersModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setMedical(MedicalModel medicalModel, bool fromAsk) async {
    try {
      if (fromAsk) {
        return right(
            _medicalRequest.doc(medicalModel.id).set(medicalModel.toMap()));
      } else {
        return right(_medical.doc(medicalModel.id).set(medicalModel.toMap()));
      }
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setNutrition(NutritionModel nutritionModel, bool fromAsk) async {
    try {
      if (fromAsk) {
        return right(_nutritionRequest
            .doc(nutritionModel.id)
            .set(nutritionModel.toMap()));
      }
      {
        return right(
            _nutrition.doc(nutritionModel.id).set(nutritionModel.toMap()));
      }
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setSports(SportsModel sportsModel, bool fromAsk) async {
    try {
      if (fromAsk) {
        return right(
            _sportsRequest.doc(sportsModel.id).set(sportsModel.toMap()));
      } else {
        return right(_sports.doc(sportsModel.id).set(sportsModel.toMap()));
      }
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setMedicalServices(
      String medicalId, MedicalServicesModel medicalServicesModel) async {
    try {
      return right(_medical
          .doc(medicalId)
          .collection("medical_services")
          .doc(medicalServicesModel.id)
          .set(medicalServicesModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setPricesMedical(String medicalId, PricesModel priceModel) async {
    try {
      return right(_medical
          .doc(medicalId)
          .collection("prices")
          .doc("medical")
          .set(priceModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setPricesNutrition(
      String medicalId, PricesModel priceModel) async {
    try {
      return right(_nutrition
          .doc(medicalId)
          .collection("prices")
          .doc("nutrition")
          .set(priceModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //**************************************for admin********************************* */

  FutureVoid deleteMedicalRequest(
    String medicalId,
  ) async {
    try {
      return right(_medicalRequest.doc(medicalId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteNutritionRequest(String nutritionId) async {
    try {
      return right(_nutritionRequest.doc(nutritionId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteSportsRequest(String sportId) async {
    try {
      return right(_sportsRequest.doc(sportId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<MedicalModel>> getMedicalsRequest() {
    return _medicalRequest.snapshots().map((value) {
      List<MedicalModel> medicals = [];
      for (var document in value.docs) {
        medicals
            .add(MedicalModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }

  Stream<List<NutritionModel>> getNuritionRequest() {
    return _nutritionRequest.snapshots().map((value) {
      List<NutritionModel> nutritions = [];
      for (var document in value.docs) {
        nutritions.add(
            NutritionModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return nutritions;
    });
  }

  Stream<List<SportsModel>> getSportsRequest() {
    return _sportsRequest.snapshots().map((value) {
      List<SportsModel> sports = [];
      for (var document in value.docs) {
        sports
            .add(SportsModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return sports;
    });
  }
}
