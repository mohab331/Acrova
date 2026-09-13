import 'dart:ui';

import 'package:acrova/core/config/mock_config.dart';
import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/core/error/error_codes_enum.dart';
import 'package:acrova/data/data_source/remote/network/models/network_response.dart';
import 'package:acrova/data/models/request/auth/save_profile_request_model.dart';
import 'package:acrova/data/models/request/auth/send_otp_request_model.dart';
import 'package:acrova/data/models/request/auth/verify_otp_request_model.dart';
import 'package:acrova/data/models/request/billing/get_payment_details_request_model.dart';
import 'package:acrova/data/models/request/billing/get_payment_quote_request_model.dart';
import 'package:acrova/data/models/request/billing/submit_payment_request_model.dart';
import 'package:acrova/data/models/request/contact_us/submit_inquiry_request_model.dart';
import 'package:acrova/data/models/request/portfolio/get_portfolio_item_request_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request_model.dart';
import 'package:acrova/data/models/request/project/create_project_request_model.dart';
import 'package:acrova/data/models/request/project/get_project_request_model.dart';
import 'package:acrova/data/models/request/project/interior_design_request_model.dart';
import 'package:acrova/data/models/request/revision/create_revision_request_model.dart';
import 'package:acrova/data/models/request/revision/get_revision_request_model.dart';
import 'package:acrova/data/models/response/auth/verify_otp_response_model.dart';
import 'package:acrova/data/models/response/billing/payment_quote_response_model.dart';
import 'package:acrova/data/models/response/billing/payment_response_model.dart';
import 'package:acrova/data/models/response/config/min_app_version_response_model.dart';
import 'package:acrova/data/models/response/dashboard/dashboard_response_model.dart';
import 'package:acrova/data/models/response/deliverables/blueprint_response_model.dart';
import 'package:acrova/data/models/response/deliverables/deliverables_response_model.dart';
import 'package:acrova/data/models/response/deliverables/render_response_model.dart';
import 'package:acrova/data/models/response/notification/app_notification_response_model.dart';
import 'package:acrova/data/models/response/portfolio/portfolio_item_response_model.dart';
import 'package:acrova/data/models/response/portfolio/walkthrough_response_model.dart';
import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';
import 'package:acrova/data/models/response/project/deliverable_response_model.dart';
import 'package:acrova/data/models/response/project/engineer_response_model.dart';
import 'package:acrova/data/models/response/project/moodboard_response_model.dart';
import 'package:acrova/data/models/response/project/project_response_model.dart';
import 'package:acrova/data/models/response/revision/revision_quota_response_model.dart';
import 'package:acrova/data/models/response/revision/revision_response_model.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/domain/repository/contact_us/base_contact_us_repo.dart';
import 'package:acrova/domain/repository/dashboard/base_dashboard_repo.dart';
import 'package:acrova/domain/repository/deliverables/base_deliverables_repo.dart';
import 'package:acrova/domain/repository/localization/base_localization_repo.dart';
import 'package:acrova/domain/repository/notifications/base_notifications_repo.dart';
import 'package:acrova/domain/repository/portfolio/base_portfolio_repo.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/enums/revision_status_enum.dart';
import 'package:acrova/utils/helpers/result.dart';

class _MockBase {
  static const Duration _mockDelay = Duration(seconds: 2);

  bool shouldThrow(MockRepositoryKey key) =>
      MockConfig.scenario(key) == MockScenario.error;

  bool isEmpty(MockRepositoryKey key) =>
      MockConfig.scenario(key) == MockScenario.empty;

  Future<void> simulateDelay() async {
    await Future.delayed(_mockDelay);
  }

  Failure<T> mockError<T>([String message = 'Mock operation failed']) =>
      Failure(
        AppErrorModel(
          code: ErrorCodesEnum.unknown,
          title: 'Mock Error',
          message: message,
        ),
      );
}

class MockAuthRepo extends _MockBase implements BaseAuthRepo {
  MockAuthRepo({bool isVisitorMode = false}) : _isVisitorMode = isVisitorMode;

  bool _isVisitorMode;
  UserProfileResponseModel? _currentProfile;

  void setVisitorMode(bool isVisitor) {
    _isVisitorMode = isVisitor;
    if (isVisitor) {
      _currentProfile = null;
    } else {
      _currentProfile ??= _defaultProfile;
    }
  }

  static final _defaultProfile = UserProfileResponseModel(
    name: 'Mohab Osama',
    email: 'mohab@acrova.sa',
    mobileNumber: '+966500000000',
    nationalId: '1000000000',
    language: 'ar',
    memberSince: DateTime(2023, 1, 1),
    projectsCount: 3,
    completedCount: 1,
    avatarUrl:
        'https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png',
  );

  @override
  Future<Result<void>> login(SendOTPRequestModel request) async {
    if (shouldThrow(MockRepositoryKey.auth)) return mockError();

    await simulateDelay();

    return const Success(null);
  }

  @override
  Future<Result<VerifyOTPResponseModel>> verifyOtp(
    VerifyOTPRequestModel verifyOTPRequestModel,
  ) async {
    if (shouldThrow(MockRepositoryKey.auth)) return mockError();

    await simulateDelay();

    return const Success(
      VerifyOTPResponseModel(
        refreshToken: 'qwjkndfkjnqwoiqewoineqw',
        accessToken: 'qwjkndfkjnqwoiqewoineqw',
      ),
    );
  }

  @override
  Future<Result<void>> saveProfile(SaveProfileRequestModel request) async {
    if (shouldThrow(MockRepositoryKey.auth)) return mockError();

    await simulateDelay();

    _isVisitorMode = false;
    _currentProfile = UserProfileResponseModel(
      name: request.name,
      email: request.email,
      mobileNumber: request.mobileNumber ?? '+966500000000',
      nationalId: request.nationalId,
      language: request.language,
      memberSince: DateTime.now(),
      projectsCount: 0,
      completedCount: 0,
      avatarUrl: request.avatarPath,
    );

    return const Success(null);
  }

  @override
  Future<Result<UserProfileResponseModel?>> getUserProfile() async {
    if (shouldThrow(MockRepositoryKey.auth)) return mockError();

    await simulateDelay();

    if (_isVisitorMode) {
      return const Success(null);
    }

    return Success(_currentProfile ?? _defaultProfile);
  }

  @override
  Future<Result<UserProfileResponseModel>> updateUserProfile(
    UpdateProfileRequestModel request,
  ) async {
    if (shouldThrow(MockRepositoryKey.auth)) return mockError();

    await simulateDelay();

    _isVisitorMode = false;
    _currentProfile = UserProfileResponseModel(
      name: request.name,
      email: request.email,
      mobileNumber: request.mobileNumber,
      nationalId: _currentProfile?.nationalId ?? '1000000000',
      language: _currentProfile?.language ?? 'ar',
      memberSince: _currentProfile?.memberSince ?? DateTime(2023, 1, 1),
      projectsCount: _currentProfile?.projectsCount ?? 3,
      completedCount: _currentProfile?.completedCount ?? 1,
      avatarUrl:
          request.avatarPath ??
          _currentProfile?.avatarUrl ??
          'https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png',
    );

    return Success(_currentProfile!);
  }

  @override
  Future<Result<String?>> getRefreshToken() async {
    await simulateDelay();
    return const Success('mock_refresh_token');
  }

  @override
  Future<Result<String?>> getAccessToken() async {
    await simulateDelay();
    return const Success('mock_access_token');
  }

  @override
  Future<Result<String?>> getFCMToken() async {
    await simulateDelay();
    return const Success('mock_fcm_token');
  }

  @override
  Future<Result<void>> clearUserData() async {
    await simulateDelay();
    _currentProfile = null;
    _isVisitorMode = true;
    return const Success(null);
  }
}

class MockProjectRepo extends _MockBase implements BaseProjectRepo {
  static final List<ProjectResponseModel> _mockProjects = [
    ProjectResponseModel(
      id: 'proj_001',
      name: 'Villa Al-Nakheel',
      type: ProjectType.villa,
      status: ProjectStatus.awaitingEngineering,
      location: 'Riyadh, Al-Malqa',
      thumbnailUrl:
          'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg',
      landAreaSqm: 750,
      floors: 3,
      bedrooms: 5,
      bathrooms: 6,
      landWidthM: 25,
      landLengthM: 30,
      hasMajlis: true,
      hasMaidRoom: true,
      hasDriverRoom: true,
      hasBasement: false,
      hasPool: true,
      hasRooftop: true,
      architecturalStyle: 'Modern Neoclassical',
      smartHomeLevel: 'Full Integration',
      description:
          'An exceptional contemporary residence blending minimalist lines with premium materials. Designed to maximize natural light while maintaining absolute privacy.',
      engineer: const EngineerResponseModel(
        name: 'Eng. Abdullah Al-Rashid',
        specialization: 'Lead Structural Engineer',
        avatarUrl:
            'https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png',
      ),
      provisions: const [
        'تكامل المنزل الذكي',
        'مسبح خاص',
        'جاهز للطاقة الشمسية',
        'تكييف مركزي',
        'تدفئة أرضية',
        'تشطيبات رخامية فاخرة',
      ],
      estimatedTimeline: '١٢ يوماً',
      deliverables: [
        DeliverableResponseModel(
          id: 'del_001',
          title: 'Ground Floor Architectural Plan',
          type: DeliverableType.pdf,
          url: 'https://example.com/floor_plan_ground.pdf',
          createdAt: DateTime(2024, 1, 16),
        ),
      ],
      createdAt: DateTime(2024, 1, 15),
    ),
    ProjectResponseModel(
      id: 'proj_002',
      name: 'Commercial Complex Al-Malqa',
      status: ProjectStatus.awaitingPricing,
      type: ProjectType.commercial,
      location: 'Al-Malqa, Riyadh',
      landAreaSqm: 2400,
      landWidthM: 40,
      landLengthM: 60,
      architecturalStyle: 'Contemporary Commercial',
      smartHomeLevel: 'BMS Enabled',
      description:
          'A flagship retail and commercial hub featuring expansive storefronts, underground parking, and flexible office layouts tailored for high-profile tenants.',
      provisions: const [
        'تكييف مركزي',
        'نظام إدارة المباني الذكي',
        'مواقف سيارات سفلية',
        'شبكة مراقبة أمنية',
      ],
      estimatedTimeline: '٢٤ يوماً',
      createdAt: DateTime(2024, 2, 1),
    ),
  ];

  @override
  Future<Result<List<ProjectResponseModel>>> getProjects() async {
    if (shouldThrow(MockRepositoryKey.project)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.project)) {
      return const Success([]);
    }

    return Success(_mockProjects);
  }

  @override
  Future<Result<ProjectResponseModel>> getProject(
    GetProjectRequestModel request,
  ) async {
    if (shouldThrow(MockRepositoryKey.project)) return mockError();

    await simulateDelay();

    final project = _mockProjects.firstWhere(
      (p) => p.id == request.id,
      orElse: () => _mockProjects.first,
    );

    return Success(project);
  }

  @override
  Future<Result<ProjectResponseModel>> createProject(
    CreateProjectRequestModel request,
  ) async {
    if (shouldThrow(MockRepositoryKey.project)) return mockError();

    await simulateDelay();

    final newProject = ProjectResponseModel(
      id: 'ARC-2024-${DateTime.now().millisecondsSinceEpoch % 100000}',
      name: '${request.projectType.displayLabel} Project',
      type: request.projectType,
      status: ProjectStatus.awaitingPricing,
      location: request.location,
      landAreaSqm: request.landAreaSqm,
      landWidthM: request.landWidthM,
      landLengthM: request.landLengthM,
      floors: request.floors,
      bedrooms: request.bedrooms,
      bathrooms: request.bathrooms,
      hasMajlis: request.hasMajlis,
      hasMaidRoom: request.hasMaidRoom,
      hasDriverRoom: request.hasDriverRoom,
      hasBasement: request.hasBasement,
      hasPool: request.hasPool,
      hasRooftop: request.hasRooftop,
      smartHomeLevel: request.smartHomeLevel,
      architecturalStyle: request.architecturalStyle,
      thumbnailUrl:
          'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg',
      createdAt: DateTime.now(),
    );

    return Success(newProject);
  }

  @override
  Future<Result<void>> submitInteriorDesign(
    InteriorDesignRequestModel request,
  ) async {
    if (shouldThrow(MockRepositoryKey.project)) return mockError();

    await simulateDelay();

    return const Success(null);
  }

  static const List<MoodboardResponseModel> _mockMoodboards = [
    MoodboardResponseModel(
      id: 'mb_1',
      url:
          'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&q=80&w=400',
      label: 'Modern Minimalist',
      labelAr: 'تصميم تبسيطي حديث',
    ),
    MoodboardResponseModel(
      id: 'mb_2',
      url:
          'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&q=80&w=400',
      label: 'Warm Organic',
      labelAr: 'طبيعي دافئ',
    ),
    MoodboardResponseModel(
      id: 'mb_3',
      url:
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&q=80&w=400',
      label: 'Dark Luxury',
      labelAr: 'فخامة داكنة',
    ),
    MoodboardResponseModel(
      id: 'mb_4',
      url:
          'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&q=80&w=400',
      label: 'Contemporary',
      labelAr: 'معاصر',
    ),
  ];

  @override
  Future<Result<List<MoodboardResponseModel>>> getMoodboards() async {
    if (shouldThrow(MockRepositoryKey.project)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.project)) {
      return const Success([]);
    }

    return const Success(_mockMoodboards);
  }
}

class MockBillingRepo extends _MockBase implements BaseBillingRepo {
  static final List<PaymentResponseModel> _mockPayments = [
    PaymentResponseModel(
      id: 'pay_001',
      projectId: 'proj_001',
      projectName: 'Villa Al-Nakheel',
      amount: 14000,
      currency: 'SAR',
      date: DateTime(2024, 1, 20),
      status: PaymentStatus.success,
      transactionId: 'TXN-982341',
      bankName: 'Al Rajhi Bank',
      iban: 'SA0380000000608010167519',
      accountName: 'Arcova Architecture & Design',
      receiptUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBO6D4aCgL7uutbd62c8gJ63feroaBUiwiIzmPSLd3KJ5RO1BEGoISuBUtitPTzM5ZqAUiHEfEHkhRsVotQh9IkIH6Pe9PjA-s17sjSJWjSJa7DrvBTlgXtY3G-Jv1nJL5q_FI3-t4mM7Mt6Xo_DpcsnYjtUnBE7r9SLGjtAE7cM741WiX-H3LUhjVaT5GbrAka-I-agO42IinP3rTSPW0UN2nEXmapFrLxhjHGeeyw48c9XemgPcwl',
    ),
    PaymentResponseModel(
      id: 'pay_002',
      projectId: 'proj_002',
      projectName: 'Al-Narjis Commercial Plaza',
      amount: 28500,
      currency: 'SAR',
      date: DateTime(2024, 2, 5),
      status: PaymentStatus.pending,
      transactionId: 'TXN-982342',
      bankName: 'Saudi National Bank',
      iban: 'SA0380000000608010167520',
      accountName: 'Arcova Architecture & Design',
    ),
    PaymentResponseModel(
      id: 'pay_003',
      projectId: 'proj_001',
      projectName: 'Villa Al-Nakheel',
      amount: 8000,
      currency: 'SAR',
      date: DateTime(2024, 2, 18),
      status: PaymentStatus.rejected,
      transactionId: 'TXN-982343',
      bankName: 'Al Rajhi Bank',
      iban: 'SA0380000000608010167519',
      accountName: 'Arcova Architecture & Design',
      rejectionReason:
          'Receipt image unreadable. Please re-upload a clear copy.',
    ),
  ];

  @override
  Future<Result<List<PaymentResponseModel>>> getPayments() async {
    if (shouldThrow(MockRepositoryKey.billing)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.billing)) {
      return const Success([]);
    }

    return Success(_mockPayments);
  }

  @override
  Future<Result<PaymentResponseModel>> getPaymentDetails(
    GetPaymentDetailsRequestModel request,
  ) async {
    if (shouldThrow(MockRepositoryKey.billing)) return mockError();

    await simulateDelay();

    final payment = _mockPayments.firstWhere(
      (p) => p.id == request.paymentId,
      orElse: () => _mockPayments.first,
    );

    return Success(payment);
  }

  @override
  Future<Result<void>> submitPayment(SubmitPaymentRequestModel request) async {
    if (shouldThrow(MockRepositoryKey.billing)) return mockError();

    await simulateDelay();

    return const Success(null);
  }

  @override
  Future<Result<PaymentQuoteResponseModel>> getPaymentQuote(
    GetPaymentQuoteRequestModel request,
  ) async {
    if (shouldThrow(MockRepositoryKey.billing)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.billing)) {
      return Success(
        PaymentQuoteResponseModel(
          projectId: request.projectId,
          amountDue: 0,
          baseFee: 0,
          vat: 0,
          total: 0,
          currency: 'SAR',
          bankName: '',
          iban: '',
          accountName: '',
        ),
      );
    }

    return Success(
      PaymentQuoteResponseModel(
        projectId: request.projectId,
        amountDue: 14000,
        baseFee: 10000,
        vat: 1200,
        total: 11200,
        currency: 'SAR',
        bankName: 'Saudi National Bank',
        iban: 'SA00 1000 0000 0000 0000 0000',
        accountName: 'Arcova Real Estate',
      ),
    );
  }
}

class MockNotificationsRepo extends _MockBase implements BaseNotificationsRepo {
  static final List<AppNotificationResponseModel> _mockNotifications = [
    AppNotificationResponseModel(
      id: 'notif_001',
      title: 'Structural Blueprints Ready',
      body: 'Phase 2 construction drawings are now available for review.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      isRead: false,
      projectId: 'proj_001',
    ),
    AppNotificationResponseModel(
      id: 'notif_002',
      title: 'Payment Verified',
      body: 'Your payment of SAR 14,000 for Villa Al-Nakheel was approved.',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: false,
      projectId: 'proj_001',
    ),
    AppNotificationResponseModel(
      id: 'notif_003',
      title: 'Revision Completed',
      body: 'Architectural changes to the master suite have been incorporated.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      projectId: 'proj_001',
    ),
  ];

  @override
  Future<Result<List<AppNotificationResponseModel>>> getNotifications() async {
    if (shouldThrow(MockRepositoryKey.notifications)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.notifications)) {
      return const Success([]);
    }

    return Success(_mockNotifications);
  }

  @override
  Future<Result<void>> markAllAsRead() async {
    if (shouldThrow(MockRepositoryKey.notifications)) return mockError();

    await simulateDelay();

    return const Success(null);
  }
}

class MockRevisionsRepo extends _MockBase implements BaseRevisionsRepo {
  static final List<RevisionResponseModel> _mockRevisions = [
    RevisionResponseModel(
      id: 'rev_001',
      status: RevisionStatus.completed,
      createdAt: DateTime(2024, 2, 10),
      description:
          'Living Room Wall Repositioning: Shift dining-living partition 1.2m west to enlarge seating area.',
      collaborators: const ['FA', 'MK'],
      engineerName: 'Eng. Fahad Al-Otaibi',
      engineerRole: 'Lead Architect',
      engineerNote:
          'Structural check cleared. Beam adjustments noted in sheet S-04.',
    ),
    RevisionResponseModel(
      id: 'rev_002',
      status: RevisionStatus.inProgress,
      createdAt: DateTime(2024, 2, 16),
      description:
          'Exterior Cladding Material Change: Swap limestone finish for dark travertine on upper facade.',
      collaborators: const ['FA'],
      engineerName: 'Eng. Fahad Al-Otaibi',
      engineerRole: 'Lead Architect',
      engineerNote: 'Pending client material sample approval.',
    ),
  ];

  @override
  Future<Result<List<RevisionResponseModel>>> getRevisions() async {
    if (shouldThrow(MockRepositoryKey.revisions)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.revisions)) {
      return const Success([]);
    }

    return Success(_mockRevisions);
  }

  @override
  Future<Result<RevisionResponseModel>> getRevision(
    GetRevisionRequestModel request,
  ) async {
    if (shouldThrow(MockRepositoryKey.revisions)) return mockError();

    await simulateDelay();

    final revision = _mockRevisions.firstWhere(
      (r) => r.id == request.id,
      orElse: () => _mockRevisions.first,
    );

    return Success(revision);
  }

  @override
  Future<Result<RevisionQuotaResponseModel>> getQuota() async {
    if (shouldThrow(MockRepositoryKey.revisions)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.revisions)) {
      return const Success(
        RevisionQuotaResponseModel(
          used: 3,
          total: 3,
          currency: 'SAR',
          paidCost: 500,
        ),
      );
    }

    return const Success(
      RevisionQuotaResponseModel(
        used: 1,
        total: 3,
        currency: 'SAR',
        paidCost: 500,
      ),
    );
  }

  @override
  Future<Result<RevisionResponseModel>> createRevision(
    CreateRevisionRequestModel request,
  ) async {
    if (shouldThrow(MockRepositoryKey.revisions)) return mockError();

    await simulateDelay();

    final newRev = RevisionResponseModel(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      status: RevisionStatus.inProgress,
      createdAt: DateTime.now(),
      description: request.details,
      collaborators: const ['FA'],
    );

    return Success(newRev);
  }

  @override
  Future<Result<List<String>>> getDeliverableRefs() async {
    if (shouldThrow(MockRepositoryKey.revisions)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.revisions)) {
      return const Success([]);
    }

    return const Success([
      'Floor Plan v1.1 — Main Residence',
      'Exterior Renderings v2',
      'Interior Moodboard v1',
    ]);
  }
}

class MockDashboardRepo extends _MockBase implements BaseDashboardRepo {
  @override
  Future<Result<DashboardResponseModel>> getDashboardData() async {
    if (shouldThrow(MockRepositoryKey.dashboard)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.dashboard)) {
      return const Success(DashboardResponseModel());
    }

    return const Success(
      DashboardResponseModel(userName: 'Mohab', notificationCount: 2),
    );
  }
}

class MockPortfolioRepo extends _MockBase implements BasePortfolioRepo {
  static const List<PortfolioItemResponseModel> _mockItems = [
    PortfolioItemResponseModel(
      id: 'grand_residence',
      style: 'Neoclassicism',
      category: 'exterior',
      title: 'The Grand Residence',
      location: 'Jeddah',
      area: '620 sqm',
      floors: '3 Floors',
      narrative:
          'A sweeping neoclassical estate that draws on European grand-villa proportions while embracing the Saudi climate. Symmetrical colonnades frame a central porte-cochère, and hand-carved stone detailing flows through every facade elevation.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAGNrH52huyQGEWIQKQDVt92V2iuZo5qfnXAZK9FoC3dzU0Y9NILlAN4FFLdIMcVnyP-G_iZ3RN3xrBhEJdOtMWcWap7toLFJHebSsfzYogzatTwl9D8swWRLXNDOzxKSLX3LjCSFvZX2VEU9uIRFBCfgKVBMCJlQQ6syNRJFiVOXkAlRuCZY7suJqiJ63eQ4m3ucqA8bkltfduLosOXBLwvUOXEfRK0pzy_vAluc6ZWsx_yjGvny4xtx2kQaHb3f-6dMOiNmzTapY',
      ],
      features: [
        'Grand Foyer',
        'Colonnade Facade',
        'Formal Gardens',
        'Smart Lighting',
      ],
      walkthroughModel: WalkthroughResponseModel(
        description:
            'A sweeping neoclassical estate that draws on European grand-villa proportions while embracing the Saudi climate. Symmetrical colonnades frame a central porte-cochère, and hand-carved stone detailing flows through every facade elevation.',
        format: '.mp4',
        quality: '4K',
        size: '50 mb',
        thumbnailImageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAGNrH52huyQGEWIQKQDVt92V2iuZo5qfnXAZK9FoC3dzU0Y9NILlAN4FFLdIMcVnyP-G_iZ3RN3xrBhEJdOtMWcWap7toLFJHebSsfzYogzatTwl9D8swWRLXNDOzxKSLX3LjCSFvZX2VEU9uIRFBCfgKVBMCJlQQ6syNRJFiVOXkAlRuCZY7suJqiJ63eQ4m3ucqA8bkltfduLosOXBLwvUOXEfRK0pzy_vAluc6ZWsx_yjGvny4xtx2kQaHb3f-6dMOiNmzTapY',
        title: 'Grand Residence Walkthrough',
        videoUrl: 'https://samplelib.com/mp4/sample-5s.mp4',
        duration: '3:38 m',
      ),
    ),
    PortfolioItemResponseModel(
      walkthroughModel: WalkthroughResponseModel(
        description:
            'A sweeping neoclassical estate that draws on European grand-villa proportions while embracing the Saudi climate. Symmetrical colonnades frame a central porte-cochère, and hand-carved stone detailing flows through every facade elevation.',
        format: '.mp4',
        quality: '4K',
        size: '50 mb',
        thumbnailImageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAGNrH52huyQGEWIQKQDVt92V2iuZo5qfnXAZK9FoC3dzU0Y9NILlAN4FFLdIMcVnyP-G_iZ3RN3xrBhEJdOtMWcWap7toLFJHebSsfzYogzatTwl9D8swWRLXNDOzxKSLX3LjCSFvZX2VEU9uIRFBCfgKVBMCJlQQ6syNRJFiVOXkAlRuCZY7suJqiJ63eQ4m3ucqA8bkltfduLosOXBLwvUOXEfRK0pzy_vAluc6ZWsx_yjGvny4xtx2kQaHb3f-6dMOiNmzTapY',
        title: 'Grand Residence Walkthrough',
        videoUrl: 'https://samplelib.com/mp4/sample-5s.mp4',
        duration: '3:38 m',
      ),
      id: 'alrashidi',
      style: 'Contemporary Arabic',
      category: 'exterior',
      title: 'The Al-Rashidi Residence',
      location: 'Riyadh',
      area: '450 sqm',
      floors: '4 Floors',
      narrative:
          'A grand contemporary Arabic estate featuring carved stone facades and a central courtyard. The architectural narrative seamlessly blends traditional elements with a modern, minimalist spatial philosophy.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBjZBYbSIxfI4qVARxNKv2jJBKCQoXan-O-f3iKjlkk2JtQ2xcLxA-oVm47pp5ruvu4SnFItwbxAkL0QVW-LgY9N7OKmfVodtJrWxAZfAtDVfscwo5OzTEsbBGJ94qvIg7bklMe-4lskjLJ48v0WCLzoMszdKvupIrMzXqF37mWbkkPrXbxzTu7zN4r3OTksusadozSdwgVxYZ8flatVpFwdntFP-7-Q8SsMQKjDJSoq_K3g_nMTDcVXI45fRiR7fTu_Xf0pN9WX6k',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCQcpT-DWz3pj2RjZAHEIJ_jdLkW35Y4LTSQBRuJB0R2FYbX0E49CRJY8rSDSIidxDVooqqFy3OmTAct3QGNf33MCNBcRQSBi-K3rPUbBUe4AMkkj8vMiO-tcWQc4G_vQStpheSV5_NeuvrRr4bg2l4gL9GtNnokLkQs5fUPEOe0OeHjscyilvnsLKQ8mtkKgMGM43JnqvcR96c3u_DVtXd1XGdRlZBJnPNqXJeloL6yedXKazRRRj268SCBk7doMmTLOuHJl41W2I',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAiDtXDeqy4dyOHfaGsSExoqB30G9El5RSlPSoHYL8LQrAs-ojd_nXWhmIDhApQcAdsEQZaY8RrNWjkaeii9o1ZbavTMt8TOtSoYPbSQPSOg7sh1IWEg_Koywx2r0iUBM9evWE-90ToK4tAGhJzvU6DwczTptC-kCsCOUFNcj4dArDB0Vq7qnXdCqAHW59foclC0Z95ghOyXslRF9Bx6aeZPziql14ziMYE1NN9IQe7erVsmHLOGe52s7hEeCMknpXtMDazHEmXJ1k',
      ],
      features: [
        'Majlis',
        'Reflecting Pool',
        'Carved Stone Facades',
        'Central Courtyard',
        'Smart Home Ready',
      ],
    ),
    PortfolioItemResponseModel(
      id: 'glass_villa',
      style: 'Modernism',
      category: 'modern',
      title: 'Glass Villa',
      location: 'Khobar',
      area: '380 sqm',
      floors: '2 Floors',
      narrative:
          'A minimalist glass and steel villa where interior space dissolves into the surrounding landscape. Floor-to-ceiling glazing on all primary elevations captures the horizon at every moment of the day.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDs86ukcNSgT6YjaCHXIqqQKwqshqFQ0Kg6eJwcJ6X_j5dU84cc_NNlj4phD3fHKqSyctyQK5Q5tjaHC7gBr6p6l7EOjLSTBRFLAvLcWX6IJ_MBMLfrG8-iMCxukKPuRBZNHggSTkltCUdPCePjWp5HMv6nhG_RP6Pp14Lb_2gZl13WuMybXohXVUEsvgkwuQdTVw4t4efI-86hK9iQ2cqf7yUoxucei_mjGtTCObKZFja88hIsmriE_Gbm7aOVk28FBftwnNXruaE',
      ],
      features: [
        'Floor-to-Ceiling Glazing',
        'Infinity Pool',
        'Open Plan Living',
        'Solar Canopy',
      ],
    ),
    PortfolioItemResponseModel(
      id: 'al_omran',
      style: 'Traditional',
      category: 'traditional',
      title: 'Al-Omran',
      location: 'Diriyah',
      area: '520 sqm',
      floors: '3 Floors',
      narrative:
          'Rooted in the heritage of Najdi architecture, this residence uses rammed-earth walls and wind-catcher towers to create a home that breathes with the desert rather than against it.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDto-w6kvwsI101UCMMIFGL9Z4Z4om0E5-s8fcgHqHP0GgBxDAfF7m9JpGOvhpaZTVcUouOgdEGrVjbK9Xni9B_sT11-_2sAtokJJaIpAwS727ek6d5MymD_ZBTi2gJny_5hXIoUEhkUcVqSEYRP7k8KPhin7rEQi34zaspyQuPh2-5hVgdOz0XTrdSf5M-H4Q5ZEHKP1CYknhuettYTCaoZbN4ivNFZD9W5FaWDCIh1fbof9KdxNzz6Ir0LXbnmUqajZV3qE8HyuU',
      ],
      features: [
        'Rammed-Earth Walls',
        'Wind-Catcher Towers',
        'Shaded Courtyard',
        'Traditional Mashrabiya',
      ],
    ),
    PortfolioItemResponseModel(
      id: 'the_majlis',
      style: 'Interior',
      category: 'interior',
      title: 'The Majlis',
      location: 'Riyadh',
      area: '210 sqm',
      floors: '1 Floor',
      narrative:
          'A dedicated reception majlis conceived as a theatre of hospitality. Arched niches, hand-painted plaster ceilings, and layered textiles create an environment that honours guests with quiet grandeur.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCL3hMUFQKigsK2NjEQmac2mm2U1b28oQFOpdaYAWTN97bZrdQNBVPjzLhajNtLQav7gTgq4g6jj5uGBFLoBRwGkS5Ou-imElEjncF5ajr23dHQfaCj4R13eg2gefMm1-nhlQd7y2A1SLkkj9WeYhkBxm71-zkS2I2Ho6ESgnBG26e9-03QhJtaALvra1ribj4b95DHelKa36Y5ukLgc8iUuJDpDLESB39W9bTlcmj1gL2ZTDx5ma0T47uelGynbHiGjptRFKqJDz0',
      ],
      features: [
        'Arched Niches',
        'Hand-Painted Ceilings',
        'Custom Textiles',
        'Ambient Lighting',
      ],
    ),
    PortfolioItemResponseModel(
      id: 'desert_pavilion',
      style: 'Exterior',
      category: 'exterior',
      title: 'Desert Pavilion',
      location: 'AlUla',
      area: '290 sqm',
      floors: '1 Floor',
      narrative:
          'A single-storey pavilion that rises from the sandstone landscape of AlUla. Long horizontal lines echo the plateau horizons, and deep overhangs shield interior spaces from the full intensity of the desert sun.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAD_YC3-NAPtdaYzhVv8kQZVATUQE1Zy-FIvyG3ErZoYsCLOCparvVZou_hv56ikseYcpHBOC1Ajry47VDgh7Kh7qSjGG5vsQXI0Vddb8k3Ujllkc7BZBqkv80M-9Y9iL5ezJOd1MBdOG6SbSKrD6snlb-_oxhcnIhY4sEjb6kfyU12JCvHzMKTQUxroumDOa7C8UzmGuYk2Hxr3CDJatGibZpJWJPLJ7KS8UBFRWa_nHHWYo2VEd3_i78Y70mQ0q-8jNVDmtHAOsg',
      ],
      features: [
        'Deep Overhangs',
        'Sandstone Palette',
        'Open Terrace',
        'Passive Cooling',
      ],
    ),
  ];

  @override
  Future<Result<List<PortfolioItemResponseModel>>> getPortfolioItems() async {
    if (shouldThrow(MockRepositoryKey.portfolio)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.portfolio)) {
      return const Success([]);
    }

    return Success(_mockItems);
  }

  @override
  Future<Result<PortfolioItemResponseModel>> getPortfolioItemByID(
    GetPortfolioItemRequestModel request,
  ) async {
    if (shouldThrow(MockRepositoryKey.portfolio)) return mockError();
    await simulateDelay();
    final item = _mockItems.firstWhere(
      (p) => p.id == request.id,
      orElse: () => _mockItems.first,
    );
    return Success(item);
  }
}

class MockDeliverablesRepo extends _MockBase implements BaseDeliverablesRepo {
  @override
  Future<Result<DeliverablesResponseModel>> getDeliverables() async {
    if (shouldThrow(MockRepositoryKey.deliverables)) return mockError();

    await simulateDelay();

    if (isEmpty(MockRepositoryKey.deliverables)) {
      return const Success(
        DeliverablesResponseModel(
          blueprints: [],
          renders: [],
          walkthroughs: [],
          projectName: '',
          projectThumbnailUrl: '',
          allFilesZipUrl: '',
        ),
      );
    }

    return Success(
      DeliverablesResponseModel(
        projectName: 'AL-RIYADH ESTATE',
        projectThumbnailUrl:
            'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg',
        allFilesZipUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        blueprints: const [
          BlueprintResponseModel(
            title: 'Ground Floor Architectural Plan',
            size: '24.5 MB',
            format: 'PDF',
            urlOrAsset:
                'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
          ),
          BlueprintResponseModel(
            title: 'First Floor & Roof Terrace Plan',
            size: '18.2 MB',
            format: 'PDF',
            urlOrAsset:
                'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
          ),
          BlueprintResponseModel(
            title: 'Structural Foundation & MEP Layout',
            size: '31.0 MB',
            format: 'PDF',
            urlOrAsset:
                'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
          ),
        ],
        renders: [
          RenderResponseModel(
            imageAsset: Resources.drawables.img1,
            resolution: '4K UHD',
          ),
          RenderResponseModel(
            imageAsset: Resources.drawables.img2,
            resolution: '4K UHD',
          ),
          RenderResponseModel(
            imageAsset: Resources.drawables.design1,
            resolution: '4K UHD',
          ),
        ],
        walkthroughs: [
          WalkthroughResponseModel(
            thumbnailImageUrl: Resources.drawables.img1,
            title: 'Walkthrough v1.2 — Full Interior Tour',
            duration: '02:45 m',
            size: '124 MB',
            format: 'MP4',
            quality: '4K',
            videoUrl: 'https://samplelib.com/mp4/sample-5s.mp4',
            description:
                'Experience the seamless architectural flow of the Al-Rashidi estate. This updated render captures the intricate interplay of shadow and light across the travertine halls during the golden hour, highlighting the newly integrated water feature and custom millwork.',
          ),
        ],
      ),
    );
  }
}

class MockContactUsRepo extends _MockBase implements BaseContactUsRepo {
  @override
  Future<Result<void>> submitInquiry(SubmitInquiryRequestModel request) async {
    if (shouldThrow(MockRepositoryKey.contactUs)) return mockError();

    await simulateDelay();

    return const Success(null);
  }
}

class MockAppConfigRepo extends _MockBase implements BaseAppConfigRepo {
  AppConfigResponseModel? _cachedConfig = const AppConfigResponseModel(
    minAppVersion: 1,
    termsAndConditionsUrl: 'https://example.com/terms.pdf',
    privacyPolicyUrl: 'https://example.com/privacy',
    cookiePolicyUrl: 'https://example.com/cookies',
  );

  @override
  AppConfigResponseModel? get cachedConfig => _cachedConfig;

  @override
  Future<Result<NetworkResponse<AppConfigResponseModel>>> getAppConfig() async {
    if (shouldThrow(MockRepositoryKey.appConfig)) return mockError();

    await simulateDelay();

    _cachedConfig = const AppConfigResponseModel(
      minAppVersion: 1,
      termsAndConditionsUrl: 'https://example.com/terms.pdf',
      privacyPolicyUrl: 'https://example.com/privacy',
      cookiePolicyUrl: 'https://example.com/cookies',
    );

    return Success(NetworkResponse(isSuccess: true, data: _cachedConfig));
  }

  @override
  Future<Result<NetworkResponse<AppConfigResponseModel>>> getMinAppVersion() =>
      getAppConfig();
}

class MockLocalizationRepo extends _MockBase implements BaseLocalizationRepo {
  @override
  Future<Result<void>> saveLocale(String languageCode) async {
    if (shouldThrow(MockRepositoryKey.localization)) return mockError();

    await simulateDelay();

    return const Success(null);
  }

  @override
  Result<Locale?> getSavedLocale() {
    if (shouldThrow(MockRepositoryKey.localization)) return mockError();

    return const Success(null);
  }

  @override
  Future<Result<void>> clearLocale() async {
    if (shouldThrow(MockRepositoryKey.localization)) return mockError();
    await simulateDelay();
    return const Success(null);
  }
}
