import 'package:acrova/data/models/response/project/engineer_response_model.dart';
import 'package:acrova/utils/enums/budget_tier_enum.dart';
import 'package:acrova/utils/enums/interior_design_scope_enum.dart';
import 'package:acrova/utils/enums/interior_design_status_enum.dart';
import 'package:acrova/utils/enums/project_timeline_enum.dart';
import 'package:equatable/equatable.dart';

/// Immutable response model for an Interior Design request.
class InteriorDesignResponseModel extends Equatable {
  const InteriorDesignResponseModel({
    this.id,
    this.referenceNumber,
    this.projectId,
    this.projectName,
    this.projectThumbnailUrl,
    this.title,
    this.status,
    this.scope,
    this.budgetTier,
    this.timeline,
    this.customScopeNotes,
    this.spacePlanningRequired = false,
    this.moodboards = const [],
    this.colorPalette = const [],
    this.extraNotes,
    this.inspirationMediaUrls = const [],
    this.inspirationLinks = const [],
    this.thumbnailUrl,
    this.amountDue,
    this.designer,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? referenceNumber;
  final String? projectId;
  final String? projectName;
  final String? projectThumbnailUrl;
  final String? title;
  final InteriorDesignStatus? status;
  final InteriorDesignScope? scope;
  final BudgetTier? budgetTier;
  final ProjectTimeline? timeline;
  final String? customScopeNotes;
  final bool spacePlanningRequired;
  final List<String> moodboards;
  final List<String> colorPalette;
  final String? extraNotes;
  final List<String> inspirationMediaUrls;
  final List<String> inspirationLinks;
  final String? thumbnailUrl;
  final double? amountDue;
  final EngineerResponseModel? designer;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory InteriorDesignResponseModel.fromJson(Map<String, dynamic> json) {
    return InteriorDesignResponseModel(
      id: json['id'] as String?,
      referenceNumber:
          json['reference_number'] as String? ??
          json['referenceNumber'] as String?,
      projectId: json['project_id'] as String? ?? json['projectId'] as String?,
      projectName:
          json['project_name'] as String? ?? json['projectName'] as String?,
      projectThumbnailUrl:
          json['project_thumbnail_url'] as String? ??
          json['projectThumbnailUrl'] as String?,
      title: json['title'] as String?,
      status:
          InteriorDesignStatus.fromId(
            int.tryParse(json['status_id'] ?? json['status']),
          ) ??
          InteriorDesignStatus.fromValue(json['status']),
      scope:
          InteriorDesignScope.fromId(
            int.tryParse(json['scope_id'] ?? json['scope']),
          ) ??
          InteriorDesignScope.fromValue(json['scope']),
      budgetTier:
          BudgetTier.fromId(
            int.tryParse(
              json['budget_tier_id'] ??
                  json['budgetTier_id'] ??
                  json['budget_tier'] ??
                  json['budgetTier'],
            ),
          ) ??
          BudgetTier.fromValue(json['budget_tier'] ?? json['budgetTier']),
      timeline:
          ProjectTimeline.fromId(
            int.tryParse(json['timeline_id'] ?? json['timeline']),
          ) ??
          ProjectTimeline.fromValue(json['timeline']),
      customScopeNotes:
          json['custom_scope_notes'] as String? ??
          json['customScopeNotes'] as String?,
      spacePlanningRequired:
          json['space_planning_required'] as bool? ??
          json['spacePlanningRequired'] as bool? ??
          false,
      moodboards:
          (json['moodboards'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      colorPalette:
          (json['color_palette'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          (json['colorPalette'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      extraNotes:
          json['extra_notes'] as String? ?? json['extraNotes'] as String?,
      inspirationMediaUrls:
          (json['inspiration_media_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          (json['inspirationMediaUrls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      inspirationLinks:
          (json['inspiration_links'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          (json['inspirationLinks'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      thumbnailUrl:
          json['thumbnail_url'] as String? ?? json['thumbnailUrl'] as String?,
      amountDue: double.tryParse(json['amount_due'] ?? json['amountDue']),
      designer:
          json['designer'] != null && json['designer'] is Map<String, dynamic>
          ? EngineerResponseModel.fromJson(
              json['designer'] as Map<String, dynamic>,
            )
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference_number': referenceNumber,
      'project_id': projectId,
      'project_name': projectName,
      'project_thumbnail_url': projectThumbnailUrl,
      'title': title,
      'status': status?.id,
      'status_id': status?.id,
      'scope': scope?.id,
      'scope_id': scope?.id,
      'budget_tier': budgetTier?.id,
      'budget_tier_id': budgetTier?.id,
      'timeline': timeline?.id,
      'timeline_id': timeline?.id,
      'custom_scope_notes': customScopeNotes,
      'space_planning_required': spacePlanningRequired,
      'moodboards': moodboards,
      'color_palette': colorPalette,
      'extra_notes': extraNotes,
      'inspiration_media_urls': inspirationMediaUrls,
      'inspiration_links': inspirationLinks,
      'thumbnail_url': thumbnailUrl,
      'amount_due': amountDue,
      'designer': designer?.toJson(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  InteriorDesignResponseModel copyWith({
    String? id,
    String? referenceNumber,
    String? projectId,
    String? projectName,
    String? projectThumbnailUrl,
    String? title,
    InteriorDesignStatus? status,
    InteriorDesignScope? scope,
    BudgetTier? budgetTier,
    ProjectTimeline? timeline,
    List<String>? specificRooms,
    String? customScopeNotes,
    bool? spacePlanningRequired,
    List<String>? moodboards,
    List<String>? colorPalette,
    List<String>? atmosphereTags,
    String? extraNotes,
    List<String>? inspirationMediaUrls,
    List<String>? inspirationLinks,
    String? thumbnailUrl,
    double? amountDue,
    EngineerResponseModel? designer,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InteriorDesignResponseModel(
      id: id ?? this.id,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      projectThumbnailUrl: projectThumbnailUrl ?? this.projectThumbnailUrl,
      title: title ?? this.title,
      status: status ?? this.status,
      scope: scope ?? this.scope,
      budgetTier: budgetTier ?? this.budgetTier,
      timeline: timeline ?? this.timeline,
      customScopeNotes: customScopeNotes ?? this.customScopeNotes,
      spacePlanningRequired:
          spacePlanningRequired ?? this.spacePlanningRequired,
      moodboards: moodboards ?? this.moodboards,
      colorPalette: colorPalette ?? this.colorPalette,
      extraNotes: extraNotes ?? this.extraNotes,
      inspirationMediaUrls: inspirationMediaUrls ?? this.inspirationMediaUrls,
      inspirationLinks: inspirationLinks ?? this.inspirationLinks,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      amountDue: amountDue ?? this.amountDue,
      designer: designer ?? this.designer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    referenceNumber,
    projectId,
    projectName,
    projectThumbnailUrl,
    title,
    status,
    scope,
    budgetTier,
    timeline,
    customScopeNotes,
    spacePlanningRequired,
    moodboards,
    colorPalette,
    extraNotes,
    inspirationMediaUrls,
    inspirationLinks,
    thumbnailUrl,
    amountDue,
    designer,
    createdAt,
    updatedAt,
  ];
}
