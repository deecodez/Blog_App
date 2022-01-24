import 'dart:io';
import 'package:blog_app/const/colors.dart';
import 'package:blog_app/resuable-widgets/custom_button.dart';
import 'package:blog_app/screens/bottom_bar.dart';
import 'package:blog_app/services/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
// ignore: library_prefixes
import 'package:image/image.dart' as Im;

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({Key? key}) : super(key: key);

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final firebase = FireBaseApi();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  bool isUploading = false;
  String postId = const Uuid().v4();
  final user = FirebaseAuth.instance.currentUser!;

  final ImagePicker _picker = ImagePicker();
  File? pickedFile;

  selectFileFromCamera() async {
    Navigator.pop(context);
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 132,
      maxWidth: 327,
    );
    if (image == null) return;
    setState(() {
      pickedFile = File(image.path);
    });
  }

  selectFileFromGallery() async {
    Navigator.pop(context);
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;
    setState(() {
      pickedFile = File(image.path);
    });
  }

  //Compressing Image
  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imageFile = Im.decodeImage(pickedFile!.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    setState(() {
      pickedFile = compressedImageFile;
    });
  }

  //Uploading Blog Post to firestore;
  uploadPost() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String imageUrl = await firebase.uploadImage(pickedFile, postId);
    firebase.createBlogPost(
        postId: postId,
        blogImgUrl: imageUrl,
        title: titleController.text,
        body: bodyController.text);

    //Disposing controller after send post to firebase
    titleController.clear();
    bodyController.clear();
    setState(() {
      isUploading = false;
      //Setting uploaded image back to null
      pickedFile = null;

      //Creating a new unique postId after sending each blog post to firebase
      postId == const Uuid().v4();
    });
    //Displaying message
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Post Uploaded Succesfully'),
      duration: Duration(seconds: 3),
    ));
    //Directing user back to the home screen after successful uploading of blog post
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const BottomBarScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 250,
        toolbarHeight: 50,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 16.0),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColor.primaryColor,
              ),
            ),
          ),
        ),
        title: Text(
          'Create post',
          style: TextStyle(
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: const Color(0xFF0A1330),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0, top: 16.0),
            child: GestureDetector(
              onTap: isUploading ? null : () => uploadPost(),
              // final name = titleController.text;
              // firebase.createUser(name: name);

              child: Text(
                'Save',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
        child: Column(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  height: 132.h,
                  width: 327.w,
                  decoration: pickedFile == null
                      ? const BoxDecoration(
                          color: Color(0xFFEFEFEF),
                        )
                      : BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(pickedFile!.path),
                            ),
                          ),
                        ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SelectFilesDailog(
                                onPressedCamera: selectFileFromCamera,
                                onPressedGallery: selectFileFromGallery,
                              );
                            });
                      },
                      child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 18,
                            color: Color(0xFF1251C4),
                          )),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              cursorColor: const Color(0xFF86828D),
              maxLines: 2,
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF86828D)),
                ),
                isDense: true,
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "Title:",
                contentPadding: EdgeInsets.symmetric(vertical: -3.h),
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF86828D),
                ),
              ),
              onChanged: (val) {},
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              cursorColor: const Color(0xFF86828D),
              // maxLines: 2,
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF86828D)),
                ),
                isDense: true,
                labelText: "Body:",
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF86828D),
                ),
              ),
              onChanged: (val) {},
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectFilesDailog extends StatelessWidget {
  final Function() onPressedCamera;
  final Function() onPressedGallery;
  const SelectFilesDailog(
      {required this.onPressedCamera, required this.onPressedGallery, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Choose a file',
        style: TextStyle(
          fontFamily: 'Inter',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: const Color(0xFF0A1330),
        ),
      ),
      children: [
        SimpleDialogOption(
            child: Text(
              'Photo with Camera',
              style: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: const Color(0xFF0A1330),
              ),
            ),
            onPressed: onPressedCamera),
        SimpleDialogOption(
          child: Text(
            'Photo from Gallery',
            style: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: const Color(0xFF0A1330),
            ),
          ),
          onPressed: onPressedGallery,
        ),
        SimpleDialogOption(
          child: const CustomButton(buttonText: 'Cancel'),
          // const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}


// Center(
            //   child: AspectRatio(
            //     aspectRatio: 16 / 9,
            //     child: Container(
            //       height: 132.h,
            //       width: 327.w,
            //       decoration: pickedFile == null
            //           ? const BoxDecoration(
            //               color: Color(0xFFEFEFEF),
            //             )
            //           : BoxDecoration(
            //               image: DecorationImage(
            //                 fit: BoxFit.cover,
            //                 image: FileImage(
            //                   File(pickedFile!.path),
            //                 ),
            //               ),
            //             ),
            //       child: Center(
            //         child: GestureDetector(
            //           onTap: () {
            //             showDialog(
            //                 context: context,
            //                 builder: (context) {
            //                   return SelectFilesDailog(
            //                     onPressedCamera: selectFileFromCamera,
            //                     onPressedGallery: selectFileFromGallery,
            //                   );
            //                 });
            //           },
            //           child: const CircleAvatar(
            //               radius: 15,
            //               backgroundColor: Colors.white,
            //               child: Icon(
            //                 Icons.camera_alt_outlined,
            //                 size: 18,
            //                 color: Color(0xFF1251C4),
            //               )),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),