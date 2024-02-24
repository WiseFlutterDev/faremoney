import 'package:flutter/material.dart';
import 'package:faremoney/auth/auth_models/register_model.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String? _selectedRole;
  DateTime? _selectedDate;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _matricOrTaxiIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _loading = false; // Added loading state variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: _loading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'Student',
                  child: Text('Student'),
                ),
                DropdownMenuItem(
                  value: 'Driver',
                  child: Text('Driver'),
                ),
              ],
              hint: const Text('Select Role'),
            ),
            const SizedBox(height: 20),
            if (_selectedRole == 'Student')
              TextFormField(
                controller: _matricOrTaxiIDController,
                decoration: const InputDecoration(
                  labelText: 'Matric Number',
                ),
              )
            else if (_selectedRole == 'Driver')
              TextFormField(
                controller: _matricOrTaxiIDController,
                decoration: const InputDecoration(
                  labelText: 'Taxi ID',
                ),
              ),
            const SizedBox(height: 20),
            SizedBox(
              height: 20,
              child: _selectedDate == null
                  ? const Text('Date of Birth')
                  : Text(
                  'Date of Birth: ${_selectedDate!.toString().split(' ')[0]}'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _loading = true; // Show loading indicator
                });
                // Call sign up function
                await _printUserResponses();
                setState(() {
                  _loading = false; // Hide loading indicator
                });
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _printUserResponses() async {
    await signUpUser(
        '${_matricOrTaxiIDController.text}',
        '${_fullNameController.text}',
        '${_emailController.text}',
        '$_selectedRole',
        '${_selectedDate.toString().split(' ')[0]}',
        '',
        1,
        '${_passwordController.text}',
        '${_phoneController.text}');
  }
}
