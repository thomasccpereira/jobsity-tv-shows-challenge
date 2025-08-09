#if DEBUG
extension EpisodesListModel {
   static var preview: Self {
      .init(episodes: .showEpisodesPreview)
   }
}
#endif
