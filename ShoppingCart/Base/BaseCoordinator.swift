//
//  BaseCoordinator.swift
//  ShoppingCart
//

import Combine
import Foundation

class BaseCoordinator<ResultType>: NSObject {
    
    typealias CoordinationResult = ResultType
    var subscribers = Set<AnyCancellable>()
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()
    
    override init() {
        super.init()
    }
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> AnyPublisher<T, Never> {
        store(coordinator: coordinator)
        return coordinator.start()
            .receive(on: DispatchQueue.main)
            .prefix(1)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.free(coordinator: coordinator)
            })
            .eraseToAnyPublisher()
    }
    
    @discardableResult
    func start() -> AnyPublisher<ResultType, Never> {
        fatalError("Start method should be implemented.")
    }
}
