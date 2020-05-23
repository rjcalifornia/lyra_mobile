class Centers {
  final int id;
  final String name;

  Centers({this.id, this.name});

  factory Centers.fromJson(Map<String, dynamic> parsedJson){
    return Centers(id: parsedJson['id'], name: parsedJson['name']);
  }

}