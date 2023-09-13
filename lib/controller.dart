import 'package:flutter/material.dart';

import './model.dart';

import 'package:requests/requests.dart';
import 'dart:developer';
import 'dart:convert';

Future<List<Article>> articlesAPI() async {
	var r = await Requests.get('https://hwdes.tw/api/board/pop?page=1');
	r.raiseForStatus();
	String body = r.content();
	Map<String,dynamic> jsonMap = json.decode(body);

	List<Article> articles = [];

	for (var data in jsonMap['data']) {
	Article article = Article.fromJson(data);
	articles.add(article);
	log('dwvlog : ${article.title}');
	}
	return articles;
}

