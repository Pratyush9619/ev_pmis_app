import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseApi extends ChangeNotifier {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future downloadFile(Reference ref) async {
    final dir = (await DownloadsPath.downloadsDirectory())?.path;
    final file = File('$dir/${ref.name}');
    await ref.writeToFile(file);
  }

  defaultKeyEventsField(String collectionName, String deponame) {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(deponame)
        .set({'depoName': deponame});
  }

  nestedKeyEventsField(String collectionName, String deponame1,
      String collectionName1, String userid) {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(deponame1)
        .collection(collectionName1)
        .doc(userid)
        .set({'depoName': deponame1});
  }
}

class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}
