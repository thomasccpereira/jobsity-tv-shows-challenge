#if DEBUG
extension DatabaseStore {
   static var preview: Self {
      try! .init(models: DatabaseStore.databaseModels,
                config: .init(inMemory: true,
                              configurationName: "swiftui-previews.sqlite"))
   }
}
#endif
