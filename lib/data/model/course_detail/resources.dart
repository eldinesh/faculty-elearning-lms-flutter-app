class Resources {
	bool? isDocAvailable;
	bool? isAudioAvailable;
	bool? isVideoAvailable;

	Resources({
		this.isDocAvailable, 
		this.isAudioAvailable, 
		this.isVideoAvailable, 
	});

	factory Resources.fromJson(Map<String, Object?> json) => Resources(
				isDocAvailable: json['is_doc_available'] as bool?,
				isAudioAvailable: json['is_audio_available'] as bool?,
				isVideoAvailable: json['is_video_available'] as bool?,
			);

	Map<String, Object?> toJson() => {
				'is_doc_available': isDocAvailable,
				'is_audio_available': isAudioAvailable,
				'is_video_available': isVideoAvailable,
			};
}
