import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import CoreImage
import RealmSwift

var k = 0
var j = 0
var l = 0

class ViewController: UIViewController ,selection{
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let myInputImage = CIImage(image: UIImage(named: "top.jpeg")!) // 画像を設定する.
    var myImageView: UIImageView! // ImageViewを.定義する.
    var addTimer = Timer()
    let menuArray = [["set","ikura","ikura"],["nigiri1","nigiri2","gunkan"],["side","deza","drink"],["開発者モード","会計確認   注文履歴","店員呼出"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //クラスをインスタンス化
        let button = MakeButton()
        
        audioPlayerInstance.prepareToPlay()
        
        addTimer =  Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(play), userInfo: nil, repeats: false)
        myImageView = UIImageView(frame: UIScreen.main.bounds)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        
        for i in 0...3{
            for j in 0...2{
                if i == 3{
                    self.view.addSubview(button.make(x:CGFloat(80+j*300),y:645,width:280,height:110,back:UIColor.white,tag:i*3+j,_borderWidth:1.5,_cornerRadius:10,_text:menuArray[i][j],_fontSize:35))
                }else{
                   self.view.addSubview(button.make(x:CGFloat(80+j*300),y:CGFloat(160+i*140),width:280,height:180,back:UIColor.clear,tag:i*3+j,_pic:menuArray[i][j]))
                }
            }
        }
    }
    
    func playMovieFromUrl(movieUrl: URL?) {
        if let movieUrl = movieUrl {
            let videoPlayer = AVPlayer(url: movieUrl)
            let playerController = AVPlayerViewController()
            playerController.player = videoPlayer
            self.present(playerController, animated: true, completion: {
                videoPlayer.play()
            })
        } else {
            print("cannot play")
        }
    }
    
    func playMovieFromPath(moviePath: String?) {
        if let moviePath = moviePath {
            self.playMovieFromUrl(movieUrl: URL(fileURLWithPath: moviePath))
        } else {
            print("no such file")
        }
    }
    
    @objc func playMovieFromBundleFile() {
        let bundleDataName: String = "\(appDelegate.movieNum)"
        let bundleDataType: String = "mp4"
        
        //MovieApp_iOS -> Build Phases -> Copy Bundle Resources 内にbundle.mp4を追加
        let moviePath: String? = Bundle.main.path(forResource: bundleDataName, ofType: bundleDataType)
        playMovieFromPath(moviePath: moviePath)
        addTimer.invalidate()
    }
    
    @objc func play(){
        //これでタイマー切
        addTimer.invalidate()
        // パスからassetを生成.
        let path = Bundle.main.path(forResource:  "\(appDelegate.movieNum)", ofType: "mp4")
        let fileURL = NSURL(fileURLWithPath: path!)
        let avAsset = AVAsset(url: fileURL as URL)
        // AVPlayerに再生させるアイテムを生成.
        let playerItem = AVPlayerItem(asset: avAsset)
        // AVPlayerを生成.
        let videoPlayer = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayer.volume = appDelegate.volumeV
        
        // 変える実装
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            do{
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setMode(AVAudioSession.Mode.videoChat)
                try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                try audioSession.setActive(true)
            }catch _ as NSError{
                print("NSError")
            }
        }
        
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //サイズを決める
        playerLayer.frame = CGRect(x:0, y:0, width:1024, height:768)
        self.view.layer.addSublayer(playerLayer)
        // 動画が再生し終わったことを監視する設定
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        //透明なボタンを作ってタップを反応させる
        let button: UIButton = UIButton(frame: CGRect(x:CGFloat(0), y:CGFloat(0), width: CGFloat(1024), height: CGFloat(768)))
        button.tag = 20
        button.addTarget(self, action: #selector(selection(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        videoPlayer.play()
        
    }
    
    @objc func playerDidFinishPlaying(notification: NSNotification) {
        play()
    }
    
    @objc func selection(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = viewSetting()
        if sender.tag <= 8{
            k = sender.tag
        }
        switch sender.tag{
        case 9:
            addTimer.invalidate()
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            appDelegate.window?.rootViewController = Test()
            appDelegate.window?.makeKeyAndVisible()
            audioPlayerInstance.play()
        case 10:
            addTimer.invalidate()
            self.present(view.viewSet(view: History(), anime: .flipHorizontal), animated: false, completion: nil)
            audioPlayerInstance.play()
        case 11:
            addTimer.invalidate()
            self.present(view.viewSet(view: Call(), anime: .flipHorizontal), animated: false, completion: nil)
            audioPlayerInstance.play()
        case 20://動画再生中のタップ
            addTimer.invalidate()
            loadView()//videoplayerを破棄 画面遷移なしで
            viewDidLoad()
            audioPlayerInstance.play()
        case k://メニュー
            appDelegate.choise = k
            addTimer.invalidate()
            self.present(view.viewSet(view: Menu(), anime: .flipHorizontal), animated: false, completion: nil)
            audioPlayerInstance.play()
        default:break
        }
    }
    
    override func viewDidAppear(_ animated: Bool){
        addTimer.invalidate()
        loadView()//videoplayerを破棄 画面遷移なしで
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        print("メモリ使いすぎ")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
