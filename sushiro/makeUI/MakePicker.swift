import UIKit

//ラベル作成class
class MakePicker:UIPickerView,UIPickerViewDelegate, UIPickerViewDataSource{

    
    let dataList1 = [
        "button01a","button01b","button01c"
    ]
    
    func make(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,back:UIColor,
              _borderWidth:CGFloat=0.0,_cornerRadius:CGFloat=0.0,_alpha:CGFloat=1.0,
              _text:String="",_textColer:UIColor=UIColor.black,_fontSize:CGFloat=30,_adjustsFontSizeToFitWidth:Bool=true,_alignment:NSTextAlignment=NSTextAlignment.center)->UIPickerView{
        
        //必須
        var pickerView = UIPickerView(frame: CGRect(x:x, y:y, width:width, height:height))
        pickerView .backgroundColor = back
   
        
        //ビューオプション
       /* label.layer.borderWidth = _borderWidth
        if _borderWidth != 0.0{label.layer.borderColor = UIColor.black.cgColor}
        label.layer.masksToBounds = true//cornerRadiusを使用するために必要
        label.layer.cornerRadius = _cornerRadius
        label.alpha = _alpha
        
        //テキストオプション
        pickerView = self.view.center
        label.text = _text
        label.textColor = _textColer
        label.font = label.font.withSize(_fontSize)
        label.adjustsFontSizeToFitWidth = _adjustsFontSizeToFitWidth
        label.textAlignment = _alignment*/
        
        return(pickerView)
    }
    
    //いじってみます
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int ) -> Int {
            return dataList1.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return dataList1[row]
    }
    
    /*func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1{
            appDelegate.soundNum = dataList1[row]
            appDelegate.pickerView1Ini = row
        }else{
            appDelegate.movieNum = dataList2[row]
            appDelegate.pickerView2Ini = row
        }
    }*/
}
