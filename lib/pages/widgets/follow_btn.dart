import 'package:flutter/material.dart';

import '../../core/util/constants.dart';
class FollowBtn extends StatelessWidget {
  const FollowBtn({
    required this.isFollow ,
    this.followFunction,
    this.unFollowFunction,
    super.key,
  });
 final bool isFollow ;
 final void Function()? followFunction ;
 final void Function()? unFollowFunction ;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isFollow ? unFollowFunction : followFunction,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(12)),
          backgroundColor: kSecondaryColor,foregroundColor: kOnSecondaryColor),
      child:  Text(
        isFollow ?  'UnFollow' :'Follow',

      ),
    );
  }
}
