import Foundation

protocol DataAccessibleObject {
   associatedtype DomainModel
   var domainModelObject: DomainModel { get }
}
