// ignore_for_file: non_constant_identifier_names
class Person {
  String Id;
  String Avatar;
  String Firstname;
  String Lastname;
  String Email;
  int Age;

  Person(this.Id, this.Avatar, this.Firstname, this.Lastname, this.Email, this.Age);

   Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'Avatar': Avatar,
      'Firstname': Firstname,
      'Lastname': Lastname,
      'Email': Email,
      'Age': Age,
    };
  }
}
