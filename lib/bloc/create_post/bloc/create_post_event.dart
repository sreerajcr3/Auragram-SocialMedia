part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostEvent {}

class Createpost extends CreatePostEvent {
  final List<AssetEntity> selectedAssetList;
  final String description;
  final String location;
 


  Createpost({required this.selectedAssetList, required this.description, required this.location });}


