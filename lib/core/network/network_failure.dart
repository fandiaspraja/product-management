abstract class NetworkFailure {
  final int? code;
  final String message;

  const NetworkFailure({required this.message, this.code});

  // factory NetworkFailure.genericError() {
  //   return const BaseFailure(
  //       message: "Something went wrong. Please try again later.");
  // }
}



// class BaseFailure extends Failure {
//   const BaseFailure({required super.message, super.code});
// }