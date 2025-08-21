/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_cropping/image_cropping.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/provider_widget.dart';
import '../utils/application.dart';
import '../viewmodel/user_model.dart';

class UserAccountAvatarPage extends StatefulWidget {
  const UserAccountAvatarPage({super.key});

  @override
  createState() => _UserAccountAvatarPageState();
}

class _UserAccountAvatarPageState extends State<UserAccountAvatarPage> {
  /// set the images bytes
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print('WidgetsBinding');
      _openImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('build');
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: ProviderWidget<UserModel>(
          provider: userProvider,
          builder: (context, model, ref, child) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: imageBytes == null
                      ? Center(child: CircularProgressIndicator())
                      : Image.memory(imageBytes!),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  alignment: AlignmentDirectional.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          '取消',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                        onPressed: () => context.pop(),
                      ),
                      TextButton(
                        child: Text(
                          '确定',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (imageBytes?.isEmpty ?? true) {
                            BotToast.showSimpleNotification(title: '请选择文件');
                            return;
                          }
                          File file = await File(
                                  '${Application.tempDir.path}/avatar.png')
                              .create();
                          file.writeAsBytesSync(imageBytes!);
                          model.uploadAvatar(file.path);
                          if (!mounted) return;
                          context.pop();
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _openImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, //图片压缩 推荐鲁班压缩插件
        maxHeight: 600,
        maxWidth: 900);

    imageBytes = await pickedFile?.readAsBytes();
    if (!mounted) return;
    if (imageBytes != null) {
      ImageCropping.cropImage(
        context: context,
        imageBytes: imageBytes!,
        onImageDoneListener: (data) {
          setState(() {
            imageBytes = data;
          });
        },
        customAspectRatios: [
          CropAspectRatio(
            ratioX: 9,
            ratioY: 16,
          ),
        ],
        onImageStartLoading: () {},
        onImageEndLoading: () {},
        selectedImageRatio: CropAspectRatio.fromRation(ImageRatio.RATIO_1_1),
        visibleOtherAspectRatios: false,
        squareBorderWidth: 2,
        isConstrain: false,
        makeDarkerOutside: true,
      );
    }
  }
}
