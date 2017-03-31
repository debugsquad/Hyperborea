import Foundation

class MOxfordCredentials
{
    private let items:[RCredentialsItem]
    private let countItems:UInt32
    
    init()
    {
        let item1:RCredentialsItem1 = RCredentialsItem1()
        let item2:RCredentialsItem2 = RCredentialsItem2()
        let item3:RCredentialsItem3 = RCredentialsItem3()
        let item4:RCredentialsItem4 = RCredentialsItem4()
        let item5:RCredentialsItem5 = RCredentialsItem5()
        
        items = [
            item1,
            item2,
            item3,
            item4,
            item5
        ]
        
        countItems = UInt32(items.count)
    }
    
    //MARK: public
    
    func current() -> [String:String]
    {
        let random:Int = Int(arc4random_uniform(countItems))
        let item:RCredentialsItem = items[random]
        
        return item.credentials
    }
}
