sealed class Result<T> {
  Object get exception => throw UnimplementedError();
}

class SuccessResult<T> extends Result<T> {
  SuccessResult(this.data);
  T data;
}

class FailureResult<T> extends Result<T> {
  FailureResult(this.exception);
  @override
  Exception exception;
}
