
import 'package:flutter_ecommerce_app/core/failure.dart';
import 'package:fpdart/fpdart.dart';


typedef FutureEither<T>=Future<Either<Failure,T>>;
typedef FutureVoid=FutureEither<void>;