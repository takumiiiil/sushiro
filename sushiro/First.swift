import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import RealmSwift

class First: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景を設定
        let background = MakeBackgroundImage()
        self.view.addSubview(background.make(image:"first.jpeg"))
        
        //クラスをインスタンス化
        let button = MakeButton()
        audioPlayerInstance.prepareToPlay()
    
        //透明なボタンを作ってタップを反応させる
        self.view.addSubview(button.make(x:0,y:0,width:1024,height:768,back:UIColor.clear,tag:0))
     
    }

    @objc func selection(sender: UIButton){
        let view = viewSetting()
        switch sender.tag{
            case 0:
                let date = Date()
                let dateAndTime = date.formattedDateWith(style: .time)
                let realm = try! Realm()
                let obj = realm.objects(guestData.self).last
                try! realm.write {
                    obj?.inTime = dateAndTime
                }
                view.viewSet(view: self, transition: ViewController())
                audioPlayerInstance.play()
            default:break
        }
    }
    override func viewDidAppear(_ animated: Bool){
        loadView()//videoplayerを破棄 画面遷移なしで
        viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        print("メモリ使いすぎ")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
