import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'documantation_state.dart';

class DocumantationCubit extends Cubit<DocumantationState> {
  DocumantationCubit() : super(DocumantationInitial());
}
