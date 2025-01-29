import 'package:dio/dio.dart';
import 'datasource/auth_remote_datasource.dart';
import 'services/dio_auth_network_service.dart';

final authNetworkService = DioAuthNetworkService(
    service: Dio(BaseOptions(
  baseUrl: "https://keycloak-staging.battmobility.be/auth/realms/Battmobiel",
)));

final authDatasource =
    RemoteAuthenticationDataSource(networkService: authNetworkService);
