import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  File? _imageFile;
  String? _profileImageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _fullNameController.text = userDoc.get('fullName') ?? '';
        _profileImageUrl = userDoc.get('profileImageUrl');
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _updateUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      await FirebaseFirestore.instance
          .collection('users') 
          .doc(user.uid)
          .update({
        'fullName': _fullNameController.text.trim(),
        'profileImageUrl': _profileImageUrl, 
      });

      if (_imageFile != null) {
        String imagePath = 'users/${user.uid}/profile.jpg'; 
        Reference storageReference =
            FirebaseStorage.instance.ref().child(imagePath);
        await storageReference.putFile(_imageFile!);
        _profileImageUrl = await storageReference.getDownloadURL();
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User data updated successfully'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update user data'),
        duration: Duration(seconds: 2),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _changePassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    try {
      await user.updatePassword(_newPasswordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password updated successfully'),
        duration: Duration(seconds: 2),
      ));
      _currentPasswordController.clear();
      _newPasswordController.clear();
    } catch (e) {
      print('Error updating password: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update password'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
              ),
            ),
            SizedBox(height: 16.0),
            _buildProfilePictureUI(),
            SizedBox(height: 16.0),
            Text(
              'Change Password',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                hintText: 'Enter your current password',
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter your new password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _changePassword,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Change Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _updateUserData,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePictureUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Picture',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 50.0,
            backgroundImage: _imageFile != null
                ? FileImage(_imageFile!)
                : (_profileImageUrl != null
                    ? NetworkImage(_profileImageUrl!)
                    : AssetImage('assets/profile.png') as ImageProvider),
          ),
        ),
      ],
    );
  }
}
