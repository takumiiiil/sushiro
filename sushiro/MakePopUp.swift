import UIKit

class MakePopUp:UIAlertController{
    
        func alert(title:String, _message:String)->UIAlertController{
            let alertController: UIAlertController!
            alertController = UIAlertController(title: title,message:_message,preferredStyle: .alert)
            return(alertController)
        }
}
