import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import './controller.dart';
import './model.dart';

void main() {
	runApp(const Hwdes());
}

class Hwdes extends StatelessWidget {
	const Hwdes({super.key});

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			initialRoute: '/Home',
			routes: {
			'/Home': (context) => const HomePage(title: '夯溫電論壇'),
			'/Article': (context) => const ArticlePage(),

			},
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
				useMaterial3: true,
			),
			home: const HomePage(title: '歡迎來到夯溫電論壇'),
		);
	}
}

class HomePage extends StatefulWidget {
	const HomePage({super.key, required this.title});

	final String title;

	@override
	State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Theme.of(context).colorScheme.inversePrimary,
				title: Text(widget.title),
			),
			body: Center(
				child: Stack(
					children: [
						FutureBuilder<List<Article>>(
							future: articlesAPI(), // TODO: list title article
							builder: (context, snapshot) {
								if (snapshot.connectionState == ConnectionState.waiting) {
									return const CircularProgressIndicator();
									} else if (snapshot.hasError) {
										return Text('Error: ${snapshot.error}');
									} else {
										List<Article> articles = snapshot.data ?? [];
										return ListView.builder(
											itemCount: articles.length,
											itemBuilder: (context, index) {
												return ListTile(
													leading: const Icon(Icons.mp),
													title: Text(articles[index].title),
													subtitle: Text('${articles[index].author.school.toString()} - ${articles[index].author.username.toString()}'),
													textColor: Colors.green,
													tileColor: Colors.black,
													hoverColor: Colors.orange,
													splashColor: Colors.teal,
													selected: true,
													shape: const RoundedRectangleBorder(
														side: BorderSide(color: Colors.lime, width: 3),
														// borderRadius: BorderRadius.all(Radius.circular(15))
													),
													onTap: (){
														Navigator.pushNamed(context, '/Article',arguments: articles[index]);
													},
												);
											},
										);
								}
							},
						)
					],
				),
			),
		);
	}
}

class ArticlePage extends StatelessWidget{
	const ArticlePage({super.key});
	@override
	Widget build(BuildContext context) {
		Article article = ModalRoute.of(context)!.settings.arguments as Article;
		return Scaffold(
			appBar: AppBar(
				title: Text(article.title,style: const TextStyle(fontSize: 15),),
			),
			body: Center(
				child: Stack(
					children:[
						// FutureBuilder<String>(
						// 	future: articleContentAPI('34czdt'), // TODO: Article Content
						// 	builder: (context, snapshot) {
						// 		if (snapshot.connectionState == ConnectionState.waiting) {
						// 			return const CircularProgressIndicator();
						// 			} else if (snapshot.hasError) {
						// 				return Text('Error: ${snapshot.error}');
						// 			} else {
						// 				String content = snapshot.data ?? "";
						// 				return ListView.builder(
						// 					itemCount: 1,
						// 					itemBuilder: (context, index) {
						// 						return ListTile(
						// 							leading: const Icon(Icons.mp),
						// 							title: Text(content),
						// 							// subtitle: Text('${comments[index].author.school.toString()} - ${comments[index].author.username.toString()}'),
						// 							textColor: Colors.green,
						// 							tileColor: Colors.black,
						// 							hoverColor: Colors.orange,
						// 							splashColor: Colors.teal,
						// 							selected: true,
						// 							shape: const RoundedRectangleBorder(
						// 								side: BorderSide(color: Colors.lime, width: 3),
						// 								// borderRadius: BorderRadius.all(Radius.circular(15))
						// 							),
						// 							onTap: (){
						// 								Navigator.pushNamed(context, '/Article');
						// 							},
						// 						);
						// 					},
						// 				);
						// 		}
						// 	},
						// ),
						FutureBuilder<List<Comment>>(
							future: articleCommentAPI(article.shortCode), // TODO: Comment
							builder: (context, snapshot) {
								if (snapshot.connectionState == ConnectionState.waiting) {
									return const CircularProgressIndicator();
									} else if (snapshot.hasError) {
										return Text('Error: ${snapshot.error}');
									} else {
										List<Comment> comments = snapshot.data ?? [];
										return ListView.builder(
											itemCount: comments.length,
											itemBuilder: (context, index) {
												return ListTile(
													leading: const Icon(Icons.mp),
													title: Text(comments[index].content),
													// subtitle: Text('${comments[index].author.school.toString()} - ${comments[index].author.username.toString()}'),
													textColor: Colors.green,
													tileColor: Colors.black,
													hoverColor: Colors.orange,
													splashColor: Colors.teal,
													// selected: true,
													shape: const RoundedRectangleBorder(
														side: BorderSide(color: Colors.lime, width: 3),
														// borderRadius: BorderRadius.all(Radius.circular(15))
													),
													onLongPress: (){
														Clipboard.setData(ClipboardData(text: comments[index].content));
														const snackBar = SnackBar(content: Text('yunk it!'));
														ScaffoldMessenger.of(context).showSnackBar(snackBar);
													},
												);
											},
										);
								}
							},
						),
						Positioned(
							bottom: 0,
							right: 0,
							child: ElevatedButton(
								child: const Text("Back"),

								onPressed: () {
									Navigator.pop(context);
								},
							),
						),
					]
				),
			),

		);
	}
}
