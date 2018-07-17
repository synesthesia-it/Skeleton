import Moya
import RxSwift
import Gloss

class DataManager : ReactiveCompatible {
    static let provider = MoyaProvider<API>(plugins: DataManager.customPlugins())
}
