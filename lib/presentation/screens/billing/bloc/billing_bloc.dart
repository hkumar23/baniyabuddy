import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'billing_event.dart';
part 'billing_state.dart';

class BillingBloc extends Bloc<BillingEvent, BillingState> {
  BillingBloc() : super(BillingInitial()) {
    on<BillingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
