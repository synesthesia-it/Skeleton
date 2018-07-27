import Foundation
import Boomerang
import UIKit
import MediaPlayer
import AVKit

struct Router: RouterType {
    public static func root() -> UIViewController {
        let vm = SplashViewModel()
        return vm.sceneIdentifier
            .scene?
            .setup(with: vm)
            ?? UIViewController()
    }
        
    public static func start(_ delegate: AppDelegate) {
        
        delegate.window = UIWindow(frame: UIScreen.main.bounds)
        delegate.window?.rootViewController = self.root()
        
        delegate.window?.makeKeyAndVisible()
        
    }

    public static func rootController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    public static func restart() {
        UIApplication.shared.keyWindow?.rootViewController = Router.root()
    }
    
    public static func from<Source> (_ source: Source, viewModel: ViewModelType) -> RouterAction where Source: UIViewController {

        switch viewModel {
            
        case let viewModel as ActionSheetViewModel :
            let destination = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .actionSheet)
            viewModel.actions().forEach { destination.addAction($0)}
            return UIViewControllerRouterAction.modal(source: source, destination: destination, completion: nil)
            
        case let viewModel as SystemImagePickerViewModel :
            return UIViewControllerRouterAction.custom {
                UIImagePickerController.rx.createWithParent(source, animated: true, configureImagePicker: { (picker) in
                    #if targetEnvironment(simulator)
                    picker.sourceType = .photoLibrary
                    #else
                    switch viewModel.type {
                    case .camera : picker.sourceType = .camera
                    case .library : picker.sourceType = .photoLibrary
                    }
                    #endif
                })
                    .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                    .take(1)
                    
                    .map { info in
                        return info[UIImagePickerControllerOriginalImage] as? UIImage
                    }
                    .subscribe(onNext: { image in
                        viewModel.relay.accept([image ?? (UIImage())])
                    }).disposed(by: source.disposeBag)
            }
        case let viewModel as SceneViewModelType :
            if let destination = viewModel.sceneIdentifier.scene?.setup(with: viewModel) {
                if source is SplashViewController {
                    return UIViewControllerRouterAction.replaceRootWith(destination: destination.withNavigation())
                }
                if viewModel is PickerItemViewModelType {
                    return UIViewControllerRouterAction.modal(source: source, destination: destination.withNavigation(), completion: nil)
                }
                
                if viewModel.isModal {
                    return UIViewControllerRouterAction.modal(source: source, destination: destination.withNavigation(), completion: nil)
                }
                
                return UIViewControllerRouterAction.push(source: source, destination: destination)
            }
        default: break
        }
        return EmptyRouterAction()
    }

}
