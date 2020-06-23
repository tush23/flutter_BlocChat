import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutterchatdemo/search/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent extends Equatable{
  @override
  List<Object> get props => null; 
  
}

class SearchBtnEvent extends SearchEvent {
  final String query;
  SearchBtnEvent({this.query}); 
  
}
class SearchMsgBtnPressedEvent extends SearchEvent{final String userName;

  SearchMsgBtnPressedEvent({this.userName});
}
