var errorMessage = 'Please try again';
var errorSomethingWentWrong = 'Something Went Wrong';
var errorThisFieldRequired = 'This field is required';
var errorInternetNotAvailable = 'Your internet is not working';

var customDialogHeight = 140.0;
var customDialogWidth = 220.0;

const currencyRupee = '₹';
const currencyDollar = '\$';
const currencyEuro = '€';

const MAIL_TO_PREFIX = 'mailto:';
const TEL_PREFIX = 'tel:';

const playStoreBaseURL = 'https://play.google.com/store/apps/details?id=';
const appStoreBaseURL = 'https://apps.apple.com/in/app/';
const facebookBaseURL = 'https://www.facebook.com/';
const instagramBaseURL = 'https://www.instagram.com/';
const linkedinBaseURL = 'https://www.linkedin.com/in/';
const twitterBaseURL = 'https://twitter.com/';
const youtubeBaseURL = 'https://www.youtube.com/';
const redditBaseURL = 'https://reddit.com/r/';
const telegramBaseURL = 'https://t.me/';
const facebookMessengerURL = 'https://m.me/';
const whatsappURL = 'https://wa.me/';
const googleDriveURL = 'https://docs.google.com/viewer?url=';

const SELECTED_LANGUAGE_CODE = 'selected_language_code';
const THEME_MODE_INDEX = 'theme_mode_index';

const spacingControlHalf = 2;
const spacingControl = 4;
const spacingStandard = 8;
const spacingStandardNew = 16;
const spacingMedium = 20;
const spacingLarge = 26;
const spacingXL = 30;
const spacingXXL = 34;

//region Chat GPT Config
class ChatGPTConfig {
  String chatGPTAPIEndPoint;
  num temperature;
  num maxTokens;
  int topP;
  int frequencyPenalty;
  int presencePenalty;
  String chatGPTModel;
  Map<String, dynamic>? request;

  ChatGPTConfig({
    this.chatGPTAPIEndPoint = 'https://api.openai.com/v1/chat/completions',
    this.temperature = 1,
    this.maxTokens = 1600,
    this.topP = 1,
    this.frequencyPenalty = 0,
    this.presencePenalty = 0,
    this.chatGPTModel = 'gpt-4',
    this.request,
  });
}
//endregion
