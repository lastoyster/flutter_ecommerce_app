import 'package:flutter_ecommerce_app/apikeys/apikey.dart';
import 'package:flutter_ecommerce_app/controllers/authcontroller.dart';
import 'package:flutter_ecommerce_app/models/product.dart';
import 'package:flutter_ecommerce_app/models/user.dart';
import 'package:flutter_ecommerce_app/router.dart';
import 'package:flutter_ecommerce_app/services/localservice/productwisahlist.dart';
import 'package:flutter_ecommerce_app/widgets/errortext.dart';
import 'package:flutter_ecommerce_app/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  try{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await ProductWishListRepository.openBox();
  Stripe.publishableKey = APIKey.PUBLISHABLEkEY;
  Stripe.merchantIdentifier="Isheunesu";
  await Stripe.instance.applySettings();
  

  runApp(ProviderScope(child: MyApp()));
  }catch(e){
    runApp(ProviderScope(child: Text(e.toString())));
  }
  
}

class MyApp extends ConsumerWidget {
  UserModel? userModel;
 getData(WidgetRef ref,User data)async{
  userModel=await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
  
  ref.read(userProvider.notifier).update((state) => userModel);
 }
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  return loggedInRoute;
                }
                return loggedOutRoute;
              }),
              routeInformationParser: const RoutemasterParser(),
            ),
        error: (error, stackTrace) => Directionality(
            textDirection: TextDirection.rtl,
            child: ErrorText(error: error.toString())),
        loading: () => const Loader());
  }
}
