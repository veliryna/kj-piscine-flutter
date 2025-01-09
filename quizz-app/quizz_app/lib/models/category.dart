import 'package:quizz_app/models/question.dart';

class CategoryItem {
  String title;
  String imageUrl;
  List<Question> questions;

  CategoryItem(this.title, this.imageUrl, this.questions);
}
