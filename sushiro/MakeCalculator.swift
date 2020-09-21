import UIKit

class MakeCalculator:UIViewController,selection{
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func selection(sender: UIButton) {
        <#code#>
    }
    
    //ラベル作成 //計算
    func make(xv:Int,yv:Int,wv:Int,hv:Int,sum:String){
    let label = MakeLabel()
    let button = MakeButton()
    label.make(x: 400, y: 29, width:50, height:20,back:UIColor.clear,_text:"預かり", _fontSize:10,view:self)
    label.make(x: 400, y: 129, width:50, height:20,back:UIColor.clear,_text:"会計", _fontSize:10,view:self)
    label.make(x: 400, y: 229, width:50, height:20,back:UIColor.clear,_text:"お釣り", _fontSize:10,view:self)
    label.make(x: 400, y: 50, width:270, height:60,back:UIColor.clear,_borderWidth:1.5,_cornerRadius:6,_text:"¥\(inputNum)", _fontSize:50,view:self)
    label.make(x: 400, y: 150, width:270, height:60,back:UIColor.clear,_borderWidth:1.5,_cornerRadius:6,_text:"¥\(dishFee)", _fontSize:50,view:self)
    label.make(x: 400, y: 250, width:270, height:60,back:UIColor.clear,_borderWidth:1.5,_cornerRadius:6,_text:"¥\(change)", _fontSize:50,view:self)
    label.make(x: 600, y: 29, width:50, height:20,back:UIColor.clear,_text:"\(warning)", _fontSize:10,view:self)
    //ボタン作成
    button.make(x:30,y:700,width:100,height:50,back:UIColor.white,tag:20, _borderWidth:1.5,_cornerRadius:6,_text:"戻る", _fontSize:50,view:self)
    button.make(x:750,y:650,width:200,height:80,back:UIColor.white,tag:21, _borderWidth:1.5,_cornerRadius:6,_text:"ENTER", _fontSize:50,view:self)
    
    //テンキー作成
    for i in 1...3{
    for j in 1...3{
    button.make(x:CGFloat(300+j*100) ,y:CGFloat(250+i*100),width:70,height:70,back:UIColor.white,tag:Int(tenkey[i-1][j-1])!,_borderWidth:1.5,_cornerRadius:6, _text:tenkey[i-1][j-1], _fontSize:50,view:self)
    }
    }
    button.make(x:400,y:650,width:180,height:70,back:UIColor.white,tag:10, _borderWidth:1.5,_cornerRadius:6, _text:"0", _fontSize:50,view:self)
    button.make(x:600,y:650,width:70,height:70,back:UIColor.white,tag:22, _borderWidth:1.5,_cornerRadius:6, _text:"〆", _fontSize:50,view:self)
    //終わり
    //年齢層
    button.make(x:750,y:50,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:30, _borderWidth:1.5,_cornerRadius:6,_text:"12", _fontSize:50,view:self)
    button.make(x:850,y:50,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:31, _borderWidth:1.5,_cornerRadius:6,_text:"12", _fontSize:50,view:self)
    button.make(x:750,y:150,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:32, _borderWidth:1.5,_cornerRadius:6,_text:"19", _fontSize:50,view:self)
    button.make(x:850,y:150,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:33, _borderWidth:1.5,_cornerRadius:6,_text:"19", _fontSize:50,view:self)
    button.make(x:750,y:250,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:34, _borderWidth:1.5,_cornerRadius:6,_text:"29", _fontSize:50,view:self)
    button.make(x:850,y:250,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:35, _borderWidth:1.5,_cornerRadius:6,_text:"29", _fontSize:50,view:self)
    button.make(x:750,y:350,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:36, _borderWidth:1.5,_cornerRadius:6,_text:"49", _fontSize:50,view:self)
    button.make(x:850,y:350,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:37, _borderWidth:1.5,_cornerRadius:6,_text:"49", _fontSize:50,view:self)
    button.make(x:750,y:450,width:100,height:100,back:UIColor(red:0.10, green:0.10, blue:1, alpha:0.5),tag:38, _borderWidth:1.5,_cornerRadius:6,_text:"50", _fontSize:50,view:self)
    button.make(x:850,y:450,width:100,height:100,back:UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5),tag:39, _borderWidth:1.5,_cornerRadius:6,_text:"50", _fontSize:50,view:self)
    //年齢層年齢層マスク
    if appDelegate.geneMaskFlag != 100 {
    if appDelegate.geneMaskFlag % 2 == 0{
    label.make(x:750 ,y:CGFloat(50 + ((appDelegate.geneMaskFlag - 30) * 50)),width:100,height:100,back:UIColor.black,_cornerRadius:6,_alpha:0.3,_fontSize:50,view:self)
    }else{
    label.make(x:850 ,y:CGFloat(50 + ((appDelegate.geneMaskFlag - 31) * 50)),width:100,height:100,back:UIColor.black,_cornerRadius:6,_alpha:0.3,_fontSize:50,view:self)
    }
    }
    
    button.make(x:750,y:570,width:200,height:60,back:UIColor.white,tag:22,_borderWidth:1.5,_cornerRadius:6, _text:"\(generation)", _fontSize:25,_font:"Bold",view:self)
    }

}
