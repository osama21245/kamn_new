import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/constants/services/collection_constants.dart';
import 'package:kman/core/faliure.dart';
import 'package:kman/core/providers/firebase_providers.dart';
import 'package:kman/core/type_def.dart';
import 'package:kman/models/coache_model.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:kman/models/gym_locations_model.dart';
import 'package:kman/theme/pallete.dart';
import '../../../models/gym_model.dart';
import '../../../models/prices_model.dart';

final CoachesGymsRepositoryProvider = Provider(
    (ref) => CoachesGymsRepository(firestore: ref.watch(FirestoreProvider)));

class CoachesGymsRepository {
  final FirebaseFirestore _firestore;

  CoachesGymsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _coaches => _firestore.collection("coaches");
  CollectionReference get _coachRequest =>
      _firestore.collection("coachRequest");
  CollectionReference get _gyms => _firestore.collection("gyms");
  CollectionReference get _gymRequest => _firestore.collection("gymRequest");
  CollectionReference get gymLocations => _firestore.collection("gymLocations");
  CollectionReference get gymDetails => _firestore.collection("gymDetails");

  Future<List<CoacheModel>> getCoaches() {
    return _coaches.get().then((value) {
      List<CoacheModel> coaches = [];
      for (var document in value.docs) {
        coaches
            .add(CoacheModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return coaches;
    });
  }

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

  Either updatePrices(
      String collection,
      String gymId,
      String gymLocationsId,
      List<dynamic> prices,
      List<dynamic> pricePlan,
      List<dynamic> points,
      List<dynamic> descriptionPlan,
      List<dynamic> discount,
      List<dynamic> ismix,
      List<dynamic> planTime) {
    try {
      return collection == "offers"
          ? right(_gyms
              .doc(gymId)
              .collection("gymLocations")
              .doc(gymLocationsId)
              .update({
              "offerspoints": points,
              "offersprices": prices,
              "offersPlanName": pricePlan,
              "offersplanDescriptions": descriptionPlan,
              "offersdiscount": discount,
              "offersisMix": ismix,
              "offersplanTime": planTime
            }))
          : collection == "fitness"
              ? right(_gyms
                  .doc(gymId)
                  .collection("gymLocations")
                  .doc(gymLocationsId)
                  .update({
                  "fitnesspoints": points,
                  "fitnessprices": prices,
                  "fitnessplanName": pricePlan,
                  "fitnessplanDescriptions": descriptionPlan,
                  "fitnessdiscount": discount,
                  "fitnessisMix": ismix,
                  "fitnessplanTime": planTime
                }))
              : collection == "weightLift"
                  ? right(_gyms
                      .doc(gymId)
                      .collection("gymLocations")
                      .doc(gymLocationsId)
                      .update({
                      "weightLiftpoints": points,
                      "weightLiftprices": prices,
                      "weightLiftplanName": pricePlan,
                      "weightLiftplanDescriptions": descriptionPlan,
                      "weightLiftdiscount": discount,
                      "weightLiftisMix": ismix,
                      "weightLiftplanTime": planTime
                    }))
                  : right(_gyms
                      .doc(gymId)
                      .collection("gymLocations")
                      .doc(gymLocationsId)
                      .update({
                      "servicespoints": points,
                      "servicesprices": prices,
                      "servicesplanName": pricePlan,
                      "servicesplanDescriptions": descriptionPlan,
                      "servicesdiscount": discount,
                      "servicesdisMix": ismix,
                      "servicesplanTime": planTime
                    }));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Either updatePricesCoaches(
      String collection,
      String gymId,
      List<dynamic> prices,
      List<dynamic> pricePlan,
      List<dynamic> points,
      List<dynamic> descriptionPlan,
      List<dynamic> discount,
      List<dynamic> isGroup,
      List<dynamic> reservisionTimes) {
    try {
      return collection == "online"
          ? right(_coaches.doc(gymId).update({
              "onlinepoints": points,
              "onlineprices": prices,
              "onlinePlanName": pricePlan,
              "onlineplanDescriptions": descriptionPlan,
              "onlinediscount": discount,
              "onlineisGroup": isGroup,
              "onlineReservisionTimes": reservisionTimes
            }))
          : right(_coaches.doc(gymId).update({
              "offlinepoints": points,
              "offlineprices": prices,
              "offlinePlanName": pricePlan,
              "offlineplanDescriptions": descriptionPlan,
              "offlinediscount": discount,
              "offlineisGroup": isGroup,
              "offlineReservisionTimes": reservisionTimes
            }));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid activeCoach(String userId, String coachid) async {
    try {
      return right(_coaches.doc(coachid).update({"userId": userId}));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid activeGym(String userId, String gymid) async {
    try {
      return right(_gyms.doc(gymid).update({"userId": userId}));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //****************update******************* */

  FutureVoid updateGymLocation(GymLocationsModel gymLocationModel) async {
    try {
      return right(_gyms
          .doc(gymLocationModel.mainGymId)
          .collection("gymLocations")
          .doc(gymLocationModel.id)
          .update(gymLocationModel.toMap()));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateCoach(CoacheModel coacheModel) async {
    try {
      return right(_coaches.doc(coacheModel.id).update(coacheModel.toMap()));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateGallery(String storeId, String collection,
      List<dynamic> gallery, String gymLocationId) async {
    try {
      if (collection == Collections.coachCollection) {
        return right(_coaches.doc(storeId).update({"gallery": gallery}));
      } else {
        return right(_gyms
            .doc(storeId)
            .collection("gymLocations")
            .doc(gymLocationId)
            .update({"gallery": gallery}));
      }
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid openLink(String link) async {
    final String facebookLink = "$link";

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

  Future<List<GymModel>> getGyms() {
    return _gyms.get().then((value) {
      List<GymModel> gyms = [];
      for (var document in value.docs) {
        gyms.add(GymModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return gyms;
    });
  }

  Future<List<GymLocationsModel>> getGymLocations(String gymId) {
    return _gyms.doc(gymId).collection("gymLocations").get().then((value) {
      List<GymLocationsModel> gyms = [];
      for (var document in value.docs) {
        gyms.add(
            GymLocationsModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return gyms;
    });
  }

  //*************** Search *******************

  Stream<List<CoacheModel>> searchCoaches(String query) {
    return _coaches
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
      List<CoacheModel> coach = [];
      for (var community in event.docs) {
        coach
            .add(CoacheModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return coach;
    });
  }

  Stream<List<GymModel>> searchGyms(String query) {
    return _gyms
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
      List<GymModel> gyms = [];
      for (var community in event.docs) {
        gyms.add(GymModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return gyms;
    });
  }

  //*****************For orders **************************/
  Future<GymModel> getOrdersGymData(String gymId) {
    // return _gyms.doc(gymId).collection("gymLocations").get().then((value) {
    return _gyms.doc(gymId).get().then((value) {
      return GymModel.fromMap(value.data() as Map<String, dynamic>);
    });
  }

  Future<CoacheModel> getOrdersCoachData(String coachId) {
    return _coaches.doc(coachId).get().then((value) {
      return CoacheModel.fromMap(value.data() as Map<String, dynamic>);
    });
  }

  //futures only for groun owner
  FutureVoid setGym(GymModel gymModel, bool fromAsk) async {
    try {
      if (fromAsk) {
        return right(_gymRequest.doc(gymModel.id).set(gymModel.toMap()));
      } else {
        return right(_gyms.doc(gymModel.id).set(gymModel.toMap()));
      }
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setGymLocations(
      GymLocationsModel gymLocationsModel, String gymId) async {
    try {
      return right(_gyms
          .doc(gymId)
          .collection("gymLocations")
          .doc(gymLocationsModel.id)
          .set(gymLocationsModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setCoache(CoacheModel coacheModel, bool fromask) async {
    try {
      if (fromask) {
        return right(
            _coachRequest.doc(coacheModel.id).set(coacheModel.toMap()));
      } else {
        return right(_coaches.doc(coacheModel.id).set(coacheModel.toMap()));
      }
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setPricesCoaches(String coachId, PricesModel priceModel) async {
    try {
      return right(_coaches
          .doc(coachId)
          .collection("prices")
          .doc("coaches")
          .set(priceModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setPricesGyms(String gymId, String locationId, String gymDetailsId,
      PricesModel priceModel) async {
    try {
      return right(_gyms
          .doc(gymId)
          .collection("prices")
          .doc("gyms")
          .set(priceModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  //**********************for admin****************************

  FutureVoid deleteCoachRequest(
    String coachId,
  ) async {
    try {
      return right(_coachRequest.doc(coachId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deletegymRequest(
    String gymId,
  ) async {
    try {
      return right(_gymRequest.doc(gymId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<CoacheModel>> getCoachRequest() {
    return _coachRequest.snapshots().map((value) {
      List<CoacheModel> gyms = [];
      for (var document in value.docs) {
        gyms.add(CoacheModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return gyms;
    });
  }

  Stream<List<GymModel>> getgymRequest() {
    return _gymRequest.snapshots().map((value) {
      List<GymModel> gyms = [];
      for (var document in value.docs) {
        gyms.add(GymModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return gyms;
    });
  }
}
