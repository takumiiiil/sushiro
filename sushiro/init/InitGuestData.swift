import RealmSwift

class InitGuestData{
    
    let realm = try! Realm()
    
    func doInit(){
        let obj = realm.objects(guestData.self).last
        if obj != nil{
            try! realm.write {
                obj?.seatNum = ""
                obj?.dish = 0
                obj?.inTime = ""
                obj?.outTime = ""
                obj?.adultCount = ""
                obj?.childCount = ""
                obj?.seatType = ""
            }
    }else{
            try! realm.write {
                realm.add(guestData())}
    }
        try! realm.write {realm.add(allData())}
    }
}
