import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'KEY', obfuscate: true)
  static final String KEY = _Env.KEY;
  @EnviedField(varName: 'PLACES_KEY', obfuscate: true)
  static final String PLACES_KEY = _Env.PLACES_KEY;
}
