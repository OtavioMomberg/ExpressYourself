import 'package:message_app/core/utils/audio_helper.dart';
import 'package:message_app/core/utils/verify_privacy_terms.dart';
import 'package:message_app/core/utils/word_count.dart';

final class HomeDeps._() {
  static final audioService = AudioService.instance();
  static final verifyPrivacy = VerifyPrivacyTerms.instance();
  static final wordCountNotifier = WordCount();
}
