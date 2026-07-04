
import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_state.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/change_photo_sheet.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_error_banner.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_form.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_photo_section.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_submit_button.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({required this.profile, super.key});

  final UserProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(
        authRepo: serviceLocatorInstance<BaseAuthRepo>(),
        imagePicker: serviceLocatorInstance<BaseImagePickerService>(),
        initialProfile: profile,
      ),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;

  @override
  void initState() {
    super.initState();
    final s = context.read<EditProfileCubit>().state;
    _nameController = TextEditingController(text: s.name);
    _emailController = TextEditingController(text: s.email);
    _mobileController = TextEditingController(text: s.mobileNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _onChangePhoto(BuildContext context) async {
    final cubit = context.read<EditProfileCubit>();
    final action = await ChangePhotoSheet.show(context);
    switch (action) {
      case ChangePhotoAction.camera:
        await cubit.pickAvatarFromCamera();
      case ChangePhotoAction.library:
        await cubit.pickAvatarFromGallery();
      case ChangePhotoAction.remove:
        cubit.removeAvatar();
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listenWhen: (p, c) => p.cubitStatus != c.cubitStatus,
      listener: (context, state) {
        if (state.cubitStatus == CubitStatus.success &&
            state.updatedProfile != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.localization.editProfileSuccess),
              backgroundColor: Resources.colors.luxurySuccess,
            ),
          );
          Navigator.of(context).pop(state.updatedProfile);
        } else if (state.cubitStatus == CubitStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.appErrorModel?.message ?? ''),
              backgroundColor: Resources.colors.luxuryError,
            ),
          );
        }
      },
      child: CommonScreen(
        resizeToAvoidBottomInset: false,
        padding: EdgeInsets.zero,
        appBar: AppAuthBrandHeader(
          showBack: true,
          label: context.localization.editProfile,
        ),
        child: Column(
          children: [
            BlocBuilder<EditProfileCubit, EditProfileState>(
              buildWhen: (p, c) => p.showErrorBanner != c.showErrorBanner,
              builder: (context, state) {
                return AnimatedSize(
                  duration: AppDurations.normal,
                  child: state.showErrorBanner
                      ? EditProfileErrorBanner(
                          onDismiss: () =>
                              context.read<EditProfileCubit>().dismissBanner(),
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: Resources.horizontalDims.$20,
                  right: Resources.horizontalDims.$20,
                  top: Resources.verticalDims.$16,
                ),
                child: Column(
                  children: [
                    BlocBuilder<EditProfileCubit, EditProfileState>(
                      buildWhen: (p, c) =>
                          p.avatarPath != c.avatarPath ||
                          p.avatarRemoved != c.avatarRemoved,
                      builder: (context, state) {
                        return EditProfilePhotoSection(
                          avatarUrl: state.avatarRemoved
                              ? null
                              : state.avatarUrl,
                          avatarPath: state.avatarRemoved
                              ? null
                              : state.avatarPath,
                          onChangePhoto: () => _onChangePhoto(context),
                        );
                      },
                    ),
                    SizedBox(height: Resources.verticalDims.$40),
                    EditProfileForm(
                      nameController: _nameController,
                      emailController: _emailController,
                      mobileController: _mobileController,
                    ),
                  ],
                ),
              ),
            ),
            const EditProfileSubmitButton(),
          ],
        ),
      ),
    );
  }
}
