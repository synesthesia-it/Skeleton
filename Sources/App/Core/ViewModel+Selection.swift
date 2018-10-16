import RxSwift
import Action
import UIKit
import Boomerang

enum SelectionValue {
    case start
    case reload
    case restart
    case openURL(URL)
    case model(ModelType)
    case viewModel(ViewModelType)
    case item(IndexPath)
    case invalidateLayout
    case dismiss
    case back
    case openPicker
}

typealias SelectionInput = SelectionValue
typealias SelectionOutput = SelectionValue
typealias Selection = Action<SelectionInput, SelectionOutput>

protocol SelectableViewModelType: ViewModelType {
    var selection: Selection { get }
}

extension Action where Input == SelectionInput, Element == SelectionOutput {
    var viewModels: Observable<ViewModelType> {
        return elements.map { out -> ViewModelType? in
            switch out {
            case .viewModel(let vm) : return vm
            default: return nil
            }
        }
        .ignoreNil()
    }
}

extension SelectableViewModelType {
    
    func baseSwitch(input: SelectionInput) -> Observable<SelectionOutput>? {
        
        switch input {
        case .openPicker :
            if let picker = self as? SceneViewModelType {
                return .just(.viewModel(picker))
            }
        default: return .just(input)
            
        }
        return nil
    }
    
    func generateSelection() -> Selection {
        return Selection {[weak self] input in
            return self?.baseSwitch(input: input) ?? .empty()
        }
    }
}
