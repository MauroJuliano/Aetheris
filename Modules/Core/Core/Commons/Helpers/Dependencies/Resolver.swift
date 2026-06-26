import Foundation

protocol DependencyResolving {
    func resolve<Service>() -> Service
}

final class Resolver: DependencyResolving {
    
    static let shared = Resolver()
    
    private var services: [String: Any] = [:]
    
    private init() {}
    
    func register<Service>(_ type: Service.Type, factory: @escaping () -> Service) {
        services[String(describing: type)] = factory
    }
    
    func resolve<Service>() -> Service {
        guard let factory = services[String(describing: Service.self)] as? () -> Service else {
            fatalError("Service not registered: \(Service.self)")
        }
        return factory()
    }
}
