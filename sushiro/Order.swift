
import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import RealmSwift

class Order: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var myTabBar:UITabBar!
    var selectView: UIView! = nil
    var image0: UIImageView!
    var count = 0
    var count2 = 0
    var i = 0
    var name = ""
    var label2: UILabel!
    var addTimer = Timer()
    var timerCount = 0
    
    //タイマー
    @objc func timerCall() {
        viewDidLoad()
        // タイマーを無効にする
        addTimer.invalidate()
    }

    //画像の設定
    func imageSetteng(picture:String){
        // 画像を設定する.
        let myInputImage = CIImage(image: UIImage(named: picture)!)
        // ImageViewを.定義する.
        var myImageView: UIImageView!
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: UIScreen.main.bounds)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
    }
    
    //ボタン作成
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = MakeBackgroundImage()
        self.view.addSubview(background.make(image:"order.jpeg"))
        
        audioPlayerInstance.prepareToPlay()
       
        //クラスをインスタンス化
        let label = MakeLabel()
        let button = MakeButton()
      
        //1,2,3作成
        for i in 0...2{label.make(x:50,y:CGFloat(280+i*60),width:60,height:60,back:UIColor.clear,_borderWidth:1.5,_text:"\(i+1)",_fontSize:50,_alignment:NSTextAlignment.center,view:self)}
        //商品名作成
        for i in 0...2{button.make(x:110,y:CGFloat(280+i*60),width:200,height:60,back:UIColor.clear,tag:13,_borderWidth:1.5,_text:"\(appDelegate.box[i].name)",_fontSize:35,_alignment:NSTextAlignment.left,view:self)}
        //数量作成
        for i in 0...2{label.make(x:310,y:CGFloat(280+i*60),width:60,height:60,back:UIColor.clear,_borderWidth:1.5,_text:"\(appDelegate.box[i].qty)",_fontSize:50,_alignment:NSTextAlignment.center,view:self)}
        //上部タグ作成
        for k in 0...8{button.make(x:CGFloat(5+(80*k)),y:5,width:80,height:70,back:UIColor.white,tag:16+k,_borderWidth:1.5, _cornerRadius:6,_text:appDelegate.tag1[k], _fontSize:20,view:self)}
        //下部タグ作成
        let tag_flag1 = appDelegate.choise
        for d in 0..<appDelegate.data[tag_flag1].count{button.make(x:CGFloat(5+(115*d)),y:90,width:110,height:70,back:UIColor.white,tag:25+d,_borderWidth:1.5, _cornerRadius:6,_text:appDelegate.tag2[tag_flag1][d], _fontSize:25,view:self)}
        
        button.make(x:30,y:700,width:100,height:50,back:UIColor.white,tag:1,_borderWidth:1.5, _cornerRadius:6,_text:"戻る", _fontSize:20,view:self)
        button.make(x:550,y:210,width:170,height:100,back:UIColor.white,tag:18,_borderWidth:1.5, _cornerRadius:6,_text:"注文する", _fontSize:20,view:self)
       
        //+-ボタン作成
        for i in 0...2{
            if appDelegate.box[i].name != ""{
                button.make(x:390,y:CGFloat(280+i*60),width:60,height:50,back:UIColor.white,tag:i*2+2,_pic:"button",_cornerRadius:3,_text:"+",_textColer:UIColor.white,_fontSize:25,view:self)
                button.make(x:460,y:CGFloat(280+i*60),width:60,height:50,back:UIColor.white,tag:i*2+3,_pic:"button",_cornerRadius:3,_text:"-",_textColer:UIColor.white,_fontSize:25,view:self)
            }
        }
        //メッセージ（合計)
        label.make(x:190,y:460,width:120,height:60,back:UIColor.red,_borderWidth:1.5,_text:"合計",_fontSize:50,_alignment:NSTextAlignment.center,view:self)
        //数量用（合計)
        label.make(x:310,y:460,width:60,height:60,back:UIColor.clear,_borderWidth:1.5,_text:"\(appDelegate.box[0].qty + appDelegate.box[1].qty + appDelegate.box[2].qty)",_fontSize:50,_alignment:NSTextAlignment.center,view:self)
    }
    
    //ボタンイベント処理
    @objc func selection(sender: UIButton){
        let view = viewSetting()
        switch sender.tag{
        case 1://戻ボタン
            self.present(view.viewSet(view: ViewController(), anime: .flipHorizontal), animated: false, completion: nil)
            audioPlayerInstance.play()
        case 2:// 一種類目+ボタン
            i = 0
            if appDelegate.box[i].qty < 4{
                appDelegate.box[i].qty =  appDelegate.box[i].qty+1
                viewDidLoad()
                audioPlayerInstance.play()
            }else if appDelegate.box[i].qty == 4{
                imageSetteng(picture: "over.jpg")
                audioPlayerInstance.play()
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 3:// 一種類目−ボタン
            i = 0
            if  appDelegate.box[i].qty != 0 && appDelegate.box[i].qty > 0{
                appDelegate.box[i].qty =  appDelegate.box[i].qty-1
            }
            viewDidLoad()
            audioPlayerInstance.play()
        case 4:// 2種類目+ボタン
            i = 1
            if appDelegate.box[i].qty < 4{
                appDelegate.box[i].qty =  appDelegate.box[i].qty+1
                viewDidLoad()
                audioPlayerInstance.play()
            }else if appDelegate.box[i].qty == 4{
                imageSetteng(picture: "over.jpg")
                audioPlayerInstance.play()
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 5:// 2種類目−ボタン
            i = 1
            if  appDelegate.box[i].qty != 0 && appDelegate.box[i].qty > 0{
                appDelegate.box[i].qty =  appDelegate.box[i].qty-1
            }
            viewDidLoad()
            audioPlayerInstance.play()
        case 6:// 3種類目+ボタン
            i = 2
            if appDelegate.box[i].qty < 4{
                appDelegate.box[i].qty =  appDelegate.box[i].qty+1
                viewDidLoad()
                audioPlayerInstance.play()
            }else if appDelegate.box[i].qty == 4{
                imageSetteng(picture: "over.jpg")
                audioPlayerInstance.play()
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 7:// 3種類目−ボタン
            i = 2
            if  appDelegate.box[i].qty != 0 && appDelegate.box[i].qty > 0{
                appDelegate.box[i].qty =  appDelegate.box[i].qty-1
            }
            viewDidLoad()
            audioPlayerInstance.play()
        case 13://商品名(1段目)
            i = 0
            appDelegate.countType[0].now = "on"
            appDelegate.countType[1].now = "off"
            appDelegate.countType[2].now = "off"
            viewDidLoad()
        case 14://商品名(2段目)
            i = 1
            appDelegate.countType[0].now = "off"
            appDelegate.countType[1].now = "on"
            appDelegate.countType[2].now = "off"
            viewDidLoad()
        case 15://商品名(3段目)
            i = 2
            appDelegate.countType[0].now = "off"
            appDelegate.countType[1].now = "off"
            appDelegate.countType[2].now = "on"
            viewDidLoad()
        case 18://注文
            appDelegate.dishSum += appDelegate.box[0].qty + appDelegate.box[1].qty + appDelegate.box[2].qty
            appDelegate.qrString = "注文は\(appDelegate.dishSum)皿で会計金額は\(appDelegate.dishSum * 110)円です"
            for i in 0...2{
                if "\(appDelegate.box[i].name)" != ""{
                    let history = (name:"\(appDelegate.box[i].name)", num:appDelegate.box[i].qty)
                    appDelegate.history.append(history)
                }
            }

            //realm　皿数
            let realm = try! Realm()
            let dishCount = realm.objects(guestData.self).last
            try! realm.write {
                dishCount!.dish = appDelegate.dishSum
            }
            imageSetteng(picture: "end.jpg")
            appDelegate.countType = [(0,""),(0,""),(0,"")]
            appDelegate.box = [("",0,"kara.png"),("",0,"kara.png"),("",0,"kara.png")]
            i = 0
            audioPlayerInstance.play()
            //遅延処理
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.present(view.viewSet(view: ViewController(), anime: .flipHorizontal), animated: false, completion: nil)
            }
        default:break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
