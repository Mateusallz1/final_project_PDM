import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; 

import 'package:http/http.dart' as http;
//import 'package:project_pdm/download/downloadingData.dart';

import 'package:project_pdm/store/storage.dart';

Future<List<Post>> fetchPosts(http.Client client) async {
  final response =
    await client.get(Uri.parse('http://192.168.15.173:8080/post-comments/'));
  
  if (response.statusCode == 200) {
    var data = parsePost(response.body);
    PostsRepository().creatingDatabase();
    PostsRepository().updatingDatabase(data);
    return compute(parsePost, response.body);
  } else {
    throw Exception('Failed to load Posts.');
  }
}

List<Post> parsePost(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'API Consumer';

    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(null, appTitle,),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
    MyHomePage(Key? key, this.title) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(title),),
        body: FutureBuilder<List<Post>>(
          future: fetchPosts(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
              ? PostsList(posts: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PostsList extends StatelessWidget {
  final List<Post> posts;
  PostsList({Key? key, required this.posts}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${posts[index].title}'),
          subtitle: Text('${posts[index].text}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPost(comments: [posts[index]],),
               /*  settings: RouteSettings(
                    arguments: posts[index],
                ), */
              ),
            );
          },
        );
      }
    );
  }
}

class DetailPost extends StatelessWidget {
  final List<dynamic> comments;
  DetailPost({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comentários'),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text('${comments[index].comments}'),
              ),
            ],
          );
        },
      )
    );
  }
}

class Post {
  final int postId;
  final String title;
  final String text;
  final List<dynamic> comments;

  Post({required this.postId, required this.text, required this.title, required this.comments});

  @override
  String toString() {
    return 'Post{id: $postId, title: $title, text: $text, comments: $comments}';
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['post_id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
      comments: json['comments'],
    );
  }
}

class PostDatabase{
  int id;
  String title;
  String text;
  String comments;

  PostDatabase(this.id, this.title, this.text, this.comments);

  Map<String, dynamic> postToMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'comments': comments,
    };
  }

  @override
  String toString() {
    return 'Post{id: $id, title: $title, text: $text, comments: $comments}';
  }
}

class Comments {
  final int commentId;
  final String bodyText;

  Comments({required this.commentId, required this.bodyText,});

  Map<String, dynamic> commentToMap() {
    return {
      'id': commentId,
      'body_text': bodyText,
    };
  }

  @override
  String toString() {
    return 'Comments{id: $commentId, body_text: $bodyText}';
  }

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      commentId: json['comment_id'] as int,
      bodyText: json['body_text'] as String,
    );
  }
}