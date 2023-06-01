import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/domain/entities/local_user_model.dart';
import '../../application/post_bloc/post_bloc.dart';
import '../../infrastructure/data_providers/upload_image.dart';
import '../routes/app_route_constants.dart';

class AddPostWidget extends StatefulWidget {
  final LocalUserModel localUserModel;
  const AddPostWidget({super.key, required this.localUserModel});

  @override
  State<AddPostWidget> createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends State<AddPostWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _postImageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostOperationSuccess) {
          GoRouter.of(context)
              .pushReplacementNamed(MyAppRouteConstants.homeRouteName);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("post created successfully!"),
            ),
          );
        } else if (state is PostOperationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("something went wrong, please try again!"),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 7.0),
              const TextButton(
                onPressed: null,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Title",
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      size: 40,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () async {
                  setState(() async {
                    _postImageUrl = await UploadImage.pickImage();
                  });
                },
                child: const Text('Add Photo'),
              ),
              const Padding(
                padding: EdgeInsets.all(25),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      BlocProvider.of<PostBloc>(context).add(PostCreateEvent(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          author: widget.localUserModel.username,
                          authorName: widget.localUserModel.name,
                          authorAvatar: widget.localUserModel.imageUrl,
                          sourceUrl: _postImageUrl!));
                    }
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
