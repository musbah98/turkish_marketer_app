import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/post_model.dart';

final indexProductsViewModelProvider = ChangeNotifierProvider((ref) => IndexProductsViewModel());

class IndexProductsViewModel with ChangeNotifier {
  late BuildContext context;

  var textController = TextEditingController();
  Timer? timer;

  //int selectedIndex = 0;

  bool isLoading = false;
  List<PostModel> searchList = [];
  List<PostModel> items = [
    PostModel(
      title: "Trade",
      desc: "11440",
    ),
    PostModel(
      title: "Teducts Textile Products Textile Products",
      desc: "11920",
    ),
    PostModel(
      title: "Textiles",
      desc: "2977",
    ),
    PostModel(
      title: "Textile Products",
      desc: "11440",
    ),
    PostModel(
      title: "Food",
      desc: "2337",
    ),
    PostModel(
      title: "Garment",
      desc: "11440",
    ),
    PostModel(
      title: "Marble",
      desc: "1231",
    ),
    PostModel(
      title: "Building Materials",
      desc: "4331",
    ),
    PostModel(
      title: "Building",
      desc: "1780",
    ),
    PostModel(
      title: "Textile Products",
      desc: "11440",
    ),
    PostModel(
      title: "Building Materials",
      desc: "11440",
    ),
    PostModel(
      title: "Building Materials",
      desc: "11440",
    ),
  ];

  getData() {
    isLoading = true;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      searchList = [
        PostModel(
          title: "Trade",
          desc: "11440",
        ),
        PostModel(
          title: "Products Textile Products",
          desc: "11920",
        ),
        PostModel(
          title: "Textiles",
          desc: "2977",
        ),
        PostModel(
          title: "Food",
          desc: "2337",
        ),
        PostModel(
          title: "Building",
          desc: "1780",
        ),
        PostModel(
          title: "Garment",
          desc: "11440",
        ),
        PostModel(
          title: "Marble",
          desc: "1231",
        ),
        PostModel(
          title: "Building Materials",
          desc: "4331",
        ),
        PostModel(
          title: "Textile Products",
          desc: "11440",
        ),
        PostModel(
          title: "Textile Products",
          desc: "11440",
        ),
        PostModel(
          title: "Building Materials",
          desc: "11440",
        ),
        PostModel(
          title: "Building Materials",
          desc: "11440",
        ),
      ];

      isLoading = false;
      notifyListeners();
    });
  }

  void onChangeText() {
    if (textController.text.isEmpty) {
      //items.clear();
      // page = 0;
      // hasMore = true;
      //isLoading = false;
      //notifyListeners();
      getData();
    } else {
      if (timer != null) {
        timer?.cancel();
        timer = null;
      }

      timer = Timer(const Duration(milliseconds: 800), searchItems);
    }
  }

  searchItems() {
    print(textController.text);
    var selected =
        items.where((e) => e.title?.toLowerCase().contains(textController.text.toLowerCase()) ?? false).toList();
    print("${selected.map((e) => "${e.title}\n")}");
    searchList = selected;
    notifyListeners();
  }

  Future refresh() async {
    getData();
  }
}
