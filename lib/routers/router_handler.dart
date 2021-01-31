import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../Pages/details_page.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DetailsPage(params['id'].first);
});
