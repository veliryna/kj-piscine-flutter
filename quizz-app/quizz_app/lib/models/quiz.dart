import 'package:quizz_app/models/category.dart';
import 'package:quizz_app/models/question.dart';

class Quiz{
  List<CategoryItem> quiz = [math, music, skating, coding, nature];
}

CategoryItem math = CategoryItem("MATH", "images/math.jpg", mathQ);

List<Question> mathQ = [
  Question("Is the square root of 100 equal to 10?", true),
  Question("Is the sum of interior angles in a triangle always equal to 180 degrees?", true),
  Question("Is the number 0 considered an even number?", true),
  Question("Is the product of any number and zero always zero?", true),
  Question("Are all prime numbers greater than 1?", true),
  Question("Is the number Pi equal to 3.14?", false),
  Question("Can you divide any number by zero?", false),
  Question("Is the area of a circle equal to Pi times the square of its radius?", true),
  Question("Is the cube of any integer always an even number?", false),
  Question("Is the number 1 considered a prime number?", false)
];

CategoryItem music = CategoryItem("MUSIC", "images/music.jpg", musicQ);

List<Question> musicQ = [
  Question("Was Michael Jackson known as the 'King of Pop'?", true),
  Question("Did The Beatles release the album 'Abbey Road' in 1969?", true),
  Question("Is the instrument 'trombone' a member of the brass family?", true),
  Question("Did Freddie Mercury serve as the lead vocalist for the band Queen?", true),
  Question("Is Beethoven's Symphony No. 9 also known as the 'Ode to Joy'?", true),
  Question("Was Elvis Presley born in Memphis, Tennessee?", true),
  Question("Did Mozart compose the 'Fur Elise' piano piece?", false),
  Question("Is the violin a percussion instrument?", false),
  Question("Did Bob Marley originate from Jamaica?", true),
  Question("Is 'Bohemian Rhapsody' by Queen the longest song to reach number one in the UK?", true)
];

CategoryItem skating = CategoryItem("FIGURE SKATING", "images/skating.jpg", skatingQ);

List<Question> skatingQ = [
  Question("Is a triple axel a figure skating jump with three and a half rotations?", true),
  Question("Are the edges of figure skates usually made of steel?", true),
  Question("Is a sit spin a figure skating spin position where the skater's body is in a sitting position?", true),
  Question("Was Dorothy Hamill an Olympic gold medalist in figure skating?", true),
  Question("Is a Zamboni used to resurface the ice in figure skating rinks?", true),
  Question("Is a camel spin a figure skating spin named after the animal due to its resemblance to the animal's hump?", true),
  Question("Is the term 'twizzle' used in figure skating to refer to a type of jump?", false),
  Question("Is the International Skating Union (ISU) the governing body for figure skating?", true),
  Question("Is a lutz jump a figure skating jump that takes off from the back outside edge of one foot?", true),
  Question("Is the term 'Salchow' named after a German figure skater who invented the jump?", true)
];

CategoryItem coding = CategoryItem("CODING", "images/coding.jpg", codingQ);

List<Question> codingQ = [
  Question("Is Java a statically typed programming language?", true),
  Question("Does HTML stand for Hyper Text Markup Language?", true),
  Question("Is Python a compiled language?", false),
  Question("Is CSS used for defining the structure of a web page?", false),
  Question("Is JavaScript a scripting language often used for web development?", true),
  Question("Is PHP primarily used for server-side scripting?", true),
  Question("Is C# a programming language developed by Google?", false),
  Question("Is SQL a programming language used for managing and querying databases?", true),
  Question("Is Ruby on Rails a framework for building web applications using the Ruby programming language?", true),
  Question("Is Git a version control system commonly used in software development?", true)
];

CategoryItem nature = CategoryItem("NATURE", "images/nature.jpg", natureQ);

List<Question> natureQ = [
  Question("Is photosynthesis the process by which plants convert light energy into chemical energy?", true),
  Question("Are deciduous trees those that keep their leaves year-round?", false),
  Question("Is the Amazon Rainforest the largest tropical rainforest in the world?", true),
  Question("Are amphibians animals that can live both on land and in water?", true),
  Question("Is the Great Barrier Reef the largest coral reef system in the world?", true),
  Question("Is a carnivore an animal that primarily eats plants?", false),
  Question("Is Mount Everest the tallest mountain above sea level?", true),
  Question("Is a hurricane a large-scale tropical storm system with strong winds and heavy rain?", true),
  Question("Are succulents plants that store water in their leaves, stems, or roots?", true),
  Question("Is Antarctica the largest desert in the world?", true)
];