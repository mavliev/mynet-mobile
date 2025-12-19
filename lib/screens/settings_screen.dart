import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/database_service.dart';
import '../providers/database_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? _currentDatabasePath;
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, int>? _databaseStats;
  int? _databaseSize;

  @override
  void initState() {
    super.initState();
    _loadCurrentDatabasePath();
    _loadDatabaseStats();
  }

  Future<void> _loadCurrentDatabasePath() async {
    final dbService = DatabaseService.instance;
    setState(() {
      _currentDatabasePath = dbService.getCurrentDatabasePath();
    });

    // If no path is set, try to get it from SharedPreferences
    if (_currentDatabasePath == null) {
      final savedPath = await DatabaseService.getDatabasePath();
      if (savedPath != null) {
        setState(() {
          _currentDatabasePath = savedPath;
        });
      }
    }
  }

  Future<void> _loadDatabaseStats() async {
    try {
      final dbService = DatabaseService.instance;
      final stats = await dbService.getStats();
      final size = await dbService.getDatabaseSize();

      setState(() {
        _databaseStats = stats;
        _databaseSize = size;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _requestStoragePermission() async {
    // Request storage permissions
    if (Platform.isAndroid) {
      // For Android 13+ (API 33+)
      if (await Permission.photos.isGranted ||
          await Permission.videos.isGranted ||
          await Permission.audio.isGranted) {
        return;
      }

      // Request media permissions for Android 13+
      await [
        Permission.photos,
        Permission.videos,
        Permission.audio,
      ].request();

      // For older Android versions, also request storage permission
      if (!await Permission.storage.isGranted) {
        await Permission.storage.request();
      }

      // For Android 11+, may need MANAGE_EXTERNAL_STORAGE for full access
      if (!await Permission.manageExternalStorage.isGranted) {
        final status = await Permission.manageExternalStorage.request();
        if (status.isDenied || status.isPermanentlyDenied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Storage permission is required to access database files. '
                  'Please grant permission in Settings.',
                ),
                duration: Duration(seconds: 5),
              ),
            );
          }
        }
      }
    }
  }

  Future<void> _pickDatabaseFile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Request permissions first
      await _requestStoragePermission();

      // Pick a file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db', 'sqlite', 'sqlite3'],
        dialogTitle: 'Select Database File',
      );

      if (result != null && result.files.single.path != null) {
        final selectedPath = result.files.single.path!;

        // Verify the file exists
        final file = File(selectedPath);
        if (!await file.exists()) {
          throw Exception('Selected file does not exist');
        }

        // Save the path
        await DatabaseService.setDatabasePath(selectedPath);

        // Reload the database
        final dbService = DatabaseService.instance;
        await dbService.reloadDatabase();

        // Refresh the UI
        await _loadCurrentDatabasePath();
        await _loadDatabaseStats();

        // Invalidate providers to refresh the app
        ref.invalidate(databaseStatsProvider);
        ref.invalidate(databaseSizeProvider);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Database loaded from: $selectedPath'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading database: ${e.toString()}';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _reloadDatabase() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final dbService = DatabaseService.instance;
      await dbService.reloadDatabase();

      // Refresh stats
      await _loadCurrentDatabasePath();
      await _loadDatabaseStats();

      // Invalidate providers
      ref.invalidate(databaseStatsProvider);
      ref.invalidate(databaseSizeProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Database reloaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error reloading database: ${e.toString()}';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resetToDefault() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to Default'),
        content: const Text(
          'This will reset the database path to the default location:\n'
          '/storage/emulated/0/ToYouJAN/myNET.db\n\n'
          'Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        await DatabaseService.clearDatabasePath();
        final dbService = DatabaseService.instance;
        await dbService.reloadDatabase();

        await _loadCurrentDatabasePath();
        await _loadDatabaseStats();

        ref.invalidate(databaseStatsProvider);
        ref.invalidate(databaseSizeProvider);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reset to default database path'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error resetting: ${e.toString()}';
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Database Path Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.storage,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(width: 8),
                              Text(
                                'Database Configuration',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Current Database Path:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SelectableText(
                              _currentDatabasePath ??
                                  '/storage/emulated/0/ToYouJAN/myNET.db (default)',
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _pickDatabaseFile,
                                  icon: const Icon(Icons.folder_open),
                                  label: const Text('Select Database File'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _resetToDefault,
                                  icon: const Icon(Icons.restore),
                                  label: const Text('Reset to Default'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _reloadDatabase,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Reload Database'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Database Statistics Section
                  if (_databaseStats != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.analytics,
                                    color: Theme.of(context).primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  'Database Statistics',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (_databaseSize != null)
                              _buildStatRow(
                                  'Database Size', _formatBytes(_databaseSize!)),
                            const Divider(),
                            _buildStatRow('LinkedIn Profiles',
                                _databaseStats!['linkedin_profiles'].toString()),
                            _buildStatRow('Booth Profiles',
                                _databaseStats!['booth_profiles'].toString()),
                            _buildStatRow('Connections',
                                _databaseStats!['connections'].toString()),
                            const Divider(),
                            _buildStatRow(
                                'Notes', _databaseStats!['notes'].toString()),
                            _buildStatRow('Interactions',
                                _databaseStats!['interactions'].toString()),
                            _buildStatRow(
                                'Tags', _databaseStats!['tags'].toString()),
                            const Divider(),
                            _buildStatRow('Pending Follow-ups',
                                _databaseStats!['pending_follow_ups'].toString()),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Error Message
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Card(
                      color: Colors.red[50],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.error, color: Colors.red[700]),
                                const SizedBox(width: 8),
                                Text(
                                  'Error',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[700],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Instructions
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              Text(
                                'Instructions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '1. Place your database file (myNET.db or JAT.db) at:\n'
                            '   /storage/emulated/0/ToYouJAN/\n\n'
                            '2. Or use "Select Database File" to choose a custom location\n\n'
                            '3. Make sure storage permissions are granted\n\n'
                            '4. Use "Reload Database" if you update the database file',
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
