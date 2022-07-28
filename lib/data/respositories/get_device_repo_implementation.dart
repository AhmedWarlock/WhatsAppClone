import 'package:whatsapp_clone/data/data_source/local_datasource/local_datasource.dart';
import 'package:whatsapp_clone/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone/domain/repositories/get_device_number_repository.dart';

class GetDeviceNumRepoImplementation implements GetDeviceNumberRepository {
  final GetDeviceNumbersLocalDataSource dataSource;
  GetDeviceNumRepoImplementation({
    required this.dataSource,
  });

  @override
  Future<List<ContactEntity>> getDeviceNumbers() async =>
      await dataSource.getDeviceNumbers();
}
