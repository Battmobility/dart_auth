import 'dart:convert';
import 'package:flutter/material.dart';

class ApiException implements Exception {
  final String message;
  final int statusCode;
  final String identifier;
  final String? debugKey;

  ApiException({
    required this.message,
    required this.statusCode,
    required this.identifier,
    this.debugKey,
  });

  @override
  String toString() {
    return 'statusCode=$statusCode\nmessage=$message\nidentifier=$identifier';
  }

  /// Get localized message for the exception, falling back to the user-friendly message if no translation exists
  String getLocalizedMessage(BuildContext context) {
    if (debugKey == null) {
      return message;
    }

    try {
      // Try to get localized message using debugKey as a dynamic key
      // This would require adding error keys to your .arb files
      // For now, we'll check if a method exists for this specific debugKey
      switch (debugKey) {
        case 'resource-exists':
          // If you add this key to your .arb files, uncomment:
          // return l10n.errorResourceExistsVehicleNotAvailable
          // todo loc
          return 'Er bestaat al een account met dit emailadres.';
        // Add more cases as needed
      }
    } catch (e) {
      // If localization fails, fall through to user-friendly message
    }

    // Fallback to the user-friendly formatted message
    return message;
  }

  factory ApiException.unknown() {
    return ApiException(
        message: "An unknown API exception occurred",
        statusCode: 0,
        identifier: "unknown_api_exception");
  }

  factory ApiException.fromJson({
    required String? jsonString,
    required int statusCode,
  }) {
    if (jsonString == null || jsonString.isEmpty) {
      return ApiException(
        message: "Unknown error occurred",
        statusCode: statusCode,
        identifier: "api_exception_empty_response_$statusCode",
      );
    }

    try {
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Extract debug information
      final String? translatedMsg = json['translatedMsg'];
      final String? debugMsg = json['debugMsg'];
      final List<dynamic>? debugParameters = json['debugParameters'];
      final String? debugKey = json['debugKey'];

      if (debugMsg != null) {
        // Create user-friendly message by replacing underscores and capitalizing
        final userMessage = translatedMsg ??
            debugMsg
                .replaceAll('-', ' ')
                .replaceAll('_', ' ')
                .split(' ')
                .map((word) => word.isEmpty
                    ? ''
                    : word[0].toUpperCase() + word.substring(1).toLowerCase())
                .join(' ');

        // Create detailed identifier with all debug info
        final identifierParts = <String>[
          debugKey ?? debugMsg,
          if (debugParameters != null) debugParameters.toString(),
        ];

        return ApiException(
          message: userMessage,
          statusCode: statusCode,
          identifier: identifierParts.join('_'),
          debugKey: debugKey,
        );
      }
    } catch (e) {
      // If JSON parsing fails, fall through to default handling
    }

    // Fallback to original behavior
    return ApiException(
      message: jsonString,
      statusCode: statusCode,
      identifier: "api_exception_${jsonString}_$statusCode",
    );
  }
}
