import 'package:bloc_practice/null/NoteApp/model/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<NoteModel> getData() => Hive.box<NoteModel>('note');
}
