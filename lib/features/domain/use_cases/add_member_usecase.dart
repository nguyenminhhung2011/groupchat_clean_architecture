import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/group_entity.dart';

import '../repositories/api_respositoy.dart';

class AddMemberUseCase {
  final ApiRespository respository;
  AddMemberUseCase({required this.respository});
  Future<void> call(String uid, GroupEntity group) {
    return respository.addMemberToGroup(uid, group);
  }
}
