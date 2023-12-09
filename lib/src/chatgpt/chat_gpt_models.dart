class ChatGPTAnswerResponseModel {
  ChatGPTAnswerResponseModel({
    this.id = '',
    this.object = '',
    this.created = 0,
    this.model = '',
    this.choices = const <ChatGPTChoiceModel>[],
    required this.usage,
    required this.error,
  });

  String id;
  String object;
  int created;
  String model;
  List<ChatGPTChoiceModel> choices;
  ChatGPTUsageModel usage;
  ChatGPTErrorModel error;

  factory ChatGPTAnswerResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatGPTAnswerResponseModel(
        id: json["id"] ?? "",
        object: json["object"] ?? "",
        created: json["created"] ?? 0,
        model: json["model"] ?? "",
        choices: json["choices"] != null
            ? List<ChatGPTChoiceModel>.from(
                json["choices"].map((x) => ChatGPTChoiceModel.fromJson(x)))
            : [],
        usage: json["usage"] != null
            ? ChatGPTUsageModel.fromJson(json["usage"])
            : ChatGPTUsageModel(),
        error: json['error'] is Map
            ? ChatGPTErrorModel.fromJson(json['error'])
            : ChatGPTErrorModel(),
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

class ChatGPTChoiceModel {
  ChatGPTChoiceModel({
    required this.text,
    required this.index,
    this.logprobs,
    required this.finishReason,
  });

  String text;
  int index;
  dynamic logprobs;
  String finishReason;

  factory ChatGPTChoiceModel.fromJson(Map<String, dynamic> json) =>
      ChatGPTChoiceModel(
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

class ChatGPTUsageModel {
  ChatGPTUsageModel({
    this.promptTokens = 0,
    this.completionTokens = 0,
    this.totalTokens = 0,
  });

  int promptTokens;
  int completionTokens;
  int totalTokens;

  factory ChatGPTUsageModel.fromJson(Map<String, dynamic> json) =>
      ChatGPTUsageModel(
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

class ChatGPTErrorModel {
  String message;
  String type;
  dynamic param;
  String code;

  ChatGPTErrorModel({
    this.message = "",
    this.type = "",
    this.param,
    this.code = "",
  });

  factory ChatGPTErrorModel.fromJson(Map<String, dynamic> json) {
    return ChatGPTErrorModel(
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
