import 'package:flutter_ecommerce_app/views/home.dart';
import 'package:flutter_ecommerce_app/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute =
    RouteMap(routes: {'/': (_) => MaterialPage(child: SignIn())});

    final loggedInRoute =
    RouteMap(routes: {'/': (_) => MaterialPage(child: Home())});
