import Foundation

// MARK: - BaseCoordinatable
// Base protocol without actor isolation
protocol BaseCoordinatable: Equatable, Identifiable, Hashable {
    var id: String { get }
}

// Default implementation
extension BaseCoordinatable {
   static func ==(lhs: Self, rhs: Self) -> Bool {
      lhs.id == rhs.id
   }
   
   var id: String {
      String(describing: self)
   }
   
   func hash(into hasher: inout Hasher) {
      hasher.combine(self.id)
   }
}
