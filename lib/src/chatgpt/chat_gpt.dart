import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../nb_utils.dart';

/// Generates a response using the ChatGPT API based on the provided prompt.
///
/// Parameters:
/// - `prompt`: The input prompt for generating a response.
/// - `shortReply`: If true, it will generate a 1-2 line reply. Default is false.
/// - `testWithoutKey`: If true, it will provide a static test response without using the actual API key. Default is false.
/// - `forceEnableDebug`: If true, debug logs will be printed on the debug console. Default is false.
///
/// Returns the generated answer. Throws an error message if the response is empty or an error occurs.
Future<String> generateWithChatGPT({
  required String prompt,
  final String promptPrefix = 'Tune this',
  bool shortReply = false,
  bool testWithoutKey = false,
  required ChatGPTModuleStrings gptModuleStrings,
}) async {
  if (testWithoutKey) {
    //=========================================For Test Without Api==============================================
    ChatGPTAnswerResponseModel gptAnsResModel =
        ChatGPTAnswerResponseModel.fromJson(jsonDecode(jsonEncode({
      "id": "cmpl-6biNrkL5FlEhzIoGojdKPiRG6ZGN3",
      "object": "text_completion",
      "created": 1674446767,
      "model": chatGPTConfigGlobal.chatGPTModel,
      "choices": [
        {
          "index": 0,
          "message": {
            "role": "assistant",
            "content":
                "I am ChatGPT, a large language model trained by OpenAI, based on the GPT-4 architecture."
          },
          "logprobs": null,
          "finish_reason": "stop"
        }
      ],
      "usage": {"prompt_tokens": 7, "completion_tokens": 61, "total_tokens": 68}
    })));

    if (forceEnableDebug) {
      log('GPT ANSWER MODEL.VALUE.ID: ${gptAnsResModel.id}');
    }

    await 3.seconds.delay;
    if (gptAnsResModel.choices.isNotEmpty &&
        gptAnsResModel.choices.first.message.content.isNotEmpty) {
      if (forceEnableDebug) {
        log('GPT ANSWER  ${gptAnsResModel.choices.first.message.content}');
      }
      return gptAnsResModel.choices.first.message.content.trim();
    } else {
      throw gptModuleStrings.noDataFromChatGPT;
    }
    //=========================================Api==============================================
  } else {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $chatGPTAPIkey'
    };

    if (forceEnableDebug) log('CHAT GPT API HEADER: $header');

    Map<String, dynamic> jsonBodyData = chatGPTConfigGlobal.request ??
        {
          "model": chatGPTConfigGlobal.chatGPTModel,
          "messages": [
            {
              "role": "system",
              "content": "You are a helpful assistant.",
            },
            {
              "role": "user",
              "content":
                  "$promptPrefix $prompt${shortReply ? ", Please reply in 1-2 line only" : ""}",
            }
          ],
          "temperature": chatGPTConfigGlobal.temperature,
          "max_tokens": chatGPTConfigGlobal.maxTokens,
          "top_p": chatGPTConfigGlobal.topP,
          "frequency_penalty": chatGPTConfigGlobal.frequencyPenalty,
          "presence_penalty": chatGPTConfigGlobal.presencePenalty,
        };

    if (forceEnableDebug) {
      log('CHAT GPT API JSON BODY DATA: ${chatGPTConfigGlobal.request ?? jsonBodyData}');
    }

    if (prompt.isNotEmpty) {
      try {
        var response = await http.post(
            Uri.parse(chatGPTConfigGlobal.chatGPTAPIEndPoint),
            body: json.encode(jsonBodyData),
            headers: header);

        var jsonResponse = json.decode(response.body);

        if (forceEnableDebug) {
          log('getAnswerChatGPTApi JSON RESPONSE: $jsonResponse');
        }

        if (response.statusCode == HttpStatus.ok) {
          ChatGPTAnswerResponseModel gptAnsResModel =
              ChatGPTAnswerResponseModel.fromJson(jsonResponse);

          if (forceEnableDebug) {
            log('GPT ANSWER MODEL.VALUE.ID: ${gptAnsResModel.id}');
          }

          if (gptAnsResModel.choices.isNotEmpty &&
              gptAnsResModel.choices.first.message.content.isNotEmpty) {
            if (forceEnableDebug) {
              log('GPT ANSWER  ${gptAnsResModel.choices.first.message.content}');
            }
            return gptAnsResModel.choices.first.message.content.trim();
          } else {
            throw gptModuleStrings.noDataFromChatGPT;
          }
        } else {
          throw "${gptModuleStrings.errorCode}: ${response.statusCode} ${response.reasonPhrase.validate()}";
        }
      } catch (e) {
        if (forceEnableDebug) log('getAnswerChatGPT  E: $e');
        throw "${gptModuleStrings.chatGPTFunctionError}: ${e.toString()}";
      }
    } else {
      throw gptModuleStrings.pleaseEnterSomeText;
    }
  }
}

/// Parameters:
/// - `recentList`: A list of recent responses generated by ChatGPT. Pass an empty list or List<String> to store different responses generated by ChatGPT.
/// - `onResponse`: A callback function that takes a String parameter, representing the selected response generated by ChatGPT.
/// - `promptFieldInputDecoration`: Custom input decoration for the prompt field in the chatGpt widget.
/// - `loadingChatGPT`: An optional widget to be displayed as a loading indicator during ChatGPT response generation.
/// - `forceEnableDebug`: If true, debug logs will be printed on the debug console. Default is false.
/// - `shortReply`: If true, it will generate a 1-2 line reply. Default is false.
/// - `testWithoutKey`: If true, it will provide a static test response without using the actual API key. Default is false.
class ChatGPTWidget extends StatelessWidget {
  final String initialPrompt;
  final List<String>? recentList;
  final Function(String)? onResponse;
  final InputDecoration? promptFieldInputDecoration;
  final bool shortReply;
  final bool testWithoutKey;
  final Widget? loaderWidget;

  final ChatGPTModuleStrings chatGPTModuleStrings;
  final Widget child;

  ChatGPTWidget({
    this.initialPrompt = '',
    this.recentList,
    this.onResponse,
    this.promptFieldInputDecoration,
    this.shortReply = false,
    this.testWithoutKey = false,
    this.loaderWidget,
    required this.chatGPTModuleStrings,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: child,
      color: context.iconColor,
      onPressed: () async {
        hideKeyboard(context);

        String? res = await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          shape: RoundedRectangleBorder(
            borderRadius: radiusOnly(
              topLeft: defaultRadius,
              topRight: defaultRadius,
            ),
          ),
          builder: (_) {
            return DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.8,
              expand: false,
              maxChildSize: 0.96,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: ChatGPTSheetComponent(
                    scrollController: scrollController,
                    initialPrompt: initialPrompt,
                    recentList: recentList ?? [],
                    promptFieldInputDecoration: promptFieldInputDecoration,
                    shortReply: shortReply,
                    testWithoutKey: testWithoutKey,
                    loaderWidget: loaderWidget,
                    gptModuleStrings: chatGPTModuleStrings,
                  ),
                );
              },
            );
          },
        );

        onResponse?.call(res.validate());
      },
    );
  }
}
