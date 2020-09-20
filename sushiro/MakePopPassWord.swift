import UIKit

class MakePopPassWord:UIAlertController{
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func make(title:String,pass:String,_message:String)->UIAlertController{
        let alert: UIAlertController!
        alert = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
 
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            // OKを押した時入力されていたテキストを表示
            if let textFields = alert.textFields {
                // アラートに含まれるすべてのテキストフィールドを調べる
                for textField in textFields {
                    if textField.text! == pass{
                        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
                        appDelegate.window?.rootViewController = Accounting()
                        appDelegate.window?.makeKeyAndVisible()
                    }else if textField.text! != pass{
                        print("passNG")
                        let pop = MakePopUp()
                        self.present(pop.alert(title: "hoge", _message: "hogehoge"), animated: true)
                        /* self.present(ngalert, animated: true, completion: {
                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                         ngalert.dismiss(animated: true, completion: nil)
                         })*/
               
                    }
                }
                
            }
           
        })
        alert.addAction(okAction)
        
        // キャンセルボタンの設定
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        // テキストフィールドを追加
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "パスワード"
            textField.isSecureTextEntry = true
        })
        return(alert)
       
    }
    
    
}
