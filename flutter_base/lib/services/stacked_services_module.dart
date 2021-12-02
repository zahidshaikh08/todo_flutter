import 'package:stacked_services/stacked_services.dart';

class StackedServicesModuleImpl {
  static DialogService get dialogService => DialogService();

  static NavigationService get navigationService => NavigationService();

  static SnackbarService get snackbarService => SnackbarService();

  static BottomSheetService get bottomSheetService => BottomSheetService();
}
