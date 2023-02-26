part of 'member_cubit.dart';

abstract class MemberState extends Equatable {
  const MemberState();
}

class MemberInitial extends MemberState {
  @override
  List<Object> get props => [];
}

class MemberLoaded extends MemberState {
  final List<MemberEntity> mems;

  MemberLoaded({required this.mems});
  @override
  List<Object> get props => [mems];
}

class MemberSuccess extends MemberState {
  @override
  List<Object> get props => [];
}

class MemberFailure extends MemberState {
  @override
  List<Object> get props => [];
}

class MemberLoading extends MemberState {
  @override
  List<Object> get props => [];
}
