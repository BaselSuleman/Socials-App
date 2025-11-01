class StoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final bool isOwnStory;
  final bool hasNewStory;

  const StoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isOwnStory = false,
    this.hasNewStory = false,
  });

  factory StoryModel.own({
    required String id,
    required String imageUrl,
    bool hasNewStory = false,
  }) {
    return StoryModel(
      id: id,
      name: 'Your Story',
      imageUrl: imageUrl,
      isOwnStory: true,
      hasNewStory: hasNewStory,
    );
  }

  StoryModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    bool? isOwnStory,
    bool? hasNewStory,
  }) {
    return StoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      isOwnStory: isOwnStory ?? this.isOwnStory,
      hasNewStory: hasNewStory ?? this.hasNewStory,
    );
  }
}