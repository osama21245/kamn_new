import 'package:dartz/dartz.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/storage_repository.dart';
import '../repositories/serviceprovider_repository.dart';

final getServiceProviderStoreProvider = FutureProvider.autoDispose.family(
    (ref, Tuple2 tuple2) => ref
        .watch(serviceProviderControllerProvider.notifier)
        .getServiceProviderStore(tuple2));

final serviceProviderControllerProvider =
    StateNotifierProvider<ServiceProviderController, StatusRequest>((ref) =>
        ServiceProviderController(
            storageRepository: ref.watch(storageRepositoryProvider),
            serviceProviderRepository:
                ref.watch(serviceProviderRepositoryProvider),
            ref: ref));

class ServiceProviderController extends StateNotifier<StatusRequest> {
  final Ref _ref;
  final ServiceProviderRepository _serviceProviderRepository;
  final StorageRepository _storageRepository;

  ServiceProviderController(
      {required ServiceProviderRepository serviceProviderRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _serviceProviderRepository = serviceProviderRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(StatusRequest.success);

  Future<List<dynamic>> getServiceProviderStore(Tuple2 tuple2) {
    return _serviceProviderRepository.getserviceProviderStore(
      serviceProviderId: tuple2.value1,
      serviceProviderState: tuple2.value2,
    );
  }
}
