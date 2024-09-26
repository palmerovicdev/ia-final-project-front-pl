
import '../../data_sources/number_translator/number_translator_datasource.dart';
import '../../models/consult_request.dart';
import '../../models/consult_response.dart';
import '../../models/general_response.dart';

abstract class NumberTranslatorRepository {
  Future<GeneralResponse<ConsultResponse>> makeTranslate({required ConsultRequest request, required bool isFromDigit});
}

class NumberTranslatorRepositoryImpl extends NumberTranslatorRepository {
  final NumberTranslatorDatasource datasource;

  NumberTranslatorRepositoryImpl({required this.datasource});

  @override
  Future<GeneralResponse<ConsultResponse>> makeTranslate({required ConsultRequest request, required bool isFromDigit}) async =>
      await datasource.makeTranslate(
        request: request,
        isFromDigit: isFromDigit,
      );
}