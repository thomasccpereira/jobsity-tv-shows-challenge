import Foundation

struct SwiftDataStoreConfig: Sendable {
   var inMemory: Bool
   var configurationName: String?
   
   init(inMemory: Bool = false, configurationName: String? = nil) {
      self.inMemory = inMemory
      self.configurationName = configurationName
   }
}
