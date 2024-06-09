import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/providers/firebase_providers.dart';
import 'package:kman/models/coache_model.dart';
import '../../../models/gym_model.dart';
import '../../../models/medical_model.dart';
import '../../../models/nutrition_model.dart';
import '../../../models/sports_model.dart';

final serviceProviderRepositoryProvider = Provider((ref) =>
    ServiceProviderRepository(firestore: ref.watch(FirestoreProvider)));

class ServiceProviderRepository {
  final FirebaseFirestore _firestore;

  ServiceProviderRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _coaches => _firestore.collection("coaches");
  CollectionReference get _gyms => _firestore.collection("gyms");
  CollectionReference get _medical => _firestore.collection("medical");
  CollectionReference get _nutrition => _firestore.collection("nutrition");
  CollectionReference get _sports => _firestore.collection("sports");
  CollectionReference get gymLocations => _firestore.collection("gymLocations");
  CollectionReference get gymDetails => _firestore.collection("gymDetails");

  //  return _gyms.doc(serviceProviderId).collection("gymLocations").get().then((value) {
  //     List<GymLocationsModel> gyms = [];
  //     for (var document in value.docs) {
  //       gyms.add(
  //           GymLocationsModel.fromMap(document.data() as Map<String, dynamic>));
  //     }
  //     return gyms;
  //   });
  Future<List<dynamic>> getserviceProviderStore({
    required String serviceProviderId,
    required String serviceProviderState,
  }) {
    if (serviceProviderState == "4") {
      return _coaches
          .where("userId", isEqualTo: serviceProviderId)
          .get()
          .then((value) {
        List<CoacheModel> coaches = [];
        for (var document in value.docs) {
          coaches.add(
              CoacheModel.fromMap(document.data() as Map<String, dynamic>));
        }
        return coaches;
      });
    } else if (serviceProviderState == "5") {
      return _gyms
          .where("userId", isEqualTo: serviceProviderId)
          .get()
          .then((value) {
        List<GymModel> gyms = [];
        for (var document in value.docs) {
          gyms.add(GymModel.fromMap(document.data() as Map<String, dynamic>));
        }
        return gyms;
      });
    } else if (serviceProviderState == "6") {
      return _medical
          .where("userId", isEqualTo: serviceProviderId)
          .get()
          .then((value) {
        List<MedicalModel> medicals = [];
        for (var document in value.docs) {
          medicals.add(
              MedicalModel.fromMap(document.data() as Map<String, dynamic>));
        }
        return medicals;
      });
    } else if (serviceProviderState == "7") {
      return _nutrition
          .where("userId", isEqualTo: serviceProviderId)
          .get()
          .then((value) {
        List<NutritionModel> nutritions = [];
        for (var document in value.docs) {
          nutritions.add(
              NutritionModel.fromMap(document.data() as Map<String, dynamic>));
        }
        return nutritions;
      });
    } else {
      return _sports
          .where("servicePrividerId", isEqualTo: serviceProviderId)
          .get()
          .then((value) {
        List<SportsModel> sports = [];
        for (var document in value.docs) {
          sports.add(
              SportsModel.fromMap(document.data() as Map<String, dynamic>));
        }
        return sports;
      });
    }
  }

  Future<CoacheModel> getOrdersCoachData(String serviceProviderId) {
    return _coaches.doc(serviceProviderId).get().then((value) {
      return CoacheModel.fromMap(value.data() as Map<String, dynamic>);
    });
  }
}
