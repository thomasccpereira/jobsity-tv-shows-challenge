import Foundation

// Definition
typealias CoordinatablePathDefinition = Hashable & Equatable

// Protocol
protocol RequiresCoordinatablePathEnum {
   associatedtype Paths: CoordinatablePathDefinition
}
