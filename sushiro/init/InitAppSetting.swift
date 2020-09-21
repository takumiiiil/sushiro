import UIKit
import RealmSwift

//ラベル作成class
class InitAppSetting{
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let realm = try! Realm()
    
    func doInit(){
        print("初期化にきてる")
        let saveObj = realm.objects(appSetting.self).last
        if saveObj != nil {
            try! realm.write {
                appDelegate.touchVolume = saveObj!.touchVolume
                appDelegate.movieVolume = saveObj!.movieVolume
                appDelegate.volumeM = saveObj!.volumeM
                appDelegate.volumeMstatus = saveObj!.volumeMstatus
                appDelegate.volumeVstatus = saveObj!.volumeVstatus
                appDelegate.soundNum = saveObj!.soundNum
                appDelegate.movieNum = saveObj!.movieNum
                appDelegate.pickerView1Ini = saveObj!.pickerView1Ini
                appDelegate.pickerView2Ini = saveObj!.pickerView2Ini
            }
        }else{
            try! realm.write {
                realm.add(appSetting())
            }
        }
    }
}
