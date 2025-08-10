#if DEBUG
extension EpisodeDetailViewModel {
   static var preview: Self {
      .init(coordinator: .preview,
            episode: .previewEpisode1)
   }
}
#endif
