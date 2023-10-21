import 'package:shelf/shelf.dart';
import 'dart:convert';
import 'dart:core';
import '../types/Person.dart';
import '../utils/fake_data.dart';
import '../utils/functions.dart';

Response getAll(Request request) {
  return Response.ok(jsonEncode(persons), headers: {'Content-Type': 'application/json'});
}

Response getPersonByID(Request request, String id) {
  final currentPerson = persons.firstWhere((p) => p.Id == id, orElse: () => Person('', '', '', '', '', 0));

  if (currentPerson.Id == '') {
    return Response.notFound('Person not found');
  }

  return Response.ok(jsonEncode(currentPerson), headers: {'Content-Type': 'application/json'});
}

Future<Response> create(Request request) async {
  final requestBody = await request.readAsString();

  try {
    final Map<String, dynamic> newDataPerson = jsonDecode(requestBody) as Map<String, dynamic>;
 
    final avatar = newDataPerson['Avatar'] as String;
    final firstname = newDataPerson['Firstname'] as String;
    final lastname = newDataPerson['Lastname'] as String;
    final email = newDataPerson['Email'] as String;
    final age = newDataPerson['Age'] as int;

    if (avatar == "") {
      return Response.notFound('Avatar is a required field');
    }

    if (firstname == "") {
      return Response.notFound('Firstname is a required field');
    }

    if (lastname == ""){
      return Response.notFound('Lastname is a required field');
    }

    if (email == "") {
        return Response.notFound('Email is a required field');
    }

    if (!isValidEmail(email)) {
      return Response.notFound('Email is invalid');
    }

    if (age <= 0 || age > 120) {
      return Response.notFound('The Age field must be greater than 0 and less than or equal to 120');
    }

    persons.add(Person(generateRandomID(), avatar, firstname, lastname, email, age));

    return Response.ok(jsonEncode({'message': 'Stored successfully!'}), headers: {'Content-Type': 'application/json'});
  } catch (e) {
    final errorMessage = 'Error: $e';
    return Response(
      400,
      body: errorMessage,
      headers: {'Content-Type': 'text/plain'},
    );
  }
}

Response delete(Request request, String id) {
  final index = persons.indexWhere((person) => person.Id == id);

  if (index == -1) { return Response.notFound('Person not found'); }

  persons.removeAt(index);

  return Response.ok(jsonEncode({'message': 'Person deleted successfully!'}), headers: {'Content-Type': 'application/json'});
}


Future<Response> update(Request request, String id) async {
  final requestBody = await request.readAsString();

  try {
    final indexToUpdate = persons.indexWhere((person) => person.Id == id);

    if (indexToUpdate == -1) { return Response.notFound('Person not found'); }

    final Map<String, dynamic> newDataPerson = jsonDecode(requestBody) as Map<String, dynamic>;
 
    final avatar = newDataPerson['Avatar'] as String;
    final firstname = newDataPerson['Firstname'] as String;
    final lastname = newDataPerson['Lastname'] as String;
    final email = newDataPerson['Email'] as String;
    final age = newDataPerson['Age'] as int;

    if (avatar == '') {
      return Response.notFound('Avatar is a required field');
    }

    if (firstname == '') {
      return Response.notFound('Firstname is a required field');
    }

    if (lastname == ''){
      return Response.notFound('Lastname is a required field');
    }

    if (email == '') {
        return Response.notFound('Email is a required field');
    }

    if (!isValidEmail(email)) {
      return Response.notFound('Email is invalid');
    }

    if (age <= 0 || age > 120) {
      return Response.notFound('The Age field must be greater than 0 and less than or equal to 120');
    }

    persons[indexToUpdate] = Person(persons[indexToUpdate].Id, avatar, firstname, lastname, email, age);
    return Response.ok(jsonEncode({'message': 'Person updated successfully!'}), headers: {'Content-Type': 'application/json'});
  } catch(e) {
    final errorMessage = 'Error: $e';
    return Response(
      400,
      body: errorMessage,
      headers: {'Content-Type': 'text/plain'},
    );
  }
}