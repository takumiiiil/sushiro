import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import RealmSwift

class History: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var addTimer = Timer()
    var timerCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //背景を設定
        let background = MakeBackgroundImage()
        self.view.addSubview(background.make(image:"history"))
        
        // 再生準備
        audioPlayerInstance.prepareToPlay()
        //クラスをインスタンス化
        let button = MakeButton()
        let label = MakeLabel()        
        
        let scrollView = MakeScrollView()
        scrollView.make(x:0,y:150,width:Int(view.frame.width/2),height:540,contentHeight:50*(appDelegate.history.count+5),view: self)
               
        scrollView.makeLabel(x:40,y:15,width:300,height:40,back:UIColor.clear,_text:"商品名",_fontSize:35,view: self)
        scrollView.makeLabel(x:420,y:15,width:80,height:40,back:UIColor.clear,_text:"数量",_fontSize:35,view: self)
        
        if appDelegate.history.count != 0 {
            for i in 0...appDelegate.history.count-1 {
                // UIScrollViewに追加
                scrollView.makeLabel(x:40,y:CGFloat(55+(i*50)),width:300,height:40,back:UIColor.clear,_text:appDelegate.history[i].name,_fontSize:35,_alignment:NSTextAlignment.left,view: self)
                scrollView.makeLabel(x:420,y:CGFloat(55+(i*50)),width:80,height:40,back:UIColor.clear,_text:"\(appDelegate.history[i].num)",_fontSize:35,view: self)
            }
        }
        scrollView.makeLabel(x:40,y:CGFloat(Int(scrollView.contentSize.height)-150),width:80,height:40,back:UIColor.clear,_text:"小計",_fontSize:35,_alignment:NSTextAlignment.left,view: self)
        scrollView.makeLabel(x:40,y:CGFloat(Int(scrollView.contentSize.height)-100),width:80,height:40,back:UIColor.clear,_text:"消費税",_fontSize:35,_alignment:NSTextAlignment.left,view: self)
        scrollView.makeLabel(x:40,y:CGFloat(Int(scrollView.contentSize.height)-50),width:80,height:40,back:UIColor.clear,_text:"合計",_fontSize:35,_alignment:NSTextAlignment.left,view: self)
       
        //ボタン作成
        button.make(x:750,y:600,width:100,height:50,back:UIColor.white,tag:0, _borderWidth:1.5,_cornerRadius:6,_text:"戻る",_adjustsFontSizeToFitWidth:true,view: self)
         button.make(x:700,y:250,width:200,height:50,back:UIColor.white,tag:1, _borderWidth:1.5,_cornerRadius:6,_text:"スタッフ呼出",_adjustsFontSizeToFitWidth:true,view: self)
         button.make(x:700,y:500,width:200,height:50,back:UIColor.white,tag:2, _borderWidth:1.5,_cornerRadius:6,_text:"会計に進む",_adjustsFontSizeToFitWidth:true,view: self)
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
    //ボタンイベント
    @objc func selection(sender: UIButton){
        let view = viewSetting()
        switch sender.tag{
        case 0:
            self.present(view.viewSet(view: ViewController(), anime: .flipHorizontal), animated: false, completion: nil)
            audioPlayerInstance.play()
        case 1:
            self.present(view.viewSet(view: Reception(), anime: .flipHorizontal), animated: false, completion: nil)
            audioPlayerInstance.play()
        case 2:
            self.present(view.viewSet(view: Reception(), anime: .flipHorizontal), animated: false, completion: nil)
            audioPlayerInstance.play()
        default:break
        }
    }
}
