
import UIKit
import AVFoundation
import RealmSwift
class CheckIn: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var addTimer = Timer()
    var timerCount = 0
    var flag:[Bool] = [false,false,false]
    //let appDelegate = UserSetting.appDelegate
    let textfield = MakeTextField()
    var loginData = LogInData()
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景を設定
        let background = MakeBackgroundImage()
        self.view.addSubview(background.make(image:"hakken2"))
        //クラスをインスタンス化
        audioPlayerInstance.prepareToPlay()
        let button = MakeButton()
        let label = MakeLabel()
        // UITextFieldを生成
        button.make(x: 200, y: 400, width: 300, height: 100, back: UIColor.white, tag: 1, _borderWidth:1.5,_cornerRadius:10,_text: "登録済み" , view: self)
        button.make(x: 700, y: 400, width: 300, height: 100, back: UIColor.white, tag: 2, _borderWidth:1.5,_cornerRadius:10,_text: "新規登録" , view: self)
        button.make(x:30,y:700,width:100,height:50,back:UIColor.white,tag:3, _borderWidth:1.5,_cornerRadius:6,_text:"戻る", _fontSize:50,view:self)
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    //ボタンイベント
    @objc func selection(sender: UIButton){
        let view = viewSetting()
        switch sender.tag{
        case 1:
            view.viewSet(view: self, transition: LogIn())
            audioPlayerInstance.play()
        case 2:
            view.viewSet(view: self, transition: SignUp())
            audioPlayerInstance.play()
        case 3:
            view.viewSet(view: self, transition: Ticket())
            audioPlayerInstance.play()
        case 18:
            if flag[0] && flag[1] && flag[2] {
                for i in 0...2{
                    flag[i] = false
                }
                appDelegate.maskFlag = 100
                appDelegate.maskFlag2 = 100
                appDelegate.maskFlag3 = 100
                view.viewSet(view: self, transition: First())
                audioPlayerInstance.play()
            }else{
                //ポップアップ表示
                let popUp = MakePopUp()
                popUp.alert(title: "未入力があります", view: self)
            }
        case 19:
            for i in 0...2{
                flag[i] = false
            }
            appDelegate.maskFlag = 100
            appDelegate.maskFlag2 = 100
            appDelegate.maskFlag3 = 100
            view.viewSet(view: self, transition: Ticket())
        default:break
        }
    }
    //Doneが押されれた時の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField.tag {
        case 1:
            loginData.name = textField.text!
        case 2:
            loginData.address = textField.text!
        case 3:
            loginData.phone = textField.text!
        case 4:
            loginData.mailAddress = textField.text!
        case 5:
            loginData.password = textField.text!
        default:
            break
        }
        return true
    }
}
