import 'dart:io';

import 'package:blog_app/const/colors.dart';
import 'package:blog_app/screens/bottom_bar.dart';
import 'package:blog_app/screens/create_blog_screen.dart';
import 'package:blog_app/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// ignore: library_prefixes
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';

class EditBlogScreen extends StatefulWidget {
  final String blogImgUrl;
  final String title;
  final String body;
  final String authorImg;
  final String authorName;
  final String datePosted;
  final String postId;
  const EditBlogScreen(
      {required this.blogImgUrl,
      required this.title,
      required this.body,
      required this.authorImg,
      required this.authorName,
      required this.datePosted,
      required this.postId,
      Key? key})
      : super(key: key);

  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  bool isUploading = false;
  final firebase = FireBaseApi();
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
    final compressedImageFile = File('$path/img_${widget.postId}.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    setState(() {
      pickedFile = compressedImageFile;
    });
  }

  //Updating Blog Post to firestore;
  updatePost() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String imageUrl = await firebase.uploadImage(pickedFile, widget.postId);

    firebase.updatePost(
        postId: widget.postId,
        title: widget.title,
        body: widget.body,
        // ignore: prefer_if_null_operators
        blogImgUrl: pickedFile == null ? widget.blogImgUrl : imageUrl);
    // firebase.createBlogPost(
    //     postId: postId,
    //     blogImgUrl: imageUrl,
    //     title: titleController.text,
    //     body: bodyController.text);

    // //Disposing controller after send post to firebase
    // titleController.clear();
    // bodyController.clear();
    setState(() {
      isUploading = false;
      //Setting uploaded image back to null
      // pickedFile = null;

      //Creating a new unique postId after sending each blog post to firebase
      widget.postId == const Uuid().v4();
    });
    //Displaying message
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Post Updated Succesfully'),
      duration: Duration(seconds: 3),
    ));
    //Directing user back to the home screen after successful uploading of blog post
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const BottomBarScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.title);
    final bodyController = TextEditingController(text: widget.body);
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
        title: GestureDetector(
          onTap: isUploading ? null : () => updatePost(),
          child: Text(
            'Edit post',
            style: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: const Color(0xFF0A1330),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0, top: 16.0),
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 195.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.blogImgUrl),
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
            // Container(
            //   height: 132.h,
            //   width: 507.w,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage('assets/images/blog_image.png'))),
            //   child: const Center(
            //     child: CircleAvatar(child: Icon(Icons.camera_alt)),
            //   ),
            // ),
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
            const SizedBox(height: 16.0),
            const Divider(),
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
            // Text(
            //   widget.title,
            //   style: TextStyle(
            //     fontFamily: 'Inter',
            //     fontStyle: FontStyle.normal,
            //     fontWeight: FontWeight.w600,
            //     fontSize: 14.sp,
            //     color: const Color(0xFF3C3C3C),
            //   ),
            // ),
            // const SizedBox(height: 16.0),
            // const Divider(),
            // const SizedBox(height: 16.0),
            // Text(
            //   widget.body,
            //   style: TextStyle(
            //     fontFamily: 'Inter',
            //     fontStyle: FontStyle.normal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14.sp,
            //     color: const Color(0xFF3C3C3C),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
