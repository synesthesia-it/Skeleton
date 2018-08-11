import RxSwift
import Gloss
import Moya

extension Reactive where Base: MoyaProviderType {
    private func customRequest(_ token: Base.Target) -> Observable<Response> {
        return self
            .request(token)
            .asObservable()
            .mapResponseError()
            .observeOn(DataManager.dispatchScheduler)
    }
    internal func request<T: JSONDecodable>(_ token: Base.Target, keyPath: String? = nil) -> Observable<T> {
        guard let keyPath = keyPath else {
            return customRequest(token).mapObject(type: T.self)
        }
        return customRequest(token).mapObject(type: T.self, forKeyPath: keyPath)
    }
    internal func request<T: JSONDecodable>(_ token: Base.Target, keyPath: String? = nil) -> Observable<[T]> {
        guard let keyPath = keyPath else {
            return customRequest(token).mapArray(type: T.self)
        }
        return customRequest(token).mapArray(type: T.self, forKeyPath: keyPath)
    }
}

extension DataManager {
    static func customPlugins() -> [PluginType] {
        var array: [PluginType] = []
        let f:(_ separator: String, _ terminator: String, _ items: Any...) -> Void = { (separator: String, terminator: String, items: Any...) -> Void in
            let string = Array(items).compactMap { $0 as? String}.joined(separator: separator) + terminator
            Logger.log(string, level: .network)
            return
        }
        array = [NetworkLoggerPlugin(verbose: true, cURL: true, output: f)]
        return array
    }
}
