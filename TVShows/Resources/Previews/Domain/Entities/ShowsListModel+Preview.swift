#if DEBUG
extension ShowsListModel {
   static var preview: Self {
      .init(shows: .showsListPreview)
   }
}
#endif
