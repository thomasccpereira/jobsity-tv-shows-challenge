import Foundation

struct Envelope<T>: Sendable, Equatable, Hashable where T: (Sendable & Equatable & Hashable) {
   let model: T?
   let errorMessage: String?
   
   init(model: T? = nil,
        errorMessage: String? = nil) {
      self.model = model
      self.errorMessage = errorMessage
   }
}
