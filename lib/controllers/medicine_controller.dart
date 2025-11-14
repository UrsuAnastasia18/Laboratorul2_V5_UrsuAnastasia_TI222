import 'package:get/get.dart';
import '../data/medicine_service.dart';
import '../models/doctor.dart';
// coontrollerul are variabile reactive obs// pt gestionarea starii
class MedicineController extends GetxController {
  var feed = <String, dynamic>{}.obs; // aici se vor salva datele JSON
  var isLoading = true.obs;
  var error = RxnString();
//converteste sectiunea doctorDetails in obiect Doctor
  final _service = MedicineService();

  @override
  void onInit() {
    super.onInit();
    loadFeed(); // se apelează automat la inițializare
  }

  Future<void> loadFeed() async {
    try {
      isLoading.value = true;
      error.value = null;

      // datele din fisierul json sunt citite prin await... si se intorc ca un map<tring, dynamics>
      final data = await _service.loadMedicineFeed();
      feed.value = data;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // metodă suplimentară: preia doctorul detaliat din JSON și îl convertește într-un obiect Doctor
  Doctor get detailedDoctor {
    final details = feed['doctorDetails']?['doctor'];
    if (details == null) {
      return Doctor(
        name: 'Unknown',
        specialty: 'N/A',
        rating: 0,
        yearsOfWork: 0,
        patients: 0,
        clinic: '',
        location: '',
        price: 0,
        assetImage: '',
      );
    }
    return Doctor.fromJson(details);
  }
}