// class Users {
//   final int? id;
//   final String title;
//   final num price;
//   final String description;
//   final String category;
//   final String image;

//   Users({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.category,
//     required this.image,
//   });
//   factory Users.fromJson(Map<String, dynamic> json) {
//     return Users(
//       id: json['id'] ?? '',
//       title: json['title'] ?? '',
//       price: json['price'] ?? 0,
//       description: json['description'] ?? '',
//       category: json['category'] ?? '',
//       image: json['image'] ?? '',
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'price': price,
//       'description': description,
//       'category': category,
//       'image': image,
//     };
//   }
// }

class Users {
  final int? id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final Rating? rating; // ✅ add rating

  Users({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    };
  }
}

// ✅ Rating model
class Rating {
  final num rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(rate: json['rate'] ?? 0, count: json['count'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }
}
