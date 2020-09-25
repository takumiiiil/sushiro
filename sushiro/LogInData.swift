import UIKit
import RealmSwift
//realm作成 guest
class LogInData:Object{
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var phone = ""
    @objc dynamic var mailAddress = ""
    @objc dynamic var password = ""
}
