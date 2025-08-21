/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../provider/provider_widget.dart';
import '../utils/application.dart';
import '../utils/helper.dart';
import '../viewmodel/user_friend_model.dart';

class AuthorSubWidget extends StatelessWidget {
  final User? user;

  const AuthorSubWidget({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return SizedBox.shrink();
    }

    return ProviderWidget<UserFriendModel>(
      provider: userFriendProvider,
      onModelReady: (model) => model.haveSub(user!.id),
      builder: (context, model, ref, child) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
          child: Row(
            children: [
              user!.avatar!.trim().isNotEmpty
                  ? CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider("${user!.avatar}"),
                      backgroundColor: Colors.red,
                      radius: 40.w,
                    )
                  : CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/no-avatar.jpg",
                      ),
                      backgroundColor: Colors.red,
                      radius: 40.w,
                    ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Helper.emptyValue(user!.username) ? '' : user!.username,
                        style: TextStyle(
                            fontSize: 32.w, fontWeight: FontWeight.w500),
                      ),
                      user!.intro != ''
                          ? Text(
                              Helper.emptyValue(user!.intro)
                                  ? ''
                                  : user!.intro!,
                              style: TextStyle(
                                  fontSize: 30.w,
                                  color: Theme.of(context).hintColor),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () => model.subToggle(user!.id),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(100.w, 60.w)),
                ),
                child: Text(model.haveSubed ? '已关注' : "关注",
                    style: TextStyle(fontSize: 30.w, color: Colors.red)),
              )
            ],
          ),
        );
      },
    );
  }
}
