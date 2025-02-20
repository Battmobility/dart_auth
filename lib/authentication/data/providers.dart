import 'package:dio/dio.dart';
import 'datasource/auth_remote_datasource.dart';
import 'services/dio_auth_network_service.dart';

final authNetworkService = DioAuthNetworkService(
  keycloakService: Dio(
    BaseOptions(
      baseUrl: "https://keycloak-staging.battmobility.be/realms/Battmobiel",
    ),
  ),
  battService: Dio(
    BaseOptions(
      baseUrl: "https://api-staging.battmobility.be",
    ),
  ),
);

final authDatasource =
    RemoteAuthenticationDataSource(networkService: authNetworkService);
