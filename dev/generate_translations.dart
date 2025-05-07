import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

// List of language codes to generate translations for - Fixed zh-CN naming
const List<String> languageCodes = [
  'en-US',
  'ar-SA',
  'fr-FR',
  'de-DE',
];

// Base path where translation files are stored
const String translationsFolder = '../assets/translations';

// Path to the app strings file (relative to the script location in dev folder)
const String appStringsPath = '../lib/core/constants/app_strings.dart';

// Class to track failed translations
class FailedTranslation {
  final String key;
  final String langCode;
  final String error;

  FailedTranslation(this.key, this.langCode, this.error);

  @override
  String toString() => 'Key: "$key", Language: $langCode, Error: $error';
}

// Time tracking class
class TimeTracker {
  final DateTime startTime;
  final int totalKeys;
  int processedKeys = 0;
  int processedTranslations = 0;
  int totalTranslations = 0;

  // Track API-only durations (without delays)
  final List<Duration> apiCallDurations = [];

  // Track total durations (including delays)
  final List<Duration> totalDurations = [];

  // Track time per complete key
  final List<Duration> keyProcessingDurations = [];
  Stopwatch? currentKeyStopwatch;

  TimeTracker({required this.totalKeys})
      : startTime = DateTime.now(),
        totalTranslations = totalKeys * (languageCodes.length - 1); // Exclude English

  void addApiCallDuration(Duration duration) {
    apiCallDurations.add(duration);
  }

  void addTotalDuration(Duration duration) {
    totalDurations.add(duration);
  }

  // Start timing a new key
  void startKeyTiming() {
    currentKeyStopwatch = Stopwatch()..start();
  }

  // Stop timing the current key and record its duration
  void finishKeyTiming() {
    if (currentKeyStopwatch != null) {
      final elapsed = currentKeyStopwatch!.elapsed;
      print("DEBUG: Key took ${elapsed.inSeconds} seconds to process completely");
      keyProcessingDurations.add(elapsed);
      currentKeyStopwatch = null;
    }
  }

  Duration get averageApiCallDuration {
    if (apiCallDurations.isEmpty) return Duration.zero;

    int totalMilliseconds = apiCallDurations.fold(0, (sum, duration) => sum + duration.inMilliseconds);
    return Duration(milliseconds: (totalMilliseconds / apiCallDurations.length).ceil());
  }

  Duration get averageTotalDuration {
    if (totalDurations.isEmpty) return Duration.zero;

    int totalMilliseconds = totalDurations.fold(0, (sum, duration) => sum + duration.inMilliseconds);
    return Duration(milliseconds: (totalMilliseconds / totalDurations.length).ceil());
  }

  Duration get averageTimePerKey {
    if (keyProcessingDurations.isEmpty) return Duration.zero;

    int totalMilliseconds = 0;
    for (var duration in keyProcessingDurations) {
      totalMilliseconds += duration.inMilliseconds;
    }

    // Add debug output to see what's happening
    print("DEBUG: Total key duration: ${totalMilliseconds}ms for ${keyProcessingDurations.length} keys");

    return Duration(milliseconds: totalMilliseconds ~/ keyProcessingDurations.length);
  }

  Duration get estimatedRemainingTime {
    if (processedKeys == 0) return Duration(minutes: 1); // Initial estimate

    // Calculate based on average time per complete key
    final remainingKeys = totalKeys - processedKeys;

    // Create a new duration with the proper calculation
    final avgMillisPerKey = averageTimePerKey.inMilliseconds;
    return Duration(milliseconds: avgMillisPerKey * remainingKeys);
  }

  String get progressReport {
    final elapsedTime = DateTime.now().difference(startTime);

    // Calculate time per key based on actual elapsed time
    final timePerKeyActual = processedKeys > 0
        ? Duration(milliseconds: elapsedTime.inMilliseconds ~/ processedKeys)
        : Duration(seconds: 15); // Default assumption

    // Remaining time based on observed performance
    final remainingKeys = totalKeys - processedKeys;
    final estimatedRemainingTime = Duration(milliseconds: timePerKeyActual.inMilliseconds * remainingKeys);
    final estimatedRemainingTimeWithDelay = Duration(milliseconds: timePerKeyActual.inMilliseconds * remainingKeys * 3);

    final percentComplete = (processedKeys / totalKeys * 100).toStringAsFixed(1);

    return '\n----- PROGRESS UPDATE -----\n'
        '🔄 ${processedKeys}/${totalKeys} keys (${percentComplete}%)\n'
        '⏱️ Elapsed: ${_formatDuration(elapsedTime)}\n'
        '⏳ Estimated time remaining: ${_formatDuration(estimatedRemainingTime)}  Delay ${_formatDuration(estimatedRemainingTimeWithDelay)}\n'
        '⚡ Avg API call time: ${_formatDuration(averageApiCallDuration)}\n'
        '⏰ Avg time per key: ${_formatDuration(timePerKeyActual)}\n'
        '-------------------------';
  }

  Duration get estimatedRemainingTimeWithoutDelays {
    if (processedKeys == 0) return Duration(minutes: 1);

    // Base the calculation on average API call time
    final remainingKeys = totalKeys - processedKeys;
    final remainingTranslations = remainingKeys * (languageCodes.length - 1);

    // Average pure API time per translation
    final avgApiTimePerTranslation = averageApiCallDuration.inMilliseconds;

    return Duration(milliseconds: avgApiTimePerTranslation * remainingTranslations);
  }

  Duration get estimatedRemainingTimeWithDelays {
    if (processedKeys == 0) return Duration(minutes: 1);

    // Use the actual measured time per complete key
    final remainingKeys = totalKeys - processedKeys;
    final avgTimePerKey = averageTimePerKey.inMilliseconds;

    if (avgTimePerKey == 0) {
      // Fallback if averageTimePerKey is somehow zero
      return estimatedRemainingTimeWithoutDelays;
    }

    return Duration(milliseconds: avgTimePerKey * remainingKeys);
  }

  void incrementTranslations(int count) {
    processedTranslations += count;
  }

  void incrementKeys() {
    processedKeys++;
  }
}

// Three different translation services to distribute the load
// Keep track of which API is currently working for each language
Map<String, String> currentWorkingApi = {
  'ar-SA': 'MyMemory',
  'es-ES': 'MyMemory',
  'fr-FR': 'LibreTranslate',
  'de-DE': 'LibreTranslate',
  'zh-CN': 'Lingva', // Fixed: Ensure zh-CN is used consistently
};

// Three different translation services with adaptive fallback
Future<String?> translateText(String text, String targetLang, TimeTracker tracker) async {
  final totalStopwatch = Stopwatch()..start();
  final apiStopwatch = Stopwatch();

  try {
    // For English, just return the formatted text
    if (targetLang.startsWith('en')) {
      return text;
    }

    // Ensure we're using the exact language code from our list
    final validLangCode = languageCodes.firstWhere(
      (code) => code.split('-')[0] == targetLang.split('-')[0],
      orElse: () => targetLang,
    );

    await countdown(3);
    apiStopwatch.start();

    String simpleLang = validLangCode.split('-')[0];
    String? translation;

    // Get currently working API for this language
    String currentApi = currentWorkingApi[validLangCode] ?? 'MyMemory';

    // List of APIs in order of preference (will try in this order, starting from current)
    List<String> apiOrder = ['MyMemory', 'LibreTranslate', 'Lingva'];

    // Reorganize the list to start with the current working API
    int currentIndex = apiOrder.indexOf(currentApi);
    if (currentIndex > 0) {
      apiOrder = [...apiOrder.sublist(currentIndex), ...apiOrder.sublist(0, currentIndex)];
    }

    // Try each API in the reorganized order until one works
    for (int i = 0; i < apiOrder.length; i++) {
      String api = apiOrder[i];
      bool isFirstAttempt = i == 0;

      if (!isFirstAttempt) {
        print('   ⚠️ ${apiOrder[i - 1]} failed, trying ${api}...');
      } else {
        print('   => ${api} ($validLangCode)');
      }

      try {
        if (api == 'MyMemory') {
          translation = await translateWithMyMemory(text, simpleLang);
        } else if (api == 'LibreTranslate') {
          translation = await translateWithLibreTranslate(text, simpleLang);
        } else {
          // Lingva
          translation = await translateWithLingva(text, simpleLang);
        }

        if (translation != null) {
          // Update the working API if it changed
          if (currentApi != api) {
            currentWorkingApi[validLangCode] = api;
            print('   ✅ Updated working API for $validLangCode to $api');
          }
          break;
        }
      } catch (e) {
        print('   ❌ $api error: $e');
      }
    }

    apiStopwatch.stop();
    tracker.addApiCallDuration(apiStopwatch.elapsed);

    // If all services failed, use a placeholder
    if (translation == null) {
      translation = "[TRANSLATION PENDING]";
      print('   ❌ All translation services failed for this language');
    }

    totalStopwatch.stop();
    tracker.addTotalDuration(totalStopwatch.elapsed);
    tracker.incrementTranslations(1);

    return translation;
  } catch (e) {
    totalStopwatch.stop();
    if (apiStopwatch.isRunning) apiStopwatch.stop();
    tracker.addTotalDuration(totalStopwatch.elapsed);
    tracker.incrementTranslations(1);
    print('Translation error: $e');
    return "[TRANSLATION PENDING]"; // Ensure we always return something
  }
}

// Helper to try a translation service and handle errors
Future<String?> tryTranslationService(Future<String?> Function() translationFunction, String serviceName) async {
  try {
    return await translationFunction();
  } catch (e) {
    print('   ❌ $serviceName error: $e');
    return null;
  }
}

// MyMemory translation service
Future<String?> translateWithMyMemory(String text, String targetLang) async {
  try {
    String url = 'https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(text)}&langpair=en|${targetLang}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body);
    return data['responseData']['translatedText'];
  } catch (e) {
    print('MyMemory API error: $e');
    return null;
  }
}

// LibreTranslate translation service
Future<String?> translateWithLibreTranslate(String text, String targetLang) async {
  try {
    final url = 'https://libretranslate.com/translate';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'q': text,
        'source': 'en',
        'target': targetLang,
        'format': 'text',
      }),
    );

    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body);
    return data['translatedText'];
  } catch (e) {
    print('LibreTranslate API error: $e');
    return null;
  }
}

// Lingva translation service
Future<String?> translateWithLingva(String text, String targetLang) async {
  try {
    String encodedText = Uri.encodeComponent(text);
    String url = 'https://lingva.ml/api/v1/en/${targetLang}/${encodedText}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body);
    return data['translation'];
  } catch (e) {
    print('Lingva API error: $e');
    return null;
  }
}

// Update your duration formatting function for better readability
String _formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = (duration.inMinutes % 60);
  final seconds = (duration.inSeconds % 60);

  final StringBuffer result = StringBuffer();

  if (hours > 0) {
    result.write('${hours}h ');
  }

  if (hours > 0 || minutes > 0) {
    result.write('${minutes}m ');
  }

  result.write('${seconds}s');

  return result.toString();
}

// Function to preserve capitalization while formatting for translation
String formatForTranslation(String value) {
  // Check if this is a camelCase string that should be formatted
  if (value.startsWith(RegExp(r'[a-z]'))) {
    if (value.contains(RegExp(r'[A-Z]'))) {
      // Multi-word camelCase
      final words = <String>[];
      int startIndex = 0;

      // First word (starts with lowercase)
      for (int i = 1; i < value.length; i++) {
        if (value[i].contains(RegExp(r'[A-Z]'))) {
          words.add(value.substring(startIndex, i));
          startIndex = i;
        }
      }

      // Add the last word
      if (startIndex < value.length) {
        words.add(value.substring(startIndex));
      }

      // Join words with spaces and handle special cases
      final result = words.map((word) {
        // Handle variable X placeholders - convert to {}
        if (word == "X" || word == "x") {
          return "{}";
        }

        if (words.indexOf(word) == 0) {
          // Capitalize first word
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        } else {
          // Keep subsequent words lowercase
          return word.toLowerCase();
        }
      }).join(' ');

      return result;
    } else {
      // Single word - capitalize first letter
      return value[0].toUpperCase() + value.substring(1);
    }
  }

  // If it doesn't match camelCase pattern, return as is
  return value;
}

// Global variable to track delay time
Future<void> countdown(int seconds) async {
  stdout.write('⏱️ Waiting: ');
  for (int i = seconds; i > 0; i--) {
    stdout.write('$i ');
    await Future.delayed(Duration(seconds: 1));
  }
  // stdout.write('\n'); // New line after countdown
}

int currentDelaySeconds = 5;

// Function to load existing translation file or create new one
Future<Map<String, dynamic>> loadTranslationFile(String langCode) async {
  // Ensure we're using the correct language code format
  String normalizedLangCode = langCode;

  // Fix for zh-CN/zh-CH issue
  if (langCode.startsWith('zh')) {
    normalizedLangCode = 'zh-CN';
  }

  final file = File('$translationsFolder/$normalizedLangCode.json');
  if (await file.exists()) {
    final content = await file.readAsString();
    return jsonDecode(content);
  }

  print('   🆕 Creating new translation file for $normalizedLangCode');
  return {};
}

// Function to save translation to file
Future<void> saveTranslationFile(String langCode, Map<String, dynamic> translations) async {
  final directory = Directory(translationsFolder);
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }

  // Fix for zh-CN/zh-CH issue
  String normalizedLangCode = langCode;
  if (langCode.startsWith('zh')) {
    normalizedLangCode = 'zh-CN';
  }

  final file = File('$translationsFolder/$normalizedLangCode.json');

  final encoder = JsonEncoder.withIndent('  ');
  await file.writeAsString(encoder.convert(translations));
}

// Function to make a sample translation to estimate time
Future<void> estimateTranslationTime(TimeTracker tracker) async {
  print('Making a sample translation to estimate timing...');

  const sampleText = 'This is a sample text to estimate translation time';
  const targetLang = 'es-ES';

  // Run a sample translation to calculate average time
  final stopwatch = Stopwatch()..start();
  await translateText(sampleText, targetLang, tracker);
  stopwatch.stop();

  // Calculate the total estimated time
  final avgTimePerKey = stopwatch.elapsed;
  final totalLanguages = languageCodes.length - 1; // Exclude English
  final totalKeys = tracker.totalKeys;
  final estimatedTotalTime = Duration(milliseconds: avgTimePerKey.inMilliseconds * totalKeys);

  print('\n===== TIME ESTIMATE =====');
  print('Sample translation took: ${_formatDuration(avgTimePerKey)}');
  print('Total keys to process: $totalKeys');
  print('Languages to translate to: $totalLanguages');
  print('Estimated total time: ${_formatDuration(estimatedTotalTime)}');
  print('==========================\n');

  print('Initial estimate: ${tracker.progressReport}\n');
}

// New class to store both key and value information
class TranslationEntry {
  final String key;
  final String value;

  TranslationEntry(this.key, this.value);
}

Future<List<FailedTranslation>> addTranslationEntry(TranslationEntry entry, TimeTracker tracker) async {
  final List<FailedTranslation> failures = [];
  final String key = entry.key;
  // Format the value for translation but preserve intentional capitalization
  final String textToTranslate = formatForTranslation(entry.value);

  print('\n📝 Key: "$key" => Value: "${entry.value}" => Formatted: "$textToTranslate"');

  // Start timing this entire key's processing
  tracker.startKeyTiming();

  // Add the English translation right away (using the original value as-is)
// Check if English translation already exists before adding it
  final existingEnglishTranslations = await loadTranslationFile('en-US');
  if (!existingEnglishTranslations.containsKey(key)) {
    // Add the English translation if it doesn't exist (using the original value as-is)
    await saveTranslation('en-US', key, textToTranslate);
    print('   ✓ en-US: Added new translation');
  } else {
    print('   ✓ en-US: Translation already exists');
  }

  // Process other languages
  for (final langCode in languageCodes.where((lc) => !lc.startsWith('en'))) {
    try {
      // Check if translation already exists
      final existingTranslations = await loadTranslationFile(langCode);
      if (existingTranslations.containsKey(key)) {
        print('   ✓ $langCode: Translation already exists');
        continue;
      }

      // Generate translation
      final translation = await translateText(textToTranslate, langCode, tracker);
      if (translation != null) {
        // Save this translation immediately
        await saveTranslation(langCode, key, translation);
        print('   ✓ $langCode: "$translation"');
      } else {
        failures.add(FailedTranslation(key, langCode, 'Translation failed'));
        print('   ❌ $langCode: Translation failed');
      }
    } catch (e) {
      failures.add(FailedTranslation(key, langCode, e.toString()));
      print('   ❌ $langCode: ${e.toString()}');
    }
  }

  // Finish timing this key's processing
  tracker.finishKeyTiming();

  tracker.incrementKeys();
  print(tracker.progressReport);

  return failures;
}

// Helper function to save a single translation
Future<void> saveTranslation(String langCode, String key, String translation) async {
  final translations = await loadTranslationFile(langCode);
  translations[key] = translation;
  await saveTranslationFile(langCode, translations);
}

// Function to process a list of translation entries in sequence
Future<void> processTranslationEntries(List<TranslationEntry> entries) async {
  final List<FailedTranslation> allFailures = [];
  final tracker = TimeTracker(totalKeys: entries.length);

  await estimateTranslationTime(tracker);

  for (final entry in entries) {
    final failures = await addTranslationEntry(entry, tracker);
    allFailures.addAll(failures);

    print(''); // Extra line for readability
  }

  final endTime = DateTime.now();
  final totalDuration = endTime.difference(tracker.startTime);

  print('\n======= TRANSLATION COMPLETED =======');
  print('Total time: ${_formatDuration(totalDuration)}');
  print(
      'Processed: ${tracker.processedKeys}/${tracker.totalKeys} keys, ${tracker.processedTranslations}/${tracker.totalTranslations} translations');

  // Report any failures
  if (allFailures.isNotEmpty) {
    print('\n======= FAILED TRANSLATIONS =======');
    for (final failure in allFailures) {
      print(failure);
    }
    print('==================================');
  }
}

// Improved to strictly identify only strings from the AppStrings class
Future<List<TranslationEntry>> extractTranslationEntries() async {
  // Path to your Translations class file
  final File file = File(appStringsPath);
  if (!await file.exists()) {
    print('ERROR: Could not find app_strings.dart at $appStringsPath');
    print('Make sure you are running the script from the dev folder.');
    exit(1);
  }

  final String content = await file.readAsString();
  print('Loaded app_strings.dart - File size: ${content.length} characters');

  // Find the class definition for AppStrings
  final classRegex = RegExp(r'class\s+AppStrings\s+{([^}]*)}', dotAll: true);
  final classMatch = classRegex.firstMatch(content);

  if (classMatch == null) {
    print('ERROR: Could not find AppStrings class in the file');
    print('Make sure the file contains a class named AppStrings');
    exit(1);
  }

  // Extract only the content inside the AppStrings class
  final classContent = classMatch.group(1)!;
  print('Successfully extracted AppStrings class content - ${classContent.length} characters');

  // Use a more direct line-by-line approach to extract string variables
  final List<TranslationEntry> entries = [];

  // Process the class content line by line
  final List<String> lines = classContent.split('\n');

  print('\nLooking for patterns like:');
  print('  - static const foo = \'value\'');
  print('  - static const String foo = \'value\'');
  print('  - static final foo = \'value\'');
  print('  - static var foo = \'value\'');

  for (final line in lines) {
    final trimmedLine = line.trim();
    // Skip if not a static string declaration
    if (!trimmedLine.startsWith('static const') &&
        !trimmedLine.startsWith('static final') &&
        !trimmedLine.startsWith('static var')) {
      continue;
    }

    // Skip if not a string assignment
    if (!trimmedLine.contains('=') || (!trimmedLine.contains("'") && !trimmedLine.contains('"'))) {
      continue;
    }

    // Extract key (variable name)
    String key = '';
    String value = '';

    try {
      // Split on equals sign
      final parts = trimmedLine.split('=');
      final leftSide = parts[0].trim();
      String rightSide = parts.sublist(1).join('=').trim();

      // Extract the key (variable name)
      // Look for the last word before the equals sign
      final keyRegex = RegExp(r'(\w+)\s*$');
      final keyMatch = keyRegex.firstMatch(leftSide);
      if (keyMatch != null) {
        key = keyMatch.group(1)!;
      } else {
        continue; // Skip if key not found
      }

      // Extract the value (string content)
      // Find the content between quotes (single or double)
      final valueRegex = RegExp('[\'"](.+?)[\'"]');
      final valueMatch = valueRegex.firstMatch(rightSide);
      if (valueMatch != null) {
        value = valueMatch.group(1)!;
      } else {
        continue; // Skip if value not found
      }

      // Add to entries if both key and value were found
      if (key.isNotEmpty && value.isNotEmpty) {
        print('Extracted: Key = "$key", Value = "$value"');
        entries.add(TranslationEntry(key, value));
      }
    } catch (e) {
      print('Error parsing line: $trimmedLine');
      print('Error: $e');
    }
  }

  return entries;
}

List<String> identifyKeysWithVariables(List<TranslationEntry> entries) {
  final List<String> keysWithVariables = [];

  for (final entry in entries) {
    final String key = entry.key;
    final String value = entry.value;

    // Check for placeholder indicators in the string value
    if (value.contains('{}') || value.contains('{0}') || value.contains('%s') || value.contains('%d')) {
      keysWithVariables.add(key);
      continue;
    }

    // Also check key names that suggest variables
    // ignore: avoid_single_character_alternation
    if (RegExp(r'[a-z](X|Y|Z)$').hasMatch(key) || // X at the end
        RegExp(r'[a-z](X|Y|Z)(?=[A-Z][a-z])').hasMatch(key)) {
      // X followed by capital+lowercase
      keysWithVariables.add(key);
    }
  }

  return keysWithVariables;
}

Future<void> main(List<String> args) async {
  // Only proceed if explicitly run with arguments
  if (args.isEmpty) {
    print('==== TRANSLATION GENERATOR ====');
    print('Usage:');
    print('  dart run translate.dart start   # Start the translation process');
    print('  dart run translate.dart test    # Run a test on extraction logic');
    print('=============================');
    exit(0);
  }

  final command = args.first.toLowerCase();

  if (command == 'test') {
    // Test the string extraction approach with sample strings
    print('===== TESTING STRING EXTRACTION =====');
    final testStrings = [
      'static const foo = \'foo\';',
      'static const String foo = \'foo\';',
      'static final foo = \'foo\';',
      'static final String foo = \'foo\';',
      'static var foo = \'foo\';',
      'static const var foo = \'foo\';',
      'static const bar = "bar";',
      'static const String longText = "This is a longer text with spaces";',
      'static const example = \'Example with spaces and no semicolon\'',
    ];

    for (final testString in testStrings) {
      // Extract using the same approach as in the extractTranslationEntries method
      try {
        final parts = testString.split('=');
        if (parts.length < 2) {
          print('❌ Failed to parse: "$testString"');
          continue;
        }

        final leftSide = parts[0].trim();
        String rightSide = parts.sublist(1).join('=').trim();

        // Extract key (variable name)
        final keyRegex = RegExp(r'(\w+)\s*$');
        final keyMatch = keyRegex.firstMatch(leftSide);
        if (keyMatch == null) {
          print('❌ Failed to extract key from: "$leftSide"');
          continue;
        }
        final key = keyMatch.group(1)!;

        // Extract value (string content)
        final valueRegex = RegExp('[\'"](.+?)[\'"]');
        final valueMatch = valueRegex.firstMatch(rightSide);
        if (valueMatch == null) {
          print('❌ Failed to extract value from: "$rightSide"');
          continue;
        }
        final value = valueMatch.group(1)!;

        print('✅ Extracted from: "$testString"');
        print('   Key: "$key", Value: "$value"');
      } catch (e) {
        print('❌ Error processing: "$testString"');
        print('   Error: $e');
      }
    }
    print('================================\n');
  } else if (command == 'start') {
    // Now extract actual entries from the file
    final entries = await extractTranslationEntries();
    print('Found ${entries.length} translation strings to process');

    // Print all entries for debugging
    print('\nFound the following translation entries:');
    for (int i = 0; i < entries.length; i++) {
      print('${i + 1}. Key: "${entries[i].key}", Value: "${entries[i].value}"');
    }

    // Identify keys that may need manual handling
    final variableKeys = identifyKeysWithVariables(entries);
    if (variableKeys.isNotEmpty) {
      print('\nKeys that may contain variables (for manual review):');
      variableKeys.forEach((key) => print('- $key'));
    }

    // Continue with normal processing
    await processTranslationEntries(entries);

    // Remind about the variable keys at the end
    if (variableKeys.isNotEmpty) {
      print('\n==== KEYS THAT MAY NEED MANUAL VARIABLE REPLACEMENT ====');
      variableKeys.forEach((key) => print('- $key'));
    }
  } else {
    print('Unknown command: $command');
    print('Usage:');
    print('  dart run translate.dart start   # Start the translation process');
    print('  dart run translate.dart test    # Run a test on extraction logic');
  }
}
