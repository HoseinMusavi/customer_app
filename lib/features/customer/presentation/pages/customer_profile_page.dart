import 'dart:io';

import 'package:customer_app/features/customer/domain/entities/customer_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:customer_app/features/customer/presentation/cubit/customer_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerProfilePage extends StatelessWidget {
  const CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if (state is CustomerError) {
            // Optional: Show a snackbar on error
          }
        },
        builder: (context, state) {
          if (state is CustomerLoading || state is CustomerInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CustomerLoaded) {
            return ProfileView(customer: state.customer);
          }
          // If state is CustomerError, it means profile doesn't exist, show the edit/create form.
          return CreateOrEditProfileForm(
            isEditing: false,
            customer: CustomerEntity(
              id: Supabase.instance.client.auth.currentUser!.id,
              email: Supabase.instance.client.auth.currentUser!.email!,
              fullName: '',
              phone: '',
            ),
          );
        },
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final CustomerEntity customer;
  const ProfileView({required this.customer, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(customer.fullName),
            background:
                customer.avatarUrl != null && customer.avatarUrl!.isNotEmpty
                ? Image.network(customer.avatarUrl!, fit: BoxFit.cover)
                : Container(color: Theme.of(context).primaryColor),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => Supabase.instance.client.auth.signOut(),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: Text(customer.email),
            ),
            ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: Text(customer.phone),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: const Text('آدرس‌های من'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                /* Navigate to address page */
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('تاریخچه سفارشات'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                /* Navigate to order history */
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('ویرایش پروفایل'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CreateOrEditProfileForm(
                        isEditing: true,
                        customer: customer,
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class CreateOrEditProfileForm extends StatefulWidget {
  final bool isEditing;
  final CustomerEntity customer;
  const CreateOrEditProfileForm({
    required this.isEditing,
    required this.customer,
    super.key,
  });

  @override
  State<CreateOrEditProfileForm> createState() =>
      _CreateOrEditProfileFormState();
}

class _CreateOrEditProfileFormState extends State<CreateOrEditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.customer.fullName);
    _phoneController = TextEditingController(text: widget.customer.phone);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context
          .read<CustomerCubit>()
          .saveProfile(
            fullName: _fullNameController.text,
            phone: _phoneController.text,
            imageFile: _imageFile,
          )
          .then((_) {
            if (widget.isEditing && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'ویرایش پروفایل' : 'تکمیل پروفایل'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : (widget.customer.avatarUrl != null &&
                                      widget.customer.avatarUrl!.isNotEmpty
                                  ? NetworkImage(widget.customer.avatarUrl!)
                                  : null)
                              as ImageProvider?,
                    child:
                        _imageFile == null &&
                            (widget.customer.avatarUrl == null ||
                                widget.customer.avatarUrl!.isEmpty)
                        ? const Icon(Icons.person, size: 60)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'نام و نام خانوادگی',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'لطفا نام خود را وارد کنید' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'شماره تلفن'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'لطفا شماره تلفن را وارد کنید' : null,
              ),
              const SizedBox(height: 32),
              BlocBuilder<CustomerCubit, CustomerState>(
                builder: (context, state) {
                  if (state is CustomerUpdating) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('ذخیره تغییرات'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
