import Foundation

struct Page<T>: Sendable, Equatable where T: (Sendable & Equatable) {
   let items: [T]
   let pageIndex: Int
   let hasNextPage: Bool
}
