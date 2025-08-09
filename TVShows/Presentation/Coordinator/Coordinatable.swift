import Foundation

// Definition
typealias CoordinatableDefinition = BaseCoordinatable & RequiresCoordinatablePathEnum & ObservableObject

// Protocol
@MainActor
protocol Coordinatable: CoordinatableDefinition where Paths: CoordinatablePathDefinition {
   var paths: [Paths] { get set }
   
   func start()
   func pop()
   func popToRoot()
}

// Default implementation
extension Coordinatable {
   // Init
   func start() {
      assertionFailure("Start method must be implemented when conforming Coordinatable protocol.")
   }
   
   // Navigation
   // Pop
   func pop() {
      paths.removeLast()
   }
   // Pop to root
   func popToRoot() {
      paths.removeAll()
   }
}
