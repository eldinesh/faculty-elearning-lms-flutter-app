class Features {
	String? totalLesson;
	String? totalEnroll;
	String? totalQuiz;
	String? totalVideos;
	String? totalNoteFiles;
	String? totalAudioFiles;

	Features({
		this.totalLesson, 
		this.totalEnroll, 
		this.totalQuiz, 
		this.totalVideos, 
		this.totalNoteFiles, 
		this.totalAudioFiles, 
	});

	factory Features.fromJson(Map<String, Object?> json) => Features(
				totalLesson: json['total_lesson'] as String?,
				totalEnroll: json['total_enroll'] as String?,
				totalQuiz: json['total_quiz'] as String?,
				totalVideos: json['total_videos'] as String?,
				totalNoteFiles: json['total_note_files'] as String?,
				totalAudioFiles: json['total_audio_files'] as String?,
			);

	Map<String, Object?> toJson() => {
				'total_lesson': totalLesson,
				'total_enroll': totalEnroll,
				'total_quiz': totalQuiz,
				'total_videos': totalVideos,
				'total_note_files': totalNoteFiles,
				'total_audio_files': totalAudioFiles,
			};
}
