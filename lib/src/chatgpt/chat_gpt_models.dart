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
        "choices": choices.map((e) => e.toJson()).toList(),
        "usage": usage.toJson(),
        'error': error.toJson(),
      };
}

class ChatGPTChoiceModel {
  int index;
  ResponseMessage message;
  dynamic logprobs;
  String finishReason;

  ChatGPTChoiceModel({
    this.index = -1,
    required this.message,
    this.logprobs,
    this.finishReason = "",
  });

  factory ChatGPTChoiceModel.fromJson(Map<String, dynamic> json) {
    return ChatGPTChoiceModel(
      index: json['index'] is int ? json['index'] : -1,
      message: json['message'] is Map
          ? ResponseMessage.fromJson(json['message'])
          : ResponseMessage(),
      logprobs: json['logprobs'],
      finishReason:
          json['finish_reason'] is String ? json['finish_reason'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'message': message.toJson(),
      'logprobs': logprobs,
      'finish_reason': finishReason,
    };
  }
}

class ResponseMessage {
  String role;
  String content;

  ResponseMessage({
    this.role = "",
    this.content = "",
  });

  factory ResponseMessage.fromJson(Map<String, dynamic> json) {
    return ResponseMessage(
      role: json['role'] is String ? json['role'] : "",
      content: json['content'] is String ? json['content'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}

class ChatGPTUsageModel {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  ChatGPTUsageModel({
    this.promptTokens = -1,
    this.completionTokens = -1,
    this.totalTokens = -1,
  });

  factory ChatGPTUsageModel.fromJson(Map<String, dynamic> json) {
    return ChatGPTUsageModel(
      promptTokens: json['prompt_tokens'] is int ? json['prompt_tokens'] : -1,
      completionTokens:
          json['completion_tokens'] is int ? json['completion_tokens'] : -1,
      totalTokens: json['total_tokens'] is int ? json['total_tokens'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prompt_tokens': promptTokens,
      'completion_tokens': completionTokens,
      'total_tokens': totalTokens,
    };
  }
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
