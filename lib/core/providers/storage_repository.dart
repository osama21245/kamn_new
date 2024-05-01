import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../faliure.dart';
import 'firebase_providers.dart';

final storageRepositoryProvider = Provider(
  (ref) => StorageRepository(
    firebaseStorage: ref.watch(StorageProvider),
  ),
);

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  Future<Either> storeFile({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);

      UploadTask uploadTask = ref.putFile(file!);

      final snapshot = await uploadTask;
      print("here $snapshot");

      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  storeFile2({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);

      UploadTask uploadTask = ref.putFile(file!);

      final snapshot = await uploadTask;

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return Failure(e.toString());
    }
  }

  String extractIdFromUrl(String url) {
    final parts = url.split('/');
    final filenameWithParams = parts.last;
    final filenameWithoutParams = filenameWithParams.split('?').first;
    final decodedFilename = Uri.decodeFull(filenameWithoutParams);
    return decodedFilename;
  }

  Future<Either> deleteFile({
    required String path,
  }) async {
    try {
      final decodedPath = extractIdFromUrl(path);
      final ref = _firebaseStorage.ref().child(decodedPath);

      // Delete the file
      await ref.delete();

      return right("File deleted successfully");
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
