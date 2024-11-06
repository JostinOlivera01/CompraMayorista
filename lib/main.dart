import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test01/business_logic/actions/User_actions/ad_actions.dart';
import 'package:test01/business_logic/actions/User_actions/auth_actions.dart';
import 'package:test01/business_logic/actions/User_actions/group_actions.dart';
import 'package:test01/business_logic/actions/User_actions/mercadoPago_actions.dart';
import 'package:test01/business_logic/actions/User_actions/product_actions.dart';
import 'package:test01/business_logic/actions/User_actions/purchaseOrder_actions.dart';
import 'package:test01/business_logic/actions/User_actions/usuarioStore_actions.dart';
import 'package:test01/business_logic/service/advertisementsService.dart';
import 'package:test01/business_logic/service/authService.dart';
import 'package:test01/business_logic/service/groupService.dart';
import 'package:test01/business_logic/service/mercadoPagoService.dart';
import 'package:test01/business_logic/service/orderService.dart';
import 'package:test01/business_logic/service/productService.dart';
import 'package:test01/business_logic/service/usuarioStoreService.dart';
import 'package:test01/viewmodels/Gruop_viewmodel/Group_viewmodel.dart';
import 'package:test01/viewmodels/Product_viewmodel/Orders_viewmodel.dart';
import 'package:test01/viewmodels/Product_viewmodel/Product_viewmodel.dart';
import 'package:test01/viewmodels/Product_viewmodel/ad_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Admin/admin_home_screen.dart';
import 'package:test01/views/screen/Seller/seller_home__layaouscreen.dart';
import 'views/screen/Buyer/buyer_layout_screen.dart';
import 'views/screen/Authorization/login_screen.dart';
import 'views/screen/Authorization/register_screen.dart';
import 'views/screen/Authorization/inicio_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AuthService()),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(AuthUseCase(context.read<AuthService>())),
        ),
        ChangeNotifierProvider(
          create: (_) => UsuarioViewModel(UsuarioCaseStore(UsuarioStoreService())),
        ),
         ChangeNotifierProvider(
          create: (_) => ProductViewModel(ProductActions(ProductStoreService()))
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersViewmodel(OrderActions(OrderStoreService()),OrderPaymentAction(MercadoPagoService())),
        ),
        Provider<MercadoPagoService>(
          create: (_) => MercadoPagoService(),
        ),
        ChangeNotifierProvider(
          create: (_) => GroupViewModel(GroupActions(GroupService()))
          ),
        ChangeNotifierProvider(
          create: (_) => AdvertisementViewModel(AdvertisementActions(AdvertisementService()))
          ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
final String? role; // Agregar un parámetro de rol

  const MyApp({super.key, this.role}); // Constructor para recibir el rol

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/buyerHome',
      routes: {
        '/': (context) => InicioScreen(), // Pantalla inicial según el rol
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/buyerHome': (context) => MyHomePage(),
        '/adminHome': (context) => AdminHomeScreen(),
        '/sellerHome': (context) => SellerHomeScreen(),
      },
    );
  }
}

