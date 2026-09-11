import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Represents an interior design color theme palette.
class InteriorDesignPaletteModel extends Equatable {
  const InteriorDesignPaletteModel({
    required this.id,
    required this.colorValues,
  });

  final String id;
  final List<int> colorValues;

  List<Color> get colors => colorValues.map(Color.new).toList();

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    switch (id) {
      case 'Warm Neutrals':
        return loc.interiorDesignPaletteWarmNeutrals;
      case 'Cool Elegance':
        return loc.interiorDesignPaletteCoolElegance;
      case 'Earthy Tones':
        return loc.interiorDesignPaletteEarthyTones;
      case 'Monochrome':
        return loc.interiorDesignPaletteMonochrome;
      case 'Desert Sun':
        return loc.interiorDesignPaletteDesertSun;
      default:
        return id;
    }
  }

  factory InteriorDesignPaletteModel.fromJson(Map<String, dynamic> json) {
    return InteriorDesignPaletteModel(
      id: json['id'] as String,
      colorValues:
          (json['colors'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'colors': colorValues};

  static const List<InteriorDesignPaletteModel> defaultPalettes = [
    InteriorDesignPaletteModel(
      id: 'Warm Neutrals',
      colorValues: [0xFFE3D9CC, 0xFFC9B6A1, 0xFF9E8570, 0xFF54433A],
    ),
    InteriorDesignPaletteModel(
      id: 'Cool Elegance',
      colorValues: [0xFFE6ECEB, 0xFFB3C5C2, 0xFF6B8A88, 0xFF2F4543],
    ),
    InteriorDesignPaletteModel(
      id: 'Earthy Tones',
      colorValues: [0xFFF2EBE5, 0xFFD4C3B3, 0xFF8A9A86, 0xFF4A5D4E],
    ),
    InteriorDesignPaletteModel(
      id: 'Monochrome',
      colorValues: [0xFFF5F5F5, 0xFFCCCCCC, 0xFF666666, 0xFF1A1A1A],
    ),
    InteriorDesignPaletteModel(
      id: 'Desert Sun',
      colorValues: [0xFFFDF7ED, 0xFFEEDBB7, 0xFFD29C6C, 0xFF9B5E3C],
    ),
  ];

  @override
  List<Object?> get props => [id, colorValues];
}

/// Represents an atmosphere/vibe tag for interior design.
class AtmosphereTagModel extends Equatable {
  const AtmosphereTagModel({required this.id});

  final String id;

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    switch (id) {
      case 'Minimalist':
        return loc.interiorDesignTagMinimalist;
      case 'Cozy':
        return loc.interiorDesignTagCozy;
      case 'Luxurious':
        return loc.interiorDesignTagLuxurious;
      case 'Industrial':
        return loc.interiorDesignTagIndustrial;
      case 'Bohemian':
        return loc.interiorDesignTagBohemian;
      case 'Contemporary':
        return loc.interiorDesignTagContemporary;
      case 'Classic':
        return loc.interiorDesignTagClassic;
      case 'Biophilic':
        return loc.interiorDesignTagBiophilic;
      case 'Vibrant':
        return loc.interiorDesignTagVibrant;
      case 'Serene':
        return loc.interiorDesignTagSerene;
      default:
        return id;
    }
  }

  factory AtmosphereTagModel.fromJson(Map<String, dynamic> json) =>
      AtmosphereTagModel(id: json['id'] as String);

  Map<String, dynamic> toJson() => {'id': id};

  static const List<AtmosphereTagModel> defaultTags = [
    AtmosphereTagModel(id: 'Minimalist'),
    AtmosphereTagModel(id: 'Cozy'),
    AtmosphereTagModel(id: 'Luxurious'),
    AtmosphereTagModel(id: 'Industrial'),
    AtmosphereTagModel(id: 'Bohemian'),
    AtmosphereTagModel(id: 'Contemporary'),
    AtmosphereTagModel(id: 'Classic'),
    AtmosphereTagModel(id: 'Biophilic'),
    AtmosphereTagModel(id: 'Vibrant'),
    AtmosphereTagModel(id: 'Serene'),
  ];

  @override
  List<Object?> get props => [id];
}
