// import 'dart:math';
//
// void main() {
//   //Variables
//
//   // Write a program that generates a random integer and then:
//   // Check if it is divisible by 5 and print the result
//   // Check if the number is even and print the result
//   // Convert the number to double
//
//   int number = Random().nextInt(100);
//   bool divisibleBy5 = number % 5 == 0;
//   bool isInteger(num value) => value is int;
//
//   // print("$number");
//   // print("Number is even ${number.isEven}");
//   // print("Number is integer ${isInteger(number / 3)}");
//   // print("Number is divisible by 5 $divisibleBy5");
//   // print("Number to double ${number.toDouble()}");
//   // print("number.compareTo(3) ${number.compareTo(3)}");
//
//   // bool shouldGenerateInt = Random().nextBool() == true;
//   // num randomNumber =
//   // shouldGenerateInt ? Random().nextInt(100) : Random().nextDouble();
//
//   // Generate a random integer in the range 3-25
//   // int min = 3;
//   // int max = 25;
//   // int number2 = min + Random().nextInt(max - min);
//   // print(number2);
//
//   // Generate a random negative int and print the result
//   // int min = -1;
//   // int max = 2;
//   // int negativeNumber = min + Random().nextInt(max - min);
//   // print("$negativeNumber");
//
//   // Generate a random num and then:
//   // Create a function that checks if the num is int or double and prints out the result
//   // Move the function to an extension
//
//   // num generateRandomNumber({
//   //   int min = -100,
//   //   int max = 100,
//   // }) {
//   //   bool isInt = Random().nextBool();
//   //   int randomInt = min + Random().nextInt(max - min);
//   //   return isInt ? randomInt : randomInt - 1 + Random().nextDouble();
//   // }
//   //
//   // num randomNumber = generateRandomNumber();
//   // print(randomNumber);
//   // print(randomNumber.checkIfNumIsPositive());
//
//   // String generateRandomString(
//   //   int length, {
//   //   CharacterType characterType = CharacterType.allCharacters,
//   // }) {
//   //   String uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//   //   String lowercaseLetters = "abcdefghijklmnopqrstuvwxyz";
//   //   String numbers = "0123456789";
//   //   String specialCharacters = "!#%&()*+,-.:;<=>?^_`{|}~";
//   //
//   //   String selectedStringType;
//   //   switch (characterType) {
//   //     case CharacterType.uppercaseLetters:
//   //       selectedStringType = uppercaseLetters;
//   //       break;
//   //     case CharacterType.lowercaseLetters:
//   //       selectedStringType = lowercaseLetters;
//   //       break;
//   //     case CharacterType.numbers:
//   //       selectedStringType = numbers;
//   //       break;
//   //     case CharacterType.letters:
//   //       selectedStringType = uppercaseLetters + lowercaseLetters;
//   //       break;
//   //     case CharacterType.allCharacters:
//   //     default:
//   //       selectedStringType =
//   //           uppercaseLetters + lowercaseLetters + numbers + specialCharacters;
//   //       break;
//   //   }
//   //   return String.fromCharCodes(Iterable.generate(
//   //       length,
//   //       (_) => selectedStringType.codeUnitAt(
//   //             Random().nextInt(selectedStringType.length),
//   //           )));
//   // }
//   //
//   // print(generateRandomString(
//   //   3,
//   //   characterType: CharacterType.allCharacters,
//   // ));
//   // Write a function to sum values of the following list
//   // List<int> sumThis = [1, 4, 6, 32, 67, 76];
//
//   List<int> sumThis = [1, 4, 6, 32, 67, 76];
//   int sumUp() {
//     int x = 0;
//     for (int i in sumThis) {
//       x += i;
//     }
//     return x;
//   }
//
//   int sum = sumThis.reduce((a, b) => a + b);
//   int sum2 = sumThis.fold(0, (p, c) => p + c);
//
//   print(sumUp());
//   print(sum);
//   print(sum2);
//   DateTime time = DateTime.now();
//
//   print(time);
//   print(time.toUtc());
// }
//
// enum CharacterType {
//   uppercaseLetters,
//   lowercaseLetters,
//   letters,
//   numbers,
//   allCharacters,
// }
//
// extension NumExtension on num {
//   bool checkIfNumIsPositive() {
//     // return this >= 0.0;
//     return this.sign != -1;
//   }
// }
