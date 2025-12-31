import 'package:qualiverse/features/accreditation_list/data/accreditation_list_model.dart';

class FackApi
{
  static final List<AccreditationListModel> accreditationListFiles = 
  [
    AccreditationListModel
    (
      nameCourse: 'مؤشر 1-1: اللائحة الأكاديمية للدراسات العليا – مصادر إعتماد – منشورات تعريفية',
      nameFile: 'لا يوجد ملف'
    ),
    AccreditationListModel
    (
      nameCourse: 'مؤشر 1-2: نتائج الموارد والإمكانات – صور إجتماعات وفعاليات – تقارير متابعة',
      nameFile: 'evaluation.pdf (2.8MB)'
    ),
    AccreditationListModel
    (
      nameCourse: 'مؤشر 1-3: نتائج تسجيل الرسائل – تقارير فصليه متابعة الإشراف – استمارات تقييم',
      nameFile: 'performance.xlsx (300KB)'
    ),
    AccreditationListModel
    (
      nameCourse: 'مؤشر 1-4: استمارات رضا طالب الدراسات العليا – تقارير تدريس – محاضر مناقشة',
      nameFile: 'performance.xlsx (300KB)'
    )
  ];
  static List<AccreditationListModel> getCourseModuleFiles()
  {
    return accreditationListFiles;
  }
}