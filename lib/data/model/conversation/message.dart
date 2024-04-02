class Message {
	String? message;
	dynamic fileType;
	bool? isFile;
	bool? isSeen;
	String? file;
	String? createdAt;

	Message({
		this.message, 
		this.fileType, 
		this.isFile, 
		this.isSeen, 
		this.file, 
		this.createdAt, 
	});

	factory Message.fromJson(Map<String, Object?> json) => Message(
				message: json['message'] as String?,
				fileType: json['file_type'] as dynamic,
				isFile: json['is_file'] as bool?,
				isSeen: json['is_seen'] as bool?,
				file: json['file'] as String?,
				createdAt: json['created_at'] as String?,
			);

	Map<String, Object?> toJson() => {
				'message': message,
				'file_type': fileType,
				'is_file': isFile,
				'is_seen': isSeen,
				'file': file,
				'created_at': createdAt,
			};
}
