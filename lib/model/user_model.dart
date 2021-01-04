

class UserModel{

  String surname;
  String name;
  int phone;
  


  UserModel();
  UserModel.fromJson(var data):
        surname = data["surname"],
        name = data['name'],
        phone = data['phone'];
}