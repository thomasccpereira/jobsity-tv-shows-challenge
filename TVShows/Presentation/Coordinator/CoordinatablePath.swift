import Foundation

// Definition
typealias CoordinatablePathDefinition = CaseIterable & Hashable & Equatable

// Protocol
protocol RequiresCoordinatablePathEnum {
   associatedtype Paths: CoordinatablePathDefinition
}
