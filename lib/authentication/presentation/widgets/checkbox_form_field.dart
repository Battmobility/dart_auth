import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {super.key,
      Widget? title,
      String? errorMessage,
      super.onSaved,
      super.validator,
      bool super.initialValue = false,
      bool autovalidate = false})
      : super(builder: (FormFieldState<bool> state) {
          return CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: state.hasError,
            title: title,
            value: state.value,
            onChanged: state.didChange,
            subtitle: state.hasError
                ? Builder(
                    builder: (BuildContext context) => Text(
                      errorMessage ?? state.errorText ?? "",
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  )
                : null,
            controlAffinity: ListTileControlAffinity.leading,
          );
        });
}
