import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/ui/auth/view_models/auth_viewmodel.dart';

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(
  AuthViewModel.new,
);
