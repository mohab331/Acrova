import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_state.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/change_photo_sheet.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_form.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_photo_section.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_submit_button.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/helpers/ui_helper.dart';
import 'package:acrova/utils/validation/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({this.args, super.key});

  final EditProfileArgs? args;

  UserProfileModel get profile =>
      args?.profile ?? const UserProfileResponseModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(
        authRepo: serviceLocatorInstance<BaseAuthRepo>(),
        imagePicker: serviceLocatorInstance<BaseImagePickerService>(),
        initialProfile: profile,
      ),
      child: _EditProfileView(args: args),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView({required this.args});
  final EditProfileArgs? args;

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;
  late final TextEditingController _nationalIdController;

  @override
  void initState() {
    super.initState();
    final s = context.read<EditProfileCubit>().state;
    _nameController = TextEditingController(text: s.name);
    _emailController = TextEditingController(text: s.email);
    _mobileController = TextEditingController(text: s.mobileNumber);
    _nationalIdController = TextEditingController(text: s.nationalID);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  Future<void> _onChangePhoto(BuildContext context) async {
    final cubit = context.read<EditProfileCubit>();
    final action = await PickFromSheet.show(context);
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
      listener: _handleEditProfileListener,
      child: CommonScreen(
        bottomNavigationBar: const EditProfileSubmitButton(),
        resizeToAvoidBottomInset: true,
        padding: EdgeInsets.zero,
        appBar: AppAuthBrandHeader(
          showBack: true,
          label: widget.args?.title ?? '',
        ),
        child: Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              left: Resources.horizontalDims.$20,
              right: Resources.horizontalDims.$20,
              top: Resources.verticalDims.$16,
              bottom: Resources.verticalDims.$32,
            ),
            child: Column(
              children: [
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  buildWhen: (p, c) => p.avatarPath != c.avatarPath,
                  builder: (context, state) {
                    return EditProfilePhotoSection(
                      avatarUrl: widget.args?.profile?.avatarUrl,
                      avatarPath: state.avatarPath,
                      onChangePhoto: () => _onChangePhoto(context),
                    );
                  },
                ),
                SizedBox(height: Resources.verticalDims.$40),
                EditProfileForm(
                  nameController: _nameController,
                  emailController: _emailController,
                  mobileController: _mobileController,
                  nationalIDController: _nationalIdController,
                  isMobileReadOnly:
                      widget.args?.profile?.mobileNumber != null &&
                      AppValidators.isValidSaudiPhone(
                        widget.args!.profile!.mobileNumber!.trim(),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleEditProfileListener(
    BuildContext context,
    EditProfileState state,
  ) async {
    if (state.cubitStatus == CubitStatus.success) {
      CustomToastification.success(
        context: context,
        message: context.localization.updatedSuccessfully,
      ).showToast();
      await context.read<AuthCubit>().getUser();
      if (!context.mounted) return;
      final completionRoute = widget.args?.completionRouteName;
      if (completionRoute != null) {
        context.goTo(completionRoute);
      } else {
        context.pop(true);
      }
    }
    if (state.cubitStatus == CubitStatus.error) {
      CustomToastification.error(
        context: context,
        errorModel: state.appErrorModel,
      ).showToast();
    }
  }
}
