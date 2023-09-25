//* Use this function for handle usecase result
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_location/src/core/errors/exceptions.dart';
import 'package:fl_location/src/core/errors/failures.dart';
import 'package:fl_location/src/core/network/network_info.dart';

Future<Either<Failure, T>> exceptionHandler<T>(
    Function usecase, NetworkInfo networkInfo,
    {bool convertToEntity = true}) async {
  if (await networkInfo.isConnected()) {
    try {
      var res = await usecase();
      return convertToEntity ? Right((res).toEntity) : Right(res);
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(e.message, e.request));
    } on BadGatewayException catch (e) {
      return Left(BadGatewayFailure(e.message, e.request));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message, e.request));
    } on InternalServerException catch (e) {
      return Left(InternalServerFailure(e.message, e.request));
    } on MaintainServerException catch (e) {
      return Left(MaintainServerFailure(e.message, e.request));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.request));
    } on AppException catch (e) {
      return Left(AppFailure(e.message));
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message ?? 'Unknown Error', e.code));
    } catch (err) {
      return Left(AppFailure(err.toString()));
    }
  } else {
    return const Left(NetworkFailure());
  }
}
