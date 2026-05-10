class AiDescriptionResultModel {
  final BasicInfo basicInfo;
  final ScheduleInfo scheduleInfo;
  final List<LearningHourWeekly> learningHoursWeekly;
  final Resources resources;
  final Facilities facilities;

  AiDescriptionResultModel({
    required this.basicInfo,
    required this.scheduleInfo,
    required this.learningHoursWeekly,
    required this.resources,
    required this.facilities,
  });

  factory AiDescriptionResultModel.mock() {
    return AiDescriptionResultModel(
      basicInfo: BasicInfo(
        courseTitle: "Software Engineering",
        courseCode: "CSE412",
        department: "Computer Engineering",
        courseType: "Core",
        academicLevel: "Level 4",
        academicProgram: "Computer Science",
        faculty: "Engineering",
        university: "Cairo University",
        coordinator: "Dr. Ahmed Ali",
        approvalDate: "2026-05-09",
      ),
      scheduleInfo: ScheduleInfo(totalWeeklyHours: 2514),
      learningHoursWeekly: [
        LearningHourWeekly(
          week: 1,
          theoretical: 2939,
          training: 3377,
          selfLearning: 4138,
          other: 4837,
        ),
        LearningHourWeekly(
          week: 2,
          theoretical: 5051,
          training: 8552,
          selfLearning: 8935,
          other: 5756,
        ),
      ],
      resources: Resources(
        mainReference: "Main Textbook of SE",
        otherReferences: "Agile Principles, Patterns, and Practices",
        electronicSources: "IEEE Xplore",
        learningPlatforms: "Coursera, edX",
        other: "Open Source Projects",
      ),
      facilities: Facilities(
        devices: "High-end PCs",
        supplies: "Whiteboards, Markers",
        programs: "Visual Studio Code, Docker",
        skillLabs: "Software Lab 1",
        virtualLabs: "Cloud Sandbox",
        other: "Projector",
      ),
    );
  }
}

class BasicInfo {
  final String courseTitle;
  final String courseCode;
  final String department;
  final String courseType;
  final String academicLevel;
  final String academicProgram;
  final String faculty;
  final String university;
  final String coordinator;
  final String approvalDate;

  BasicInfo({
    required this.courseTitle,
    required this.courseCode,
    required this.department,
    required this.courseType,
    required this.academicLevel,
    required this.academicProgram,
    required this.faculty,
    required this.university,
    required this.coordinator,
    required this.approvalDate,
  });
}

class ScheduleInfo {
  final int totalWeeklyHours;
  ScheduleInfo({required this.totalWeeklyHours});
}

class LearningHourWeekly {
  final int week;
  final int theoretical;
  final int training;
  final int selfLearning;
  final int other;

  LearningHourWeekly({
    required this.week,
    required this.theoretical,
    required this.training,
    required this.selfLearning,
    required this.other,
  });
}

class Resources {
  final String mainReference;
  final String otherReferences;
  final String electronicSources;
  final String learningPlatforms;
  final String other;

  Resources({
    required this.mainReference,
    required this.otherReferences,
    required this.electronicSources,
    required this.learningPlatforms,
    required this.other,
  });
}

class Facilities {
  final String devices;
  final String supplies;
  final String programs;
  final String skillLabs;
  final String virtualLabs;
  final String other;

  Facilities({
    required this.devices,
    required this.supplies,
    required this.programs,
    required this.skillLabs,
    required this.virtualLabs,
    required this.other,
  });
}
