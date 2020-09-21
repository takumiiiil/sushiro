import UIKit

class MakeScrollView:UIScrollView{
    
    let scrollView = UIScrollView()
    
    func make(x:Int,y:Int,width:Int,height:Int,contentHeight:Int,view:AnyObject){
        
        //縦スクロールのみにする記述
        let scrollFrame = CGRect(x:x, y:y, width:width, height:height)
        scrollView.frame = scrollFrame
        //ここのhightはスクロール出来る上限
        //scrollView.contentSizeのheightはscrollFrameのheightより大きい必要がある。
     
        //ここのhightはスクロール出来る上限
        if contentHeight > height {
            scrollView.contentSize = CGSize(width:width, height: contentHeight)
        }else{
            scrollView.contentSize = CGSize(width:Double(width), height:Double(height)+0.1)
        }
        
        scrollView.layer.borderWidth = 1.5
        scrollView.layer.borderColor = UIColor.black.cgColor
        scrollView.backgroundColor = UIColor.clear
        
        // スクロールの跳ね返り無し
        scrollView.bounces = false
        //スクロール位置の表示
        //scrollView.showsVerticalScrollIndicator = false
        view.view.addSubview(scrollView)
    
    }
    
    func makeLabel(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,back:UIColor,
              _borderWidth:CGFloat=0.0,_cornerRadius:CGFloat=0.0,_alpha:CGFloat=1.0,
              _text:String="",_textColer:UIColor=UIColor.black,_fontSize:CGFloat=30,_adjustsFontSizeToFitWidth:Bool=true,_alignment:NSTextAlignment=NSTextAlignment.center,view:AnyObject){
        
        //必須
        let label = UILabel(frame: CGRect(x:x, y:y, width:width, height:height))
        label.backgroundColor = back
        
        //ビューオプション
        label.layer.borderWidth = _borderWidth
        if _borderWidth != 0.0{label.layer.borderColor = UIColor.black.cgColor}
        label.layer.masksToBounds = true//cornerRadiusを使用するために必要
        label.layer.cornerRadius = _cornerRadius
        label.alpha = _alpha
        
        //テキストオプション
        label.text = _text
        label.textColor = _textColer
        label.font = label.font.withSize(_fontSize)
        label.adjustsFontSizeToFitWidth = _adjustsFontSizeToFitWidth
        label.textAlignment = _alignment
        scrollView.addSubview(label)
    }
    func makeQrcode(xv:Int,yv:Int,wv:Int,hv:Int,sum:String,view:AnyObject){
        let qrImageView = UIImageView(frame: CGRect(x:CGFloat(xv), y: CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
        let str = sum
        let data = str.data(using: String.Encoding.utf8)!
        let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": "M"])!
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let qrImage = qr.outputImage!.transformed(by: sizeTransform)
        let context = CIContext()
        let cgImage = context.createCGImage(qrImage, from: qrImage.extent)
        let uiImage = UIImage(cgImage: cgImage!)
        // 作成したQRコードを表示
        qrImageView.contentMode = .scaleAspectFit
        qrImageView.image = uiImage
        scrollView.addSubview(qrImageView)
    }
}
