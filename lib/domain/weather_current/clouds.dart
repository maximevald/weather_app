class Clouds {
  const Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json['all'] as int,
      );
      
  final int all;

  Map<String, dynamic> toJson() => {
        'all': all,
      };
}
