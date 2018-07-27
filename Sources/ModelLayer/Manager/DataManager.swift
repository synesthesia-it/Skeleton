import Moya
import RxSwift
import Gloss

public class DataManager : ReactiveCompatible {
    static let provider = MoyaProvider<API>(plugins: DataManager.customPlugins())
}
