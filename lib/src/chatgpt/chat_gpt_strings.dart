class ChatGPTModuleStrings {
  late String generateUsingAI;
  late String reGenerate;
  late String generate;
  late String copied;
  late String recent;
  late String doYouWantClearRecent;
  late String yes;
  late String no;
  late String pleaseWaitGeneratingContent;
  late String pleaseEnterTextToGenerate;
  late String writeTextHere;
  late String noDataFromChatGPT;
  late String errorCode;
  late String pleaseEnterSomeText;
  late String chatGPTFunctionError;
  late String loading;

  ChatGPTModuleStrings({
    this.generateUsingAI = 'Generate text using AI',
    this.reGenerate = 'Re-generate',
    this.generate = 'Generate',
    this.copied = 'Copied',
    this.recent = 'Recent',
    this.doYouWantClearRecent = 'Do you want to clear recently used?',
    this.yes = 'Yes',
    this.no = 'No',
    this.pleaseWaitGeneratingContent =
        "Please wait while it's generating content!",
    this.pleaseEnterTextToGenerate =
        'Please enter some text about which type of content you want to generate!',
    this.writeTextHere = 'Write text here...',
    this.noDataFromChatGPT = 'No data from Chat GPT',
    this.errorCode = 'Error Code',
    this.pleaseEnterSomeText = 'Please enter some text',
    this.chatGPTFunctionError = 'Chat GPT function error',
    this.loading = 'Generating...',
  });
}
