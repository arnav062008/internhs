import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  bool? flagged;
  dynamic id;
  dynamic company;
  dynamic title;
  dynamic prestige; // Adjusted type to dynamic
  dynamic field;
  dynamic description;
  dynamic link;
  Timestamp? date; // New field

  Job({
    required this.flagged,
    required this.id,
    required this.company,
    required this.title,
    required this.prestige,
    required this.field,
    required this.description,
    required this.link,
    required this.date, // New field in the constructor
  }) {
    // Set defaults if any parameter is null
    flagged ??= false;
    id ??= 'N/A';
    company ??= 'N/A';
    title ??= 'N/A';
    prestige ??= 'N/A';
    field ??= 'N/A';
    description ??= 'N/A';
    link ??= 'N/A';
    date ??= Timestamp.now(); // Default to current time if null
  }

  factory Job.fromFirebase(Map<String, dynamic> data) {
    return Job(
      flagged: data['flagged'] ?? false,
      company: data['company'] ?? '',
      description: data['description'] ?? '',
      field: data['field'] ?? '',
      id: data['id'] ?? '',
      link: data['link'] ?? '',
      prestige: data['prestige'] ?? '',
      title: data['title'] ?? '',
      date: data['date'] ?? Timestamp.now(), // New field
    );
  }

  // Convert a Job object into a map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'flagged': flagged,
      'company': company,
      'title': title,
      'prestige': prestige,
      'field': field,
      'description': description,
      'link': link,
      'date': date, // New field
    };
  }

  Future<void> addJob() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference docRef = db.collection("jobs").doc();
    String jobId = docRef.id;
    id = jobId;
    try {
      await docRef.set(toMap());
      print('Job added successfully');
    } catch (e) {
      print('Error adding job: $e');
    }
  }
}
