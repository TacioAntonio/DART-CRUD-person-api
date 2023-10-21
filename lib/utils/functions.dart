import 'dart:math';

bool isValidEmail(String email) {
  final emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final re = RegExp(emailRegex);

  return re.hasMatch(email);
}

String generateRandomID() {
  final rand = Random();
  final idLength = 8;

  final chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  final id = List.generate(idLength, (index) => chars[rand.nextInt(chars.length)]).join();

  return id;
}