abstract class UseCase<Type, Params> {
  /// if we add a call function in any call then it will be a callable class
  /// and we can call the class as a function
  Future<Type> call({required Params params});
}
