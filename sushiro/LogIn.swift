import UIKit
import AVFoundation
import RealmSwift

class LogIn: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var addTimer = Timer()
    var timerCount = 0
    var flag:[Bool] = [false,false,false]
    //let appDelegate = UserSetting.appDelegate
    let textfield = MakeTextField()
    var loginData = LogInData()
    var mailAddress = ""
    var password = ""
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
        textfield.make(x: 100, y: 300, width: 500, height: 40, tag: 1 ,view: self)
        textfield.make(x: 100, y: 400, width: 500, height: 40, tag: 2, _placeholder: "パスワード" ,_keyboardType:UIKeyboardType.default,view: self)
        button.make(x:30,y:700,width:100,height:50,back:UIColor.white,tag:3, _borderWidth:1.5,_cornerRadius:6,_text:"戻る", _fontSize:50,view:self)
        label.make(x: 63, y: 500, width: 200, height: 40, back: UIColor.white, _text:"メールアドレス", _fontSize: 20, view: self)
        label.make(x: 55, y: 600, width: 200, height: 40, back: UIColor.white, _text:"パスワード", _fontSize: 20, view: self)
        button.make(x: 700, y: 200, width: 300, height: 100, back: UIColor.white, tag: 1, _borderWidth:1.5,_cornerRadius:10,_text: "リセット" , view: self)
        button.make(x: 700, y: 500, width: 300, height: 100, back: UIColor.white, tag: 2, _borderWidth:1.5,_cornerRadius:10,_text: "登録" , view: self)
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
            viewDidLoad()
            audioPlayerInstance.play()
        case 2:
            if mailAddress.isEmpty || password.isEmpty {
                //ポップアップ表示
                let popUp = MakePopUp()
                popUp.alert(title: "未入力があります", view: self)
                break
            }
            let realm = try! Realm()
            let obj = realm.objects(LogInData.self)
            for i in 0...obj.count-1{
                if obj[i].mailAddress == mailAddress && obj[i].password == password{
                    view.viewSet(view: self, transition: Accounting())
                    break
                }
            }
            let popUp = MakePopUp()
            popUp.alert(title: "アドレスかパスワードが間違っています", view: self)
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
            mailAddress = textField.text!
        case 2:
            password = textField.text!
        default:
            break
        }
        return true
    }
}











