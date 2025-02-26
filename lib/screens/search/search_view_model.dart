import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchViewModelProvider = ChangeNotifierProvider((ref) => SearchViewModel());

class SearchViewModel with ChangeNotifier {
  late BuildContext context;

  final textController = TextEditingController();

  Map<String, dynamic> params = {};

  List data = [];
}
