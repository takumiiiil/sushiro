import UIKit

class viewSetting{
    
    func viewSet(view:AnyObject,transition:AnyObject,_anime:bool = false,_animation:UIModalTransitionStyle = .flipHorizontal) {
        let SViewController: UIViewController = transition
        //アニメーションを設定する.
        SViewController.modalTransitionStyle = _animation
        //Viewの移動する.
        SViewController.modalPresentationStyle = .fullScreen
        view.present(view: SViewController,  animated: _anime, completion: nil)
    }
}
