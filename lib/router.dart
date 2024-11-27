import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/widget/cart_sheets.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/payment-success',
      builder: (context, state) {
        final emailViewModel = Provider.of<UsuarioViewModel>(context, listen: false);
        return CartSideSheet(buyerEmail: emailViewModel.email ?? '');
      },
    )
  ],
);
