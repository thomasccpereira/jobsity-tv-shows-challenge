import Foundation

protocol DataTransferableObjects {
   associatedtype DomainModel
   var domainModelObject: DomainModel { get }
}
