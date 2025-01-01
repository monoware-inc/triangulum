import 'package:dio/dio.dart';
import '../models/game.dart';

class IGDBService {
  static const String _baseUrl = 'https://api.igdb.com/v4';
  static const String _clientId = 's3umzm32not444n1a3jcqw6ma0tfro';
  static const String _clientSecret = 'f0b40ulpr1vkvkm33gqhn2xlaxsnia';
  String? _accessToken;
  DateTime? _tokenExpiration;
  late final Dio _dio;

  IGDBService() {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ));
  }

  bool get _isTokenValid => 
      _accessToken != null && 
      _tokenExpiration != null &&
      _tokenExpiration!.isAfter(DateTime.now());

  Future<void> _generateAccessToken() async {
    try {
      print('Generating access token...');
      final response = await _dio.post(
        'https://id.twitch.tv/oauth2/token',
        queryParameters: {
          'client_id': _clientId,
          'client_secret': _clientSecret,
          'grant_type': 'client_credentials',
        },
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Token response status: ${response.statusCode}');
      print('Token response: ${response.data}');

      if (response.statusCode == 200) {
        _accessToken = response.data['access_token'];
        _tokenExpiration = DateTime.now().add(
          Duration(seconds: response.data['expires_in']),
        );
      } else {
        throw Exception('Failed to generate token: ${response.statusCode} - ${response.data}');
      }
    } on DioException catch (e) {
      print('Dio error type: ${e.type}');
      print('Dio error message: ${e.message}');
      print('Dio error response: ${e.response}');
      rethrow;
    } catch (e) {
      print('Error generating token: $e');
      rethrow;
    }
  }

  Future<List<Game>> getTrendingGames() async {
    try {
      if (!_isTokenValid) {
        await _generateAccessToken();
      }

      if (_accessToken == null) {
        throw Exception('No access token available');
      }

      print('Using access token: $_accessToken');
      
      final response = await _dio.post(
        '$_baseUrl/games',
        data: '''
          fields name, cover.url, rating, total_rating_count;
          where cover != null & total_rating_count != null & rating != null;
          sort total_rating_count desc;
          limit 10;
        ''',
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Client-ID': _clientId,
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'text/plain',
          },
        ),
      );

      print('Games response status: ${response.statusCode}');
      print('Games response: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load games: ${response.statusCode} - ${response.data}');
      }
    } on DioException catch (e) {
      print('Dio error type: ${e.type}');
      print('Dio error message: ${e.message}');
      print('Dio error response: ${e.response}');
      rethrow;
    } catch (e) {
      print('Error fetching games: $e');
      rethrow;
    }
  }

  Future<List<Game>> getUpcomingGames() async {
    try {
      if (!_isTokenValid) {
        await _generateAccessToken();
      }

      final response = await _dio.post(
        '$_baseUrl/games',
        data: '''
          fields name, cover.url, first_release_date;
          where first_release_date > ${DateTime.now().millisecondsSinceEpoch ~/ 1000} & cover != null;
          sort first_release_date asc;
          limit 10;
        ''',
        options: Options(
          headers: {
            'Client-ID': _clientId,
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'text/plain',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load upcoming games: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching upcoming games: $e');
      rethrow;
    }
  }
} 