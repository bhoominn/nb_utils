import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../nb_utils.dart';
import 'chat_gpt_component.dart';
import 'chatgpt_strings.dart';

/// Generates a response using the ChatGPT API based on the provided prompt.
///
/// Parameters:
/// - `prompt`: The input prompt for generating a response.
/// - `shortReply`: If true, it will generate a 1-2 line reply. Default is false.
/// - `testWithoutKey`: If true, it will provide a static test response without using the actual API key. Default is false.
/// - `showDebugLogs`: If true, debug logs will be printed on the debug console. Default is false.
///
/// Returns the generated answer. Throws an error message if the response is empty or an error occurs.
Future<String> generateWithChatGpt(String prompt, {bool shortReply = false, bool testWithoutKey = false, bool showDebugLogs = false}) async {
  if (testWithoutKey) {
    //=========================================For Test Without Api==============================================
    ChatGptAnswerResponseModel gptAnsResModel = ChatGptAnswerResponseModel.fromJson(jsonDecode(jsonEncode({
      "id": "cmpl-6biNrkL5FlEhzIoGojdKPiRG6ZGN3",
      "object": "text_completion",
      "created": 1674446767,
      "model": "text-davinci-002",
      "choices": [
        {"text": "I am ChatGPT, a large language model trained by OpenAI, based on the GPT-3.5 architecture.", "index": 0, "logprobs": null, "finish_reason": "stop"}
      ],
      "usage": {"prompt_tokens": 7, "completion_tokens": 61, "total_tokens": 68}
    })));
    log('GPTANSRESMODEL.VALUE.ID: ${gptAnsResModel.id}');
    log('GPTANSRESMODEL.VALUE.ID: ${gptAnsResModel.choices[0].text}');
    await 3.seconds.delay;
    if (gptAnsResModel.choices.isNotEmpty && gptAnsResModel.choices[0].text.isNotEmpty) {
      return gptAnsResModel.choices[0].text.trim();
    } else {
      throw "No data from chatgpt";
    }
    //=========================================Api==============================================
  } else {
    Map<String, String> header = {'Content-Type': 'application/json', 'Authorization': 'Bearer $chatGptApikey'};

    if (showDebugLogs) log('CHATGPT API HEADER: $header');

    Map jsonBodyData = {"model": 'text-davinci-002', "prompt": "$prompt${shortReply ? ", Please reply in 1-2 line only" : ""}", "temperature": 0.7, "max_tokens": 1600, "top_p": 1, "frequency_penalty": 0, "presence_penalty": 0};

    if (showDebugLogs) log('CHATGPT API JSONBODYDATA: $jsonBodyData');

    if (prompt.isNotEmpty) {
      try {
        var response = await http.post(Uri.parse("https://api.openai.com/v1/completions"), body: json.encode(jsonBodyData), headers: header);

        var jsonResponse = json.decode(response.body);

        if (showDebugLogs) log('getAnswerChatGPTApi JSONRESPONSE: $jsonResponse');

        if (response.statusCode == HttpStatus.ok) {
          ChatGptAnswerResponseModel gptAnsResModel = ChatGptAnswerResponseModel.fromJson(jsonResponse);

          if (showDebugLogs) log('GPTANSRESMODEL.VALUE.ID: ${gptAnsResModel.id}');
          if (showDebugLogs) log('GPTANSRESMODEL.VALUE.ID: ${gptAnsResModel.choices[0].text}');

          if (gptAnsResModel.choices.isNotEmpty && gptAnsResModel.choices[0].text.isNotEmpty) {
            return gptAnsResModel.choices[0].text.trim();
          } else {
            throw GPTModuleStrings.noDataFromChatGPT;
          }
        } else {
          throw "${GPTModuleStrings.errorCode}: ${response.statusCode} ${response.reasonPhrase.validate()}";
        }
      } catch (e) {
        if (showDebugLogs) log('getAnswerChatGPT  E: $e');
        throw "${GPTModuleStrings.chatgptFunctionError}: ${e.toString()}";
      }
    } else {
      throw GPTModuleStrings.pleaseEnterSomeText;
    }
  }
}

class ChatGptAnswerResponseModel {
  ChatGptAnswerResponseModel({
    this.id = '',
    this.object = '',
    this.created = 0,
    this.model = '',
    this.choices = const <Choice>[],
    required this.usage,
    required this.error,
  });

  String id;
  String object;
  int created;
  String model;
  List<Choice> choices;
  Usage usage;
  GptApiError error;

  factory ChatGptAnswerResponseModel.fromJson(Map<String, dynamic> json) => ChatGptAnswerResponseModel(
        id: json["id"] ?? "",
        object: json["object"] ?? "",
        created: json["created"] ?? 0,
        model: json["model"] ?? "",
        choices: json["choices"] != null ? List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))) : [],
        usage: json["usage"] != null ? Usage.fromJson(json["usage"]) : Usage(),
        error: json['error'] is Map ? GptApiError.fromJson(json['error']) : GptApiError(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "usage": usage.toJson(),
        'error': error.toJson(),
      };
}

class Choice {
  Choice({
    required this.text,
    required this.index,
    this.logprobs,
    required this.finishReason,
  });

  String text;
  int index;
  dynamic logprobs;
  String finishReason;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        text: json["text"],
        index: json["index"],
        logprobs: json["logprobs"],
        finishReason: json["finish_reason"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "index": index,
        "logprobs": logprobs,
        "finish_reason": finishReason,
      };
}

class Usage {
  Usage({
    this.promptTokens = 0,
    this.completionTokens = 0,
    this.totalTokens = 0,
  });

  int promptTokens;
  int completionTokens;
  int totalTokens;

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"] ?? 0,
        completionTokens: json["completion_tokens"] ?? 0,
        totalTokens: json["total_tokens"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}

class GptApiError {
  String message;
  String type;
  dynamic param;
  String code;

  GptApiError({
    this.message = "",
    this.type = "",
    this.param,
    this.code = "",
  });

  factory GptApiError.fromJson(Map<String, dynamic> json) {
    return GptApiError(
      message: json['message'] is String ? json['message'] : "",
      type: json['type'] is String ? json['type'] : "",
      param: json['param'],
      code: json['code'] is String ? json['code'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'param': param,
      'code': code,
    };
  }
}

autoTypingView(
  BuildContext context, {
  Color? thinkingColor,
  Widget? loading,
}) {
  return Container(
    width: context.width() * 0.35,
    height: 37,
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 5,
    ),
    decoration: BoxDecoration(color: thinkingColor ?? context.primaryColor, borderRadius: BorderRadius.circular(10), shape: BoxShape.rectangle, boxShadow: [
      BoxShadow(
        color: const Color(0xffE1E1E1),
        blurRadius: MediaQuery.of(context).platformBrightness == Brightness.dark ? 0 : 10,
        offset: MediaQuery.of(context).platformBrightness == Brightness.dark ? const Offset(0, 0) : const Offset(0, 4),
      ),
    ]),
    child: loading ??
        Lottie.asset(
          "assets/lottie/typing.json",
          width: context.width() * 0.35,
          height: 30,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Text(
            GPTModuleStrings.loading,
            style: boldTextStyle(color: white),
          ).paddingSymmetric(horizontal: 8),
        ),
  );
}

extension ChatGptExt on Widget {
  /// Parameters:
  /// - `recentList`: A list of recent responses generated by ChatGPT. Pass an empty list or List<String> to store different responses generated by ChatGPT.
  /// - `onFinish`: A callback function that takes a String parameter, representing the selected response generated by ChatGPT.
  /// - `promptFieldInputDecoration`: Custom input decoration for the prompt field in the chatGpt widget.
  /// - `suffixChatGPTicon`: An optional widget to be displayed as a suffix icon in the ChatGPT input field.
  /// - `loadingChatGPT`: An optional widget to be displayed as a loading indicator during ChatGPT response generation.
  /// - `showDebugLogs`: If true, debug logs will be printed on the debug console. Default is false.
  /// - `shortReply`: If true, it will generate a 1-2 line reply. Default is false.
  /// - `testWithoutKey`: If true, it will provide a static test response without using the actual API key. Default is false.
  Widget chatGpt(
    BuildContext context, {
    required List<String> recentList,
    required Function(String) onFinish,
    InputDecoration? promptFieldInputDecoration,
    bool showDebugLogs = false,
    bool shortReply = false,
    bool testWithoutKey = false,
    Widget? icon,
    Widget? loading,
  }) {
    return Stack(
      children: [
        this,
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(6)), minimumSize: MaterialStatePropertyAll(Size(5, 5)), backgroundColor: MaterialStatePropertyAll(context.primaryColor.withOpacity(0.1))),
            onPressed: () async {
              String? res = await showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
                builder: (_) {
                  return DraggableScrollableSheet(
                    initialChildSize: 1,
                    minChildSize: 1,
                    maxChildSize: 1,
                    builder: (context, scrollController) {
                      return ChatGPTSheetBottomSheet(
                        scrollController: scrollController,
                        recentList: recentList,
                        promptFieldInputDecoration: promptFieldInputDecoration,
                        showDebugLogs: showDebugLogs,
                        shortReply: shortReply,
                        testWithoutKey: testWithoutKey,
                        loading: loading,
                      );
                    },
                  );
                },
              );

              onFinish.call(res.validate());
            },
            icon: icon ??
                Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    "assets/icons/ic_beautify.png",
                    height: 22,
                    width: 22,
                    fit: BoxFit.cover,
                    color: context.primaryColor,
                    errorBuilder: (context, error, stackTrace) => Transform.flip(
                      flipX: true,
                      child: Text(
                        "AI",
                        style: boldTextStyle(color: context.primaryColor, size: 16),
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
