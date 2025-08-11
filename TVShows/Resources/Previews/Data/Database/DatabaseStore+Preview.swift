#if DEBUG
extension DatabaseStore {
   static var preview: Self {
      try! .init(models: [ SingleShowDAO.self, SingleEpisodeDAO.self ],
                config: .init(inMemory: true,
                              configurationName: "swiftui-previews.sqlite"))
   }
}
#endif
