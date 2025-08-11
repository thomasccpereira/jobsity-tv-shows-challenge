#if DEBUG
extension DatabaseStore {
   static var preview: Self {
      try! .init(models: [ SingleShowDAO.self ],
                config: .init(inMemory: true,
                              configurationName: "swiftui-previews.sqlite"))
   }
}
#endif
