import UIKit
import RealmSwift

class MakeCalculator:UIViewController{
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var tenkey:[[String]] = [[("1"),("2"),("3")],[("4"),("5"),("6")],[("7"),("8"),("9")]]
    var inputNum:String = ""
    var change:String = ""
    var warning:String = ""
    var calculation:Int = 0
    //年齢層用
    var generation:String = ""
    let genArray : [String] = ["12歳以下男性","12歳以下女性","13-19歳男性","13-19歳女性","20-29歳男性","20-29歳女性","30-49歳男性","30-49歳女性","50歳以上男性","50歳以上女性"]
    
    
  func make(view:AnyObject){
  
    //テンキー用
   print("makeにきてる")
   print(String(describing: type(of: view)))
    let realm = try! Realm()
    let obj = realm.objects(guestData.self).last
    let dish = obj!.dish
    let dishFee = String(formatterMake().string(from: dish*100 as NSNumber)!)
  
    
    //ラベル作成 //計算
    let label = MakeLabel()
    let button = MakeButton()
    label.make(x: 400, y: 29, width:50, height:20,back:UIColor.clear,_text:"預かり", _fontSize:10,view:view)
    label.make(x: 400, y: 129, width:50, height:20,back:UIColor.clear,_text:"会計", _fontSize:10,view:view)
    label.make(x: 400, y: 229, width:50, height:20,back:UIColor.clear,_text:"お釣り", _fontSize:10,view:view)
    label.make(x: 400, y: 50, width:270, height:60,back:UIColor.clear,_borderWidth:1.5,_cornerRadius:6,_text:"¥\(inputNum)", _fontSize:50,view:view)
    label.make(x: 400, y: 150, width:270, height:60,back:UIColor.clear,_borderWidth:1.5,_cornerRadius:6,_text:"¥\(dishFee)", _fontSize:50,view:view)
    label.make(x: 400, y: 250, width:270, height:60,back:UIColor.clear,_borderWidth:1.5,_cornerRadius:6,_text:"¥\(change)", _fontSize:50,view:view)
    label.make(x: 600, y: 29, width:50, height:20,back:UIColor.clear,_text:"\(warning)", _fontSize:10,view:view)
    //ボタン作成
    button.make(x:30,y:700,width:100,height:50,back:UIColor.white,tag:20, _borderWidth:1.5,_cornerRadius:6,_text:"戻る", _fontSize:50,view:view)
    button.make(x:750,y:650,width:200,height:80,back:UIColor.white,tag:21, _borderWidth:1.5,_cornerRadius:6,_text:"ENTER", _fontSize:50,view:view)
    
    //テンキー作成
    for i in 1...3{
    for j in 1...3{
        button.make(x:CGFloat(300+j*100) ,y:CGFloat(250+i*100),width:70,height:70,back:UIColor.white,tag:Int(tenkey[i-1][j-1])!,_borderWidth:1.5,_cornerRadius:6, _text:tenkey[i-1][j-1], _fontSize:50,_isSelf:false,view:view)
    }
    }
    button.make(x:400,y:650,width:180,height:70,back:UIColor.white,tag:10, _borderWidth:1.5,_cornerRadius:6, _text:"0", _fontSize:50,view:view)
    button.make(x:600,y:650,width:70,height:70,back:UIColor.white,tag:22, _borderWidth:1.5,_cornerRadius:6, _text:"〆", _fontSize:50,view:view)
    //終わり
    //年齢層
    button.make(x:750,y:50,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:30, _borderWidth:1.5,_cornerRadius:6,_text:"12", _fontSize:50,view:view)
    button.make(x:850,y:50,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:31, _borderWidth:1.5,_cornerRadius:6,_text:"12", _fontSize:50,view:view)
    button.make(x:750,y:150,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:32, _borderWidth:1.5,_cornerRadius:6,_text:"19", _fontSize:50,view:view)
    button.make(x:850,y:150,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:33, _borderWidth:1.5,_cornerRadius:6,_text:"19", _fontSize:50,view:view)
    button.make(x:750,y:250,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:34, _borderWidth:1.5,_cornerRadius:6,_text:"29", _fontSize:50,view:view)
    button.make(x:850,y:250,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:35, _borderWidth:1.5,_cornerRadius:6,_text:"29", _fontSize:50,view:view)
    button.make(x:750,y:350,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:36, _borderWidth:1.5,_cornerRadius:6,_text:"49", _fontSize:50,view:view)
    button.make(x:850,y:350,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:37, _borderWidth:1.5,_cornerRadius:6,_text:"49", _fontSize:50,view:view)
    button.make(x:750,y:450,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:38, _borderWidth:1.5,_cornerRadius:6,_text:"50", _fontSize:50,view:view)
    button.make(x:850,y:450,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:39, _borderWidth:1.5,_cornerRadius:6,_text:"50", _fontSize:50,view:view)
    //年齢層年齢層マスク
    if appDelegate.geneMaskFlag != 100 {
    if appDelegate.geneMaskFlag % 2 == 0{
    label.make(x:750 ,y:CGFloat(50 + ((appDelegate.geneMaskFlag - 30) * 50)),width:100,height:100,back:UIColor.black,_cornerRadius:6,_alpha:0.3,_fontSize:50,view:view)
    }else{
    label.make(x:850 ,y:CGFloat(50 + ((appDelegate.geneMaskFlag - 31) * 50)),width:100,height:100,back:UIColor.black,_cornerRadius:6,_alpha:0.3,_fontSize:50,view:view)
    }
    }
    
    button.make(x:750,y:570,width:200,height:60,back:UIColor.white,tag:22,_borderWidth:1.5,_cornerRadius:6, _text:"\(generation)", _fontSize:25,_font:"Bold",view:view)
    }
    
    //ボタンイベント
    @objc func selection(sender: UIButton){
        print("きてる")
        let view = viewSetting()
        if sender.tag <= 10 {
            k = sender.tag
        }
        if sender.tag >= 30 && sender.tag < 40{
            l = sender.tag
        }
        switch sender.tag{
        case k://tenkey
            if inputNum.count <= 7{
                if k == 10 {
                    inputNum += "0"
                }else{
                    inputNum += "\(k)"
                }
                let value = Int(inputNum.replacingOccurrences(of: ",", with: ""))!
                inputNum = String(formatterMake().string(from: value as NSNumber)!)
            }
            inputNum = tenkeyHandle(inputNum: inputNum)
            audioPlayerInstance.play()
        case 20://戻るボタン
            view.viewSet(view: self, transition: ViewController())
            audioPlayerInstance.play()
        case 21://Enter
            if inputNum == ""{break}
            let value = Int(inputNum.replacingOccurrences(of: ",", with: ""))! - (appDelegate.dishSum * 110)
            if value < 0 {
                //ポップアップ表示
                let popUp = MakePopUp()
                popUp.alert(title: "再入力して下さい", view: self)
                inputNum = ""
                viewDidLoad()
                audioPlayerInstance.play()
                break
            }
            if generation == "" {
                //ポップアップ表示
                let popUp = MakePopUp()
                popUp.alert(title: "未入力があります", view: self)
            }
            change = String(formatterMake().string(from: value as NSNumber)!)
            viewDidLoad()
            appDelegate.dishSum = 0
            appDelegate.choise = 0
            appDelegate.tagFlag2 = 0
            //realm書き込み
            let date = Date()
            let dateAndTime = date.formattedDateWith(style: .time)
            let realm = try! Realm()
            let obj = realm.objects(guestData.self).last
            try! realm.write {
                obj?.outTime = dateAndTime
            }
            try! realm.write {
                realm.add(appSetting())
            }
            let saveObj = realm.objects(appSetting.self).last
            try! realm.write {
                saveObj?.touchVolume = appDelegate.touchVolume
                saveObj?.movieVolume = appDelegate.movieVolume
                saveObj?.volumeM = appDelegate.volumeM
                saveObj?.volumeMstatus = appDelegate.volumeMstatus
                saveObj?.volumeVstatus = appDelegate.volumeVstatus
                saveObj?.soundNum = appDelegate.soundNum
                saveObj?.movieNum = appDelegate.movieNum
                saveObj?.pickerView1Ini = appDelegate.pickerView1Ini
                saveObj?.pickerView2Ini = appDelegate.pickerView2Ini
            }
            let allObj = realm.objects(allData.self).last
            try! realm.write{
                allObj?.inTime = obj!.inTime
                allObj?.outTime = obj!.outTime
                allObj?.adultCount = obj!.adultCount
                allObj?.childCount = obj!.childCount
                allObj?.dish = obj!.dish
                allObj?.generation = generation
                allObj?.seatNum = obj!.seatNum
                allObj?.seatType = obj!.seatType
            }
            appDelegate.geneMaskFlag = 100
            appDelegate.history = []
            audioPlayerInstance.play()
            //遅延
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                view.viewSet(view: self, transition: ViewController())
            }
        case 22:
            //✗
            inputNum = String(inputNum.dropLast())
            if inputNum == "" {
                viewDidLoad()
                //audioPlayerInstance.play()
                break
            }
            let value = Int(inputNum.replacingOccurrences(of: ",", with: ""))!
            inputNum = String(formatterMake().string(from: value as NSNumber)!)
            viewDidLoad()
            audioPlayerInstance.play()
        //年齢層
        case l:
            generation = genArray[l - 30]
            appDelegate.geneMaskFlag = sender.tag
            loadView()
            viewDidLoad()
            audioPlayerInstance.play()
        //年齢層終わり
        default:break
        }
    }
    
    //テンキー用メソッド
    func tenkeyHandle(inputNum:String) -> String{
        var input = inputNum
        calculation = Int(input.replacingOccurrences(of: ",", with: ""))!
        if input.first == "0"{input = String(input.dropFirst())}
        if input.count >= 7 {
            warning = "これ以上入力できません"
            loadView()
            viewDidLoad()
            return input
        }else{
            warning = ""
            loadView()
            viewDidLoad()
            if input.count == 4 {input = inputNum + ","}
            return input
        }
    }
  
    //formatterメソッド
    func formatterMake() -> NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        return formatter
    }
 
}
