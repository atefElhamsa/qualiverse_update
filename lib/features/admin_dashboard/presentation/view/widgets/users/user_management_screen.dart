import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedRole = 'All';
  String searchQuery = '';

  static const roles = ['All', 'admin', 'user', 'doctor'];

  @override
  void initState() {
    super.initState();
    UsersCubit.get(context).fetchUsers();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<UserManagementModel> filteredUsers(List<UserManagementModel> users) =>
      users.where((user) {
        final query = searchQuery.toLowerCase();
        final matchSearch =
            user.fullName.toLowerCase().contains(query) ||
            user.email.toLowerCase().contains(query);
        final matchRole =
            selectedRole == 'All' || user.roles.contains(selectedRole);
        return matchSearch && matchRole;
      }).toList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) => Container(
        margin: EdgeInsetsDirectional.only(
          start: 50.w,
          end: 30.w,
          bottom: 20.h,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title: 'User Management',
              textStyle: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontSize: 25.sp),
            ),
            const SizedBox(height: 16),
            buildToolbar(),
            const SizedBox(height: 16),
            buildContent(state),
          ],
        ),
      ),
    );
  }

  Widget buildToolbar() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [buildSearchField(), buildRoleDropdown()],
    );
  }

  Widget buildSearchField() {
    return SizedBox(
      width: 180,
      height: 40,
      child: TextField(
        controller: searchController,
        onChanged: (val) => setState(() => searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Search user',
          hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: outlineBorder(),
          enabledBorder: outlineBorder(),
          focusedBorder: outlineBorder(color: AppColors.tooltipBehavior),
        ),
      ),
    );
  }

  Widget buildRoleDropdown() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRole,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
          items: roles
              .map((role) => DropdownMenuItem(value: role, child: Text(role)))
              .toList(),
          onChanged: (val) => setState(() => selectedRole = val!),
        ),
      ),
    );
  }

  Widget buildContent(UsersState state) {
    return BlocListener<UsersCubit, UsersState>(
      listener: (context, state) {
        if (state is ActivateDeactivateUserSuccess) {
          showSnackBar(context, state.message, AppColors.green);
          UsersCubit.get(context).fetchUsers();
        }
        if (state is ActivateDeactivateUserFailure) {
          showSnackBar(context, state.error, AppColors.red);
        }
      },
      child: Builder(
        builder: (context) {
          if (state is UsersLoading || state is ActivateDeactivateUserLoading) {
            return const Center(child: CustomLoading());
          }
          if (state is UsersFailure) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is UsersSuccess) {
            return buildTable(filteredUsers(state.users));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget buildTable(List<UserManagementModel> users) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UserTableHeader(),
          if (users.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No users found',
                style: TextStyle(color: Colors.grey),
              ),
            )
          else
            ...users.asMap().entries.map(
              (entry) => UserTableRow(
                user: entry.value,
                index: entry.key,
                total: users.length,
              ),
            ),
        ],
      ),
    );
  }

  OutlineInputBorder outlineBorder({Color color = const Color(0xFFCCCCCC)}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}
