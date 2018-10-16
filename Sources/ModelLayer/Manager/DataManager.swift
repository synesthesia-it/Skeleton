import Moya
import RxSwift
import Gloss

public class DataManager: ReactiveCompatible {
    static var provider = MoyaProvider<API>(plugins: DataManager.customPlugins())
    static let dispatchScheduler = SerialDispatchQueueScheduler.init(qos: .utility)
}
