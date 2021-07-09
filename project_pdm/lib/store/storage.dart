import 'dart:async';

import 'package:flutter/material.dart';

import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

import 'package:project_pdm/main.dart';

void storage(List<Post> postsList) async {
  Future<Database> getDatabase() async{
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "assets/database.db");
    WidgetsFlutterBinding.ensureInitialized();
    final database = await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('CREATE TABLE posts(id INTEGER PRIMARY KEY, title TEXT, text TEXT, comments TEXT)');
        db.execute('CREATE TABLE comments(id INTEGER PRIMARY KEY, body_text TEXT)');
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertPost(Post postage) async {
    Future<Database> database = getDatabase();

    final db = await database;
    await db.insert(
      'posts',
      postage.postToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Post>> postList() async {
    Future<Database> database = getDatabase();

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('posts');

    return List.generate(maps.length, (i){
      return Post(
        postId: maps[i]['id'],
        title: maps[i]['title'],
        text: maps[i]['text'],
        comments: maps[i]['comments'],
      );
    }); 
  }

  Future<void> deletePost(int id) async {
    Future<Database> database = getDatabase();
    
    final db = await database;
    await db.delete(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertComment(Comments comentary) async {
    Future<Database> database = getDatabase();
    
    final db = await database;
    await db.insert(
      'comments',
      comentary.commentToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Comments>> commentsList() async {
    Future<Database> database = getDatabase();
    
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('comments');

    return List.generate(maps.length, (i){
      return Comments(
        commentId: maps[i]['id'],
        bodyText: maps[i]['body_text'],
      );
    }); 
  }

  Future<void> deleteComment(int id) async {
    Future<Database> database = getDatabase();
    
    final db = await database;
    await db.delete(
      'comments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  for (var i in postsList) {
    i = Post(postId: i.postId,title: i.title, text: i.text, comments: i.comments);
    await insertPost(i);
  }

  Future<Database> database = getDatabase();
  final db = await database;
  await db.close();
}