#if DEBUG
extension ShowDetailViewModel {
   static var preview: Self {
      .init(coordinator: .preview,
            show: .previewShow1,
            fetchEpisodesUseCase: MockedFetchEpisodesUseCase())
   }
}
#endif
