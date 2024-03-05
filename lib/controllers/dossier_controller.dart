import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/services/dossier_service.dart';
import 'package:get/get.dart';

class DossierListController extends GetxController {
  DossierListController() {
    _dossierService = DossierService();
  }

  List<Dossier> dossiers = [];

  late DossierService _dossierService;

  @override
  void onInit() async {
    super.onInit();
    await getAllDossiers();
  }

  Future<void> getAllDossiers() async {
    dossiers = await _dossierService.readAllDossiers();
    update();
  }
}

class HandleDossierController extends GetxController {
  final DossierService _dossierService = DossierService();

  Future<void> createDossier(Dossier dossier) async {
    await Future.delayed(const Duration(seconds: 2));
    await _dossierService.saveDossier(dossier);
    update();
  }

  Future<void> updateDossier(Dossier dossier) async {
    await Future.delayed(const Duration(seconds: 2));
    await _dossierService.updateDossier(dossier);
    update();
  }

  Future<void> deleteDossier(Dossier dossier) async {
    await _dossierService.deleteDossier(dossier.id!);
    update();
  }
}
