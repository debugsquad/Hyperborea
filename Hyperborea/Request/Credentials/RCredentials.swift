import Foundation

class RCredentials
{
    private let items:[RCredentialsItem]
    private let countItems:UInt32
    
    init()
    {
        let item1:RCredentialsItem1 = RCredentialsItem1()
        let item2:RCredentialsItem2 = RCredentialsItem2()
        
        items = [
            item1,
            item2
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
