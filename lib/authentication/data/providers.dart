import 'datasource/auth_remote_datasource.dart';
import 'services/dio_auth_network_service.dart';

final authNetworkService = DioAuthNetworkService(
  keyCloakUrl: keycloakUrl ??
      "https://keycloak-staging.battmobility.be/realms/Battmobiel",
  battMobilityUrl: battMobilityUrl ?? "https://api-staging.battmobility.be",
);

String? keycloakUrl;
String? battMobilityUrl;

final authDatasource =
    RemoteAuthenticationDataSource(networkService: authNetworkService);
