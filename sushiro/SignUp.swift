import UIKit
import AVFoundation
import RealmSwift
class SignUp: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var addTimer = Timer()
    var timerCount = 0
    var flag:[Bool] = [false,false,false]
    //let appDelegate = UserSetting.appDelegate
    let textfield = MakeTextField()
    var logInData = LogInData()
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
        //textFIeldの位置を指定
        textfield.make(x: 100, y: 250, width: 500,height: 40, tag: 1, _placeholder: "名前を入力してください" , view: self)
        textfield.make(x: 100, y: 350, width: 500, height: 40, tag: 2, _placeholder: "住所" ,_keyboardType:UIKeyboardType.default, view: self)
        textfield.make(x: 100, y: 450, width: 500, height: 40, tag: 3, _placeholder: "電話番号" ,_keyboardType:UIKeyboardType.phonePad, view: self)
        textfield.make(x: 100, y: 550, width: 500, height: 40, tag: 4, _placeholder: "メールアドレス" ,_keyboardType:UIKeyboardType.emailAddress, view: self)
        textfield.make(x: 100, y: 650, width: 500, height: 40, tag: 5, _placeholder: "パスワード" ,_keyboardType:UIKeyboardType.default, view: self)
        label.make(x: 30, y: 200, width: 200, height: 40, back: UIColor.white, _text:"名前" , _fontSize: 20 ,view: self)
        label.make(x: 30, y: 300, width: 200, height: 40, back: UIColor.white, _text:"住所", _fontSize: 20, view: self)
        label.make(x: 35, y: 400, width: 200, height: 40, back: UIColor.white, _text:"電話番号", _fontSize: 20, view: self)
        label.make(x: 63, y: 500, width: 200, height: 40, back: UIColor.white, _text:"メールアドレス", _fontSize: 20, view: self)
        label.make(x: 55, y: 600, width: 200, height: 40, back: UIColor.white, _text:"パスワード", _fontSize: 20, view: self)
        button.make(x: 700, y: 200, width: 300, height: 100, back: UIColor.white, tag: 1, _borderWidth:1.5,_cornerRadius:10,_text: "リセット" , view: self)
        button.make(x: 700, y: 500, width: 300, height: 100, back: UIColor.white, tag: 2, _borderWidth:1.5,_cornerRadius:10,_text: "登録" , view: self)
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
            textfield.text = ""
            logInData.name = ""
            logInData.address = ""
            logInData.phone = ""
            logInData.mailAddress = ""
            logInData.password = ""
            viewDidLoad()
            audioPlayerInstance.play()
        case 2:
            if logInData.name.isEmpty || logInData.address.isEmpty || logInData.phone.isEmpty || logInData.mailAddress.isEmpty || logInData.password.isEmpty {
                //ポップアップ表示
                let popUp = MakePopUp()
                popUp.alert(title: "未入力があります", view: self)
                break
            }
            let realm = try! Realm()
            let obj = realm.objects(LogInData.self).last
            try! realm.write {
                obj!.name = logInData.name
                obj!.address = logInData.address
                obj!.phone = logInData.phone
                obj!.mailAddress = logInData.mailAddress
                obj!.password = logInData.password
            }
            try! realm.write {
                realm.add(LogInData())
            }
            print(realm.objects(LogInData.self))
            view.viewSet(view: self, transition: Ticket())
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
            logInData.name = textField.text!
        case 2:
            logInData.address = textField.text!
        case 3:
            logInData.phone = textField.text!
        case 4:
            logInData.mailAddress = textField.text!
        case 5:
            logInData.password = textField.text!
        default:
            break
        }
        return true
    }
}
