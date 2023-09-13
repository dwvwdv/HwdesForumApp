class Article {
	late String shortCode;
	late Board board;
	late Author author;
	late String title;
	late String content;
	late String createdAt;

	late int likes;
	late int comments;
	late String? image;
	late bool anonymous;
	late bool top;
	late bool globalTop;
	late bool digest;

	Article({
		required this.shortCode,
		required this.board,
		required this.author,
		required this.title,
		required this.content,
		required this.createdAt,
		required this.likes,
		required this.comments,
		this.image,
		required this.anonymous,
		required this.top,
		required this.globalTop,
		required this.digest,
	});

	factory Article.fromJson(Map<String, dynamic> json) {
		return Article(
			shortCode: json['short_code'],
			board: Board.fromJson(json['board']),
			author: Author.fromJson(json['author']),
			title: json['title'],
			content: json['content'],
			createdAt: json['created_at'],
			likes: json['likes'],
			comments: json['comments'],
			image: json['image'],
			anonymous: json['anonymous'],
			top: json['top'],
			globalTop: json['global_top'],
			digest: json['digest'],
		);
	}
}

class Board {
	late String shortCode;
	late String name;

	Board({
		required this.shortCode,
		required this.name,
	});

	factory Board.fromJson(Map<String, dynamic> json) {
		return Board(
			shortCode: json['short_code'],
			name: json['name'],
		);
	}
}

class Author {
	late String? username;
	late String? name;
	late String? school;
	late String? avatar;

	Author({
		this.username,
		this.name,
		this.school,
		this.avatar,
	});

	factory Author.fromJson(Map<String, dynamic> json){
		return Author(
			username: json['username'],
			name: json['name'],
			school: json['school'],
			avatar: json['avatar'],
		);
	}
}
