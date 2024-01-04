//! Sprites

class SpritesEntity {
  final OtherEntity other;
  const SpritesEntity({
    required this.other,
  });
}

class OtherEntity {
  final OfficialArtworkEntity officialArtwork;
  const OtherEntity({
    required this.officialArtwork,
  });
}

class OfficialArtworkEntity {
  final String frontDefault;
  const OfficialArtworkEntity({
    required this.frontDefault,
  });
}

//! Types

class TypesEntity {
  final TypeEntity type;
  const TypesEntity({
    required this.type,
  });
}

class TypeEntity {
  final String name;
  const TypeEntity({
    required this.name,
  });
}
