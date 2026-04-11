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
  String selectedRole = 'Role';
  String searchQuery = '';

  static const roles = ['Role', 'admin', 'user', 'manager', 'reviewer'];
  static const primaryColor = Color(0xFF1a3a6b);
  static const borderColor = Color(0xFFE0E0E0);

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

  List<UserManagementModel> _filteredUsers(List<UserManagementModel> users) =>
      users.where((user) {
        final query = searchQuery.toLowerCase();
        final matchSearch =
            user.fullName.toLowerCase().contains(query) ||
            user.email.toLowerCase().contains(query);
        final matchRole =
            selectedRole == 'Role' || user.roles.contains(selectedRole);
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
            const Text(
              'User Management',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1a1a2e),
              ),
            ),
            const SizedBox(height: 16),
            _buildToolbar(),
            const SizedBox(height: 16),
            _buildContent(state),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildSearchField(),
        _buildRoleDropdown(),
        AddUserButton(onPressed: () {}),
      ],
    );
  }

  Widget _buildSearchField() {
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
          border: _outlineBorder(),
          enabledBorder: _outlineBorder(),
          focusedBorder: _outlineBorder(color: primaryColor),
        ),
      ),
    );
  }

  Widget _buildRoleDropdown() {
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

  Widget _buildContent(UsersState state) {
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
            return _buildTable(_filteredUsers(state.users));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildTable(List<UserManagementModel> users) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
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

  OutlineInputBorder _outlineBorder({Color color = const Color(0xFFCCCCCC)}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}
