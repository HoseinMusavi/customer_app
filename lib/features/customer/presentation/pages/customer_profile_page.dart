// lib/features/customer/presentation/pages/customer_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/customer_entity.dart';
import '../cubit/customer_cubit.dart';
import 'address_list_page.dart'; // ایمپورت صفحه جدید

class CustomerProfilePage extends StatelessWidget {
  const CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('پروفایل من')),
      body: BlocProvider(
        create: (_) => sl<CustomerCubit>()..fetchCustomerDetails(1),
        child: BlocBuilder<CustomerCubit, CustomerState>(
          builder: (context, state) {
            if (state is CustomerLoading || state is CustomerInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomerLoaded) {
              return _buildProfileMenu(context, state.customer);
            } else if (state is CustomerError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context, CustomerEntity customer) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: customer.avatarUrl != null
                    ? NetworkImage(customer.avatarUrl!)
                    : null,
                child: customer.avatarUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 12),
              Text(
                customer.fullName,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                customer.email,
                style: textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        _buildMenuTile(
          context,
          icon: Icons.person_outline,
          title: 'اطلاعات حساب',
          onTap: () {}, // TODO: Navigate to edit profile page
        ),
        _buildMenuTile(
          context,
          icon: Icons.location_on_outlined,
          title: 'آدرس‌های من',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddressListPage(customer: customer),
              ),
            );
          },
        ),
        _buildMenuTile(
          context,
          icon: Icons.history,
          title: 'تاریخچه سفارشات',
          onTap: () {}, // TODO: Navigate to order history page
        ),
        _buildMenuTile(
          context,
          icon: Icons.logout,
          title: 'خروج از حساب',
          color: Colors.red,
          onTap: () {}, // TODO: Implement logout
        ),
      ],
    );
  }

  Widget _buildMenuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final titleColor = color ?? Theme.of(context).textTheme.bodyLarge?.color;
    final iconColor = color ?? Colors.grey[600];

    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: titleColor, fontSize: 16)),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
    );
  }
}
