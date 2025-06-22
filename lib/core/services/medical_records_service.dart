import 'package:better_life/models/medical_record_model.dart';
import 'package:better_life/models/radiation_model.dart';

class MedicalRecordsService {
  // Get mock medical records data
  static List<MedicalRecordModel> getMockMedicalRecords() {
    return [
      MedicalRecordModel(
        id: '1',
        patientId: '1',
        title: 'Annual Physical Examination',
        description: 'Comprehensive physical examination including blood pressure, heart rate, respiratory rate, and general health assessment. All vital signs are within normal range.',
        date: '2024-01-15',
        doctorName: 'Dr. Sarah Johnson',
        hospital: 'City General Hospital',
        type: 'Physical Examination',
        fileUrl: 'https://example.com/records/physical_2024.pdf',
      ),
      MedicalRecordModel(
        id: '2',
        patientId: '1',
        title: 'Blood Test Results',
        description: 'Complete blood count (CBC) and comprehensive metabolic panel. Results show normal levels for all parameters. Hemoglobin: 14.2 g/dL, White blood cells: 7,500/μL.',
        date: '2024-01-10',
        doctorName: 'Dr. Michael Chen',
        hospital: 'City General Hospital',
        type: 'Laboratory Test',
        fileUrl: 'https://example.com/records/blood_test_2024.pdf',
      ),
      MedicalRecordModel(
        id: '3',
        patientId: '1',
        title: 'Dental Checkup',
        description: 'Routine dental examination and cleaning. No cavities found. Gum health is excellent. Recommended to continue current oral hygiene routine.',
        date: '2023-12-20',
        doctorName: 'Dr. Emily Davis',
        hospital: 'Bright Smile Dental Clinic',
        type: 'Dental Examination',
        fileUrl: 'https://example.com/records/dental_2023.pdf',
      ),
      MedicalRecordModel(
        id: '4',
        patientId: '1',
        title: 'Eye Examination',
        description: 'Comprehensive eye examination including visual acuity, intraocular pressure, and retinal examination. Vision is 20/20 in both eyes. No signs of glaucoma or other eye diseases.',
        date: '2023-11-05',
        doctorName: 'Dr. Robert Wilson',
        hospital: 'Vision Care Center',
        type: 'Eye Examination',
        fileUrl: 'https://example.com/records/eye_exam_2023.pdf',
      ),
      MedicalRecordModel(
        id: '5',
        patientId: '1',
        title: 'Cardiology Consultation',
        description: 'Cardiology consultation due to family history of heart disease. ECG shows normal sinus rhythm. Echocardiogram reveals normal heart function and structure.',
        date: '2023-10-12',
        doctorName: 'Dr. James Anderson',
        hospital: 'Heart Care Institute',
        type: 'Cardiology Consultation',
        fileUrl: 'https://example.com/records/cardiology_2023.pdf',
      ),
      MedicalRecordModel(
        id: '6',
        patientId: '1',
        title: 'Dermatology Visit',
        description: 'Skin examination for mole check. All moles appear benign. No suspicious lesions found. Recommended annual follow-up for skin cancer screening.',
        date: '2023-09-18',
        doctorName: 'Dr. Lisa Thompson',
        hospital: 'Skin Care Clinic',
        type: 'Dermatology Examination',
        fileUrl: 'https://example.com/records/dermatology_2023.pdf',
      ),
      MedicalRecordModel(
        id: '7',
        patientId: '1',
        title: 'Vaccination Record',
        description: 'Annual flu shot and COVID-19 booster vaccination. No adverse reactions reported. All vaccinations are up to date according to CDC recommendations.',
        date: '2023-08-25',
        doctorName: 'Dr. Sarah Johnson',
        hospital: 'City General Hospital',
        type: 'Vaccination',
        fileUrl: 'https://example.com/records/vaccinations_2023.pdf',
      ),
      MedicalRecordModel(
        id: '8',
        patientId: '1',
        title: 'Nutrition Consultation',
        description: 'Consultation with registered dietitian for weight management and healthy eating plan. Personalized meal plan created based on current health status and goals.',
        date: '2023-07-30',
        doctorName: 'Dr. Amanda Lee',
        hospital: 'Nutrition Wellness Center',
        type: 'Nutrition Consultation',
        fileUrl: 'https://example.com/records/nutrition_2023.pdf',
      ),
    ];
  }

  // Get mock radiation records data
  static List<RadiationModel> getMockRadiationRecords() {
    return [
      RadiationModel(
        id: '1',
        patientId: '1',
        type: 'Chest X-Ray',
        date: '2024-01-15',
        description: 'PA and lateral chest X-ray for routine screening. Lungs are clear with no evidence of infiltrates, masses, or pleural effusion. Cardiac silhouette is normal.',
        doctorName: 'Dr. David Miller',
        hospital: 'City General Hospital',
        result: 'Normal',
        fileUrl: 'https://example.com/radiation/chest_xray_2024.pdf',
      ),
      RadiationModel(
        id: '2',
        patientId: '1',
        type: 'Abdominal CT Scan',
        date: '2023-12-10',
        description: 'Contrast-enhanced CT scan of abdomen and pelvis. No evidence of masses, stones, or other abnormalities. All organs appear normal in size and position.',
        doctorName: 'Dr. Jennifer Brown',
        hospital: 'City General Hospital',
        result: 'Normal',
        fileUrl: 'https://example.com/radiation/abdominal_ct_2023.pdf',
      ),
      RadiationModel(
        id: '3',
        patientId: '1',
        type: 'Mammogram',
        date: '2023-11-20',
        description: 'Bilateral screening mammogram. No suspicious masses, calcifications, or architectural distortions identified. Breast tissue density is scattered fibroglandular.',
        doctorName: 'Dr. Patricia Garcia',
        hospital: 'Breast Care Center',
        result: 'Normal (BI-RADS 1)',
        fileUrl: 'https://example.com/radiation/mammogram_2023.pdf',
      ),
      RadiationModel(
        id: '4',
        patientId: '1',
        type: 'DEXA Scan',
        date: '2023-10-05',
        description: 'Dual-energy X-ray absorptiometry scan for bone density assessment. T-score: -0.8 (normal range). No evidence of osteoporosis or osteopenia.',
        doctorName: 'Dr. Thomas Clark',
        hospital: 'Bone Health Center',
        result: 'Normal bone density',
        fileUrl: 'https://example.com/radiation/dexa_scan_2023.pdf',
      ),
      RadiationModel(
        id: '5',
        patientId: '1',
        type: 'Echocardiogram',
        date: '2023-09-15',
        description: 'Transthoracic echocardiogram. Left ventricular ejection fraction: 65%. No regional wall motion abnormalities. Valves appear normal. No pericardial effusion.',
        doctorName: 'Dr. James Anderson',
        hospital: 'Heart Care Institute',
        result: 'Normal cardiac function',
        fileUrl: 'https://example.com/radiation/echo_2023.pdf',
      ),
      RadiationModel(
        id: '6',
        patientId: '1',
        type: 'MRI Brain',
        date: '2023-08-22',
        description: 'Brain MRI without contrast for headache evaluation. No evidence of mass lesions, hemorrhage, or other intracranial abnormalities. Ventricles and sulci are normal.',
        doctorName: 'Dr. Rachel Green',
        hospital: 'Neurology Imaging Center',
        result: 'Normal brain MRI',
        fileUrl: 'https://example.com/radiation/brain_mri_2023.pdf',
      ),
      RadiationModel(
        id: '7',
        patientId: '1',
        type: 'Ultrasound - Thyroid',
        date: '2023-07-18',
        description: 'Thyroid ultrasound for evaluation of thyroid nodules. Thyroid gland appears normal in size and echogenicity. No suspicious nodules identified.',
        doctorName: 'Dr. Kevin White',
        hospital: 'Endocrinology Clinic',
        result: 'Normal thyroid',
        fileUrl: 'https://example.com/radiation/thyroid_us_2023.pdf',
      ),
      RadiationModel(
        id: '8',
        patientId: '1',
        type: 'Colonoscopy',
        date: '2023-06-12',
        description: 'Screening colonoscopy. Exam completed to cecum. No polyps, masses, or other abnormalities identified. Colon appears normal throughout.',
        doctorName: 'Dr. Maria Rodriguez',
        hospital: 'Gastroenterology Center',
        result: 'Normal colonoscopy',
        fileUrl: 'https://example.com/radiation/colonoscopy_2023.pdf',
      ),
    ];
  }

  // Get medical records for a specific patient
  static Future<List<MedicalRecordModel>> getMedicalRecords(String patientId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    return getMockMedicalRecords().where((record) => record.patientId == patientId).toList();
  }

  // Get radiation records for a specific patient
  static Future<List<RadiationModel>> getRadiationRecords(String patientId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    return getMockRadiationRecords().where((record) => record.patientId == patientId).toList();
  }
} 