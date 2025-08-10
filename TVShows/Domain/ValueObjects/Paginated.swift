import Foundation

struct Page<T>: Sendable, Equatable, Hashable where T: (Sendable & Equatable & Hashable) {
   let items: [T]
   let pageIndex: Int
   let hasNextPage: Bool
}
