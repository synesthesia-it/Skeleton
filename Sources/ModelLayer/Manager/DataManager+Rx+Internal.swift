import RxSwift
import Gloss
import Moya

extension Reactive where Base: MoyaProviderType {
    private func customRequest(_ token: Base.Target) -> Observable<Response> {
        return self
            .request(token)
            .asObservable()
            .mapResponseError()
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
