class UserModel {
  final int? id; // User ID, nullable because it might not be assigned yet (e.g., before saving to DB)
  final String name; // User name, required for every UserModel instance

  UserModel({this.id, required this.name}); // Constructor to create a UserModel; 'id' optional, 'name' required

  Map<String, dynamic> toMap() { // Converts UserModel instance to a Map for storage (e.g., in DB or JSON)
    return {
      'id': id, // Stores the user ID
      'name': name, // Stores the user name
    };
  }
  factory UserModel.fromMap(Map<String, dynamic> map) { // Creates a UserModel instance from a Map (e.g., from DB or JSON)
    return UserModel(
      id: map['id'], // Reads the 'id' field from the map
      name: map['name'], // Reads the 'name' field from the map
    );
  }
}