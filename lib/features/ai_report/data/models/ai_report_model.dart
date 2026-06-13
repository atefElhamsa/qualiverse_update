class AiReportResponse {
  final AiReportModel data;
  final bool isSuccess;

  AiReportResponse({required this.data, required this.isSuccess});

  factory AiReportResponse.fromJson(Map<String, dynamic> json) {
    return AiReportResponse(
      data: AiReportModel.fromJson(json['data'] ?? {}),
      isSuccess: json['isSuccess'] ?? false,
    );
  }
}

class AiReportModel {
  // Basic Info
  final String courseTitle;
  final String courseCode;
  final String academicYear;
  final String semester;
  final String department;
  final String courseType;
  final String level;
  final String program;
  final String faculty;
  final String university;
  final String coordinatorName;
  final String creditHours;
  final String instructorFulltime;
  final String instructorParttime;
  final String taFulltime;
  final String taParttime;

  // Lists
  final List<InstructorModel> instructors;
  final List<ImprovementPlanModel> improvementPlan;

  // Hours & Coverage
  final String numWeeksActual;
  final String totalTheoreticalHours;
  final String totalPracticalHours;
  final String totalFieldHours;
  final String totalSelfHours;
  final String totalOtherHours;
  final String topicsNotCovered;
  final String teachingMethodChanges;

  // Assessments
  final String exam1EvalDate;
  final String exam1Date;
  final String exam1Marks;
  final String exam1Type;
  final String exam1Clos;

  final String exam2EvalDate;
  final String exam2Date;
  final String exam2Marks;
  final String exam2Type;
  final String exam2Clos;

  final String midtermEvalDate;
  final String midtermDate;
  final String midtermMarks;
  final String midtermType;
  final String midtermClos;

  final String practicalEvalDate;
  final String practicalDate;
  final String practicalMarks;
  final String practicalType;
  final String practicalClos;

  final String oralEvalDate;
  final String oralDate;
  final String oralMarks;
  final String oralType;
  final String oralClos;

  final String writtenEvalDate;
  final String writtenDate;
  final String writtenMarks;
  final String writtenType;
  final String writtenClos;

  final String assessmentComment;

  // Students & Performance
  final String studentsStarted;
  final String studentsCompleted;
  final String studentsAbsent;
  final String studentsPassed;
  final String passPercentage;
  final GradesModel grades;
  final String studentsFailed;
  final String failPercentage;
  final String performanceComment;
  final String performanceNotes;

  // Survey
  final String surveyMeans;
  final String surveyTiming;
  final String surveyParticipants;
  final String surveyPct;
  final String satisfaction1;
  final String satisfaction2;
  final String satisfaction3;
  final String dissatisfaction1;
  final String dissatisfaction2;
  final String dissatisfaction3;

  // Review & Approval
  final String instructorReflection;
  final String uncompletedActions;
  final String approvalDate;
  final String approvalAttachment;

  AiReportModel({
    this.courseTitle = '',
    this.courseCode = '',
    this.academicYear = '',
    this.semester = '',
    this.department = '',
    this.courseType = '',
    this.level = '',
    this.program = '',
    this.faculty = '',
    this.university = '',
    this.coordinatorName = '',
    this.creditHours = '',
    this.instructorFulltime = '',
    this.instructorParttime = '',
    this.taFulltime = '',
    this.taParttime = '',
    this.instructors = const [],
    this.numWeeksActual = '',
    this.totalTheoreticalHours = '',
    this.totalPracticalHours = '',
    this.totalFieldHours = '',
    this.totalSelfHours = '',
    this.totalOtherHours = '',
    this.topicsNotCovered = '',
    this.teachingMethodChanges = '',
    this.exam1EvalDate = '',
    this.exam1Date = '',
    this.exam1Marks = '',
    this.exam1Type = '',
    this.exam1Clos = '',
    this.exam2EvalDate = '',
    this.exam2Date = '',
    this.exam2Marks = '',
    this.exam2Type = '',
    this.exam2Clos = '',
    this.midtermEvalDate = '',
    this.midtermDate = '',
    this.midtermMarks = '',
    this.midtermType = '',
    this.midtermClos = '',
    this.practicalEvalDate = '',
    this.practicalDate = '',
    this.practicalMarks = '',
    this.practicalType = '',
    this.practicalClos = '',
    this.oralEvalDate = '',
    this.oralDate = '',
    this.oralMarks = '',
    this.oralType = '',
    this.oralClos = '',
    this.writtenEvalDate = '',
    this.writtenDate = '',
    this.writtenMarks = '',
    this.writtenType = '',
    this.writtenClos = '',
    this.assessmentComment = '',
    this.studentsStarted = '',
    this.studentsCompleted = '',
    this.studentsAbsent = '',
    this.studentsPassed = '',
    this.passPercentage = '',
    required this.grades,
    this.studentsFailed = '',
    this.failPercentage = '',
    this.performanceComment = '',
    this.performanceNotes = '',
    this.surveyMeans = '',
    this.surveyTiming = '',
    this.surveyParticipants = '',
    this.surveyPct = '',
    this.satisfaction1 = '',
    this.satisfaction2 = '',
    this.satisfaction3 = '',
    this.dissatisfaction1 = '',
    this.dissatisfaction2 = '',
    this.dissatisfaction3 = '',
    this.instructorReflection = '',
    this.uncompletedActions = '',
    this.approvalDate = '',
    this.approvalAttachment = '',
    this.improvementPlan = const [],
  });

  factory AiReportModel.fromJson(Map<String, dynamic> json) {
    return AiReportModel(
      courseTitle: json['course_title']?.toString() ?? '',
      courseCode: json['course_code']?.toString() ?? '',
      academicYear: json['academic_year']?.toString() ?? '',
      semester: json['semester']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      courseType: json['course_type']?.toString() ?? '',
      level: json['level']?.toString() ?? '',
      program: json['program']?.toString() ?? '',
      faculty: json['faculty']?.toString() ?? '',
      university: json['university']?.toString() ?? '',
      coordinatorName: json['coordinator_name']?.toString() ?? '',
      creditHours: json['credit_hours']?.toString() ?? '',
      instructorFulltime: json['instructor_fulltime']?.toString() ?? '',
      instructorParttime: json['instructor_parttime']?.toString() ?? '',
      taFulltime: json['ta_fulltime']?.toString() ?? '',
      taParttime: json['ta_parttime']?.toString() ?? '',
      instructors:
          (json['instructors'] as List<dynamic>?)
              ?.map((e) => InstructorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      numWeeksActual: json['num_weeks_actual']?.toString() ?? '',
      totalTheoreticalHours: json['total_theoretical_hours']?.toString() ?? '',
      totalPracticalHours: json['total_practical_hours']?.toString() ?? '',
      totalFieldHours: json['total_field_hours']?.toString() ?? '',
      totalSelfHours: json['total_self_hours']?.toString() ?? '',
      totalOtherHours: json['total_other_hours']?.toString() ?? '',
      topicsNotCovered: json['topics_not_covered']?.toString() ?? '',
      teachingMethodChanges: json['teaching_method_changes']?.toString() ?? '',
      exam1EvalDate: json['exam1_eval_date']?.toString() ?? '',
      exam1Date: json['exam1_date']?.toString() ?? '',
      exam1Marks: json['exam1_marks']?.toString() ?? '',
      exam1Type: json['exam1_type']?.toString() ?? '',
      exam1Clos: json['exam1_clos']?.toString() ?? '',
      exam2EvalDate: json['exam2_eval_date']?.toString() ?? '',
      exam2Date: json['exam2_date']?.toString() ?? '',
      exam2Marks: json['exam2_marks']?.toString() ?? '',
      exam2Type: json['exam2_type']?.toString() ?? '',
      exam2Clos: json['exam2_clos']?.toString() ?? '',
      midtermEvalDate: json['midterm_eval_date']?.toString() ?? '',
      midtermDate: json['midterm_date']?.toString() ?? '',
      midtermMarks: json['midterm_marks']?.toString() ?? '',
      midtermType: json['midterm_type']?.toString() ?? '',
      midtermClos: json['midterm_clos']?.toString() ?? '',
      practicalEvalDate: json['practical_eval_date']?.toString() ?? '',
      practicalDate: json['practical_date']?.toString() ?? '',
      practicalMarks: json['practical_marks']?.toString() ?? '',
      practicalType: json['practical_type']?.toString() ?? '',
      practicalClos: json['practical_clos']?.toString() ?? '',
      oralEvalDate: json['oral_eval_date']?.toString() ?? '',
      oralDate: json['oral_date']?.toString() ?? '',
      oralMarks: json['oral_marks']?.toString() ?? '',
      oralType: json['oral_type']?.toString() ?? '',
      oralClos: json['oral_clos']?.toString() ?? '',
      writtenEvalDate: json['written_eval_date']?.toString() ?? '',
      writtenDate: json['written_date']?.toString() ?? '',
      writtenMarks: json['written_marks']?.toString() ?? '',
      writtenType: json['written_type']?.toString() ?? '',
      writtenClos: json['written_clos']?.toString() ?? '',
      assessmentComment: json['assessment_comment']?.toString() ?? '',
      studentsStarted: json['students_started']?.toString() ?? '',
      studentsCompleted: json['students_completed']?.toString() ?? '',
      studentsAbsent: json['students_absent']?.toString() ?? '',
      studentsPassed: json['students_passed']?.toString() ?? '',
      passPercentage: json['pass_percentage']?.toString() ?? '',
      grades: GradesModel.fromJson(json['grades'] ?? {}),
      studentsFailed: json['students_failed']?.toString() ?? '',
      failPercentage: json['fail_percentage']?.toString() ?? '',
      performanceComment: json['performance_comment']?.toString() ?? '',
      performanceNotes: json['performance_notes']?.toString() ?? '',
      surveyMeans: json['survey_means']?.toString() ?? '',
      surveyTiming: json['survey_timing']?.toString() ?? '',
      surveyParticipants: json['survey_participants']?.toString() ?? '',
      surveyPct: json['survey_pct']?.toString() ?? '',
      satisfaction1: json['satisfaction_1']?.toString() ?? '',
      satisfaction2: json['satisfaction_2']?.toString() ?? '',
      satisfaction3: json['satisfaction_3']?.toString() ?? '',
      dissatisfaction1: json['dissatisfaction_1']?.toString() ?? '',
      dissatisfaction2: json['dissatisfaction_2']?.toString() ?? '',
      dissatisfaction3: json['dissatisfaction_3']?.toString() ?? '',
      instructorReflection: json['instructor_reflection']?.toString() ?? '',
      uncompletedActions: json['uncompleted_actions']?.toString() ?? '',
      approvalDate: json['approval_date']?.toString() ?? '',
      approvalAttachment: json['approval_attachment']?.toString() ?? '',
      improvementPlan:
          (json['improvement_plan'] as List<dynamic>?)
              ?.map(
                (e) => ImprovementPlanModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class InstructorModel {
  final String name;
  final String department;
  final String degree;
  final String specialty;

  InstructorModel({
    this.name = '',
    this.department = '',
    this.degree = '',
    this.specialty = '',
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      name: json['name']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      degree: json['degree']?.toString() ?? '',
      specialty: json['specialty']?.toString() ?? '',
    );
  }
}

class GradesModel {
  final String aPlusCount;
  final String aPlusPct;
  final String aCount;
  final String aPct;
  final String bPlusCount;
  final String bPlusPct;
  final String bCount;
  final String bPct;
  final String cPlusCount;
  final String cPlusPct;
  final String cCount;
  final String cPct;
  final String dPlusCount;
  final String dPlusPct;
  final String dCount;
  final String dPct;

  GradesModel({
    this.aPlusCount = '',
    this.aPlusPct = '',
    this.aCount = '',
    this.aPct = '',
    this.bPlusCount = '',
    this.bPlusPct = '',
    this.bCount = '',
    this.bPct = '',
    this.cPlusCount = '',
    this.cPlusPct = '',
    this.cCount = '',
    this.cPct = '',
    this.dPlusCount = '',
    this.dPlusPct = '',
    this.dCount = '',
    this.dPct = '',
  });

  factory GradesModel.fromJson(Map<String, dynamic> json) {
    return GradesModel(
      aPlusCount: json['a_plus_count']?.toString() ?? '',
      aPlusPct: json['a_plus_pct']?.toString() ?? '',
      aCount: json['a_count']?.toString() ?? '',
      aPct: json['a_pct']?.toString() ?? '',
      bPlusCount: json['b_plus_count']?.toString() ?? '',
      bPlusPct: json['b_plus_pct']?.toString() ?? '',
      bCount: json['b_count']?.toString() ?? '',
      bPct: json['b_pct']?.toString() ?? '',
      cPlusCount: json['c_plus_count']?.toString() ?? '',
      cPlusPct: json['c_plus_pct']?.toString() ?? '',
      cCount: json['c_count']?.toString() ?? '',
      cPct: json['c_pct']?.toString() ?? '',
      dPlusCount: json['d_plus_count']?.toString() ?? '',
      dPlusPct: json['d_plus_pct']?.toString() ?? '',
      dCount: json['d_count']?.toString() ?? '',
      dPct: json['d_pct']?.toString() ?? '',
    );
  }
}

class ImprovementPlanModel {
  final String no;
  final String point;
  final String action;
  final String method;
  final String notes;

  ImprovementPlanModel({
    this.no = '',
    this.point = '',
    this.action = '',
    this.method = '',
    this.notes = '',
  });

  factory ImprovementPlanModel.fromJson(Map<String, dynamic> json) {
    return ImprovementPlanModel(
      no: json['no']?.toString() ?? '',
      point: json['point']?.toString() ?? '',
      action: json['action']?.toString() ?? '',
      method: json['method']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
    );
  }
}
