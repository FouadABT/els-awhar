import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class GreetingsScreen extends StatefulWidget {
  final Future<void> Function()? onSignOut;
  const GreetingsScreen({super.key, this.onSignOut});

  @override
  State<GreetingsScreen> createState() => _GreetingsScreenState();
}

class _GreetingsScreenState extends State<GreetingsScreen> {
  /// Holds the last result or null if no result exists yet.
  String? _resultMessage;

  /// Holds the last error message that we've received from the server or null
  /// if no error exists yet.
  String? _errorMessage;

  final _textEditingController = TextEditingController();

  /// Calls the `hello` method of the `greeting` endpoint. Will set either the
  /// `_resultMessage` or `_errorMessage` field, depending on if the call
  /// is successful.
  void _callHello() async {
    try {
      final result = await client.greeting.hello(_textEditingController.text);
      setState(() {
        _errorMessage = null;
        _resultMessage = result.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.onSignOut != null) ...[
            Text('demo.you_are_connected'.tr),
            ElevatedButton(
              onPressed: widget.onSignOut,
              child: Text('demo.sign_out'.tr),
            ),
          ],
          const SizedBox(height: 32),
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: 'demo.enter_your_name'.tr),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _callHello,
            child: Text('demo.send_to_server'.tr),
          ),
          const SizedBox(height: 16),
          ResultDisplay(
            resultMessage: _resultMessage,
            errorMessage: _errorMessage,
          ),
        ],
      ),
    );
  }
}

/// ResultDisplays shows the result of the call. Either the returned result
/// from the `example.greeting` endpoint method or an error message.
class ResultDisplay extends StatelessWidget {
  final String? resultMessage;
  final String? errorMessage;

  const ResultDisplay({super.key, this.resultMessage, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    String text;
    Color backgroundColor;
    if (errorMessage != null) {
      backgroundColor = Theme.of(context).colorScheme.errorContainer;
      text = errorMessage!;
    } else if (resultMessage != null) {
      backgroundColor = Theme.of(context).colorScheme.primaryContainer;
      text = resultMessage!;
    } else {
      backgroundColor = Theme.of(context).colorScheme.surfaceContainerHighest;
      text = 'demo.no_response_yet'.tr;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 50),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
