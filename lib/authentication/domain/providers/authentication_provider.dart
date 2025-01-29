import 'package:dart_auth/authentication/data/data.dart';

final authenticationRepository =
    AuthRepositoryImpl(authenticationDataSource: authDatasource);
