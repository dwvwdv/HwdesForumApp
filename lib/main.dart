import 'package:flutter/material.dart';

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
				// This is the theme of your application.
				//
				// TRY THIS: Try running your application with "flutter run". You'll see
				// the application has a blue toolbar. Then, without quitting the app,
				// try changing the seedColor in the colorScheme below to Colors.green
				// and then invoke "hot reload" (save your changes or press the "hot
				// reload" button in a Flutter-supported IDE, or press "r" if you used
				// the command line to start the app).
				//
				// Notice that the counter didn't reset back to zero; the application
				// state is not lost during the reload. To reset the state, use hot
				// restart instead.
				//
				// This works for code too, not just values: Most code changes can be
				// tested with just a hot reload.
				colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
				useMaterial3: true,
			),
			home: const HomePage(title: 'hwdes forum'),
		);
	}
}

class HomePage extends StatefulWidget {
	const HomePage({super.key, required this.title});

	// This widget is the home page of your application. It is stateful, meaning
	// that it has a State object (defined below) that contains fields that affect
	// how it looks.

	// This class is the configuration for the state. It holds the values (in this
	// case the title) provided by the parent (in this case the App widget) and
	// used by the build method of the State. Fields in a Widget subclass are
	// always marked "final".

	final String title;

	@override
	State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

	List<Widget> getList(){
		List<Widget> list = [];
		for(int i=0;i<5;i++){
		list.add(Text('hello$i',style: Theme.of(context).textTheme.headlineMedium));
		list.add(Text('dwv$i',style: Theme.of(context).textTheme.headlineSmall));
		}
		articlesAPI();
		return list;
	}


	@override
	Widget build(BuildContext context) {
		// This method is rerun every time setState is called, for instance as done
		// by the _incrementCounter method above.
		//
		// The Flutter framework has been optimized to make rerunning build methods
		// fast, so that you can just rebuild anything that needs updating rather
		// than having to individually change instances of widgets.
		return Scaffold(
			appBar: AppBar(
				// TRY THIS: Try changing the color here to a specific color (to
				// Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
				// change color while the other colors stay the same.
				backgroundColor: Theme.of(context).colorScheme.inversePrimary,
				// Here we take the value from the MyHomePage object that was created by
				// the App.build method, and use it to set our appbar title.
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
														Navigator.pushNamed(context, '/Article');
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
			// floatingActionButton: FloatingActionButton(
			// 	onPressed: _incrementCounter,
			// 	tooltip: 'Increment',
			// 	child: const Icon(Icons.local_atm_sharp),
			// ), // This trailing comma makes auto-formatting nicer for build methods.
		);
	}
}

class ArticlePage extends StatelessWidget{
	const ArticlePage({super.key});
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text("Article"),
			),
			body: Center(
				child: ElevatedButton(
					child: const Text("Back to home"),
					onPressed: () {
						Navigator.pop(context);
					},
				),
			),
		);
	}
}
