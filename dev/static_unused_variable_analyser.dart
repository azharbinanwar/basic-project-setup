// save as remove_unused_strings.dart
import 'dart:io';

/// A tool to identify and remove unused static string constants from a Dart class.
///
/// This script identifies unused static constants in a specified Dart file and class,
/// creates a backup of the original file, and removes the unused constants.
void main(List<String> args) {
  // Process command line arguments
  final arguments = processArguments(args);
  if (arguments == null) return;

  final targetFile = arguments['file'] as String;
  final className = arguments['class'] as String?;
  final dryRun = arguments['dry-run'] as bool;

  try {
    // Read the target file
    final fileToCheck = File(targetFile);
    if (!fileToCheck.existsSync()) {
      print('Error: File $targetFile does not exist');
      return;
    }

    final content = fileToCheck.readAsStringSync();

    // Determine the class name if not provided
    final actualClassName = className ?? extractClassName(content);
    if (actualClassName == null) {
      print('Error: Could not determine class name. Please specify using --class option');
      return;
    }

    print('Analyzing static variables in class $actualClassName from $targetFile');

    // Extract all static constants and their line numbers
    final staticVars = extractStaticVariables(content);
    print('Found ${staticVars.length} static variables');

    // Determine which variables are unused
    final unusedVars = findUnusedVariables(staticVars, actualClassName, targetFile);

    if (unusedVars.isEmpty) {
      print('All static variables are properly referenced in the project.');
      return;
    }

    print('\nFound ${unusedVars.length} potentially unused static variables out of ${staticVars.length} total:');
    unusedVars.forEach((varName) => print('  - $varName'));

    if (dryRun) {
      print('\nDry run: No changes made. Run without --dry-run to remove unused variables.');
      return;
    }

    // Create a backup of the original file
    final backupFile = createBackup(fileToCheck);
    print('Original file backed up to ${backupFile.path}');

    // Remove the unused variables
    final removedCount = removeUnusedVariables(fileToCheck, content, unusedVars);
    print('Removed $removedCount unused variables from $targetFile');
    print('Original file was backed up to ${backupFile.path} in case you need to restore it');
  } catch (e) {
    print('Error: $e');
  }
}

/// Process command line arguments and return a map of options.
///
/// Returns null if help is requested or if there's an error in arguments.
Map<String, dynamic>? processArguments(List<String> args) {
  final result = {
    'file': '../lib/core/constants/app_strings.dart',
    'class': null,
    'dry-run': false,
  };

  for (int i = 0; i < args.length; i++) {
    final arg = args[i];
    switch (arg) {
      case '--help':
      case '-h':
        printUsage();
        return null;
      case '--file':
      case '-f':
        if (i + 1 < args.length) {
          result['file'] = args[++i];
        } else {
          print('Error: Missing value for $arg');
          printUsage();
          return null;
        }
        break;
      case '--class':
      case '-c':
        if (i + 1 < args.length) {
          result['class'] = args[++i];
        } else {
          print('Error: Missing value for $arg');
          printUsage();
          return null;
        }
        break;
      case '--dry-run':
      case '-d':
        result['dry-run'] = true;
        break;
      default:
        if (arg.startsWith('-')) {
          print('Error: Unknown option $arg');
          printUsage();
          return null;
        }
    }
  }

  return result;
}

/// Print usage instructions to the console
void printUsage() {
  print('''
Usage: dart remove_unused_strings.dart [OPTIONS]

Options:
  -h, --help            Show this help message
  -f, --file FILE       Path to the file containing the class (default: lib/core/constants/app_strings.dart)
  -c, --class CLASS     Name of the class to analyze (optional, will try to detect automatically)
  -d, --dry-run         Show what would be removed without making changes

Example:
  dart remove_unused_strings.dart --file lib/constants.dart --class MyStrings
''');
}

/// Extract the class name from the file content.
///
/// Returns null if no class declaration is found.
String? extractClassName(String content) {
  final classNamePattern = RegExp(r'class\s+(\w+)\s*{');
  final classNameMatch = classNamePattern.firstMatch(content);
  return classNameMatch?.group(1);
}

/// Extract all static variables from the file content.
///
/// Returns a list of variable names.
List<String> extractStaticVariables(String content) {
  final staticVarPattern = RegExp(r'static\s+const\s+(\w+)\s*=');
  final matches = staticVarPattern.allMatches(content);

  final staticVars = <String>[];
  for (final match in matches) {
    final varName = match.group(1);
    if (varName != null) {
      staticVars.add(varName);
    }
  }

  return staticVars;
}

/// Find unused variables by checking all Dart files in the project.
///
/// Returns a list of variable names that aren't referenced anywhere.
List<String> findUnusedVariables(List<String> staticVars, String className, String targetFile) {
  // Get all Dart files recursively, excluding the target file
  final projectDir = Directory('../lib');
  final dartFiles =
      projectDir.listSync(recursive: true).where((f) => f.path.endsWith('.dart') && f.path != targetFile).map((f) => File(f.path)).toList();

  print('Searching for references in ${dartFiles.length} Dart files...');

  final unusedVars = <String>[];

  for (final variable in staticVars) {
    var isUsed = false;
    final lookFor = '$className.$variable';

    for (final file in dartFiles) {
      final fileContent = file.readAsStringSync();
      if (fileContent.contains(lookFor)) {
        isUsed = true;
        break;
      }
    }

    if (!isUsed) {
      unusedVars.add(variable);
    }
  }

  return unusedVars;
}

/// Create a backup of the original file.
///
/// Returns the backup File object.
File createBackup(File originalFile) {
  final backupPath = '${originalFile.path}.backup';
  final backupFile = File(backupPath);
  originalFile.copySync(backupPath);
  return backupFile;
}

/// Remove unused variables from the file and write back the content.
///
/// Returns the number of lines removed.
int removeUnusedVariables(File fileToCheck, String content, List<String> unusedVars) {
  final contentLines = content.split('\n');
  final linesToRemove = <int>[];

  // Find the lines to remove
  for (int i = 0; i < contentLines.length; i++) {
    final line = contentLines[i];
    for (final variable in unusedVars) {
      // Match the full variable declaration
      if (RegExp(r'^\s*static\s+const\s+' + variable + r'\s*=').hasMatch(line)) {
        linesToRemove.add(i);
        break;
      }
    }
  }

  // Remove lines in reverse order to maintain correct indices
  linesToRemove.sort((a, b) => b.compareTo(a));
  for (final lineIndex in linesToRemove) {
    contentLines.removeAt(lineIndex);
  }

  // Write the modified content back to the file
  final modifiedContent = contentLines.join('\n');
  fileToCheck.writeAsStringSync(modifiedContent);

  return linesToRemove.length;
}
