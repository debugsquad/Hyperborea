import Foundation

class RCredentials
{
    private let items:[RCredentialsItem]
    private let countItems:UInt32
    
    init()
    {
        items = [
        ]
        
        countItems = UInt32(items.count)
    }
    
    //MARK: public
    
    func credentials() -> [String:String]
    {
        let random:Int = Int(arc4random_uniform(countItems))
        let item:RCredentialsItem = items[random]
        
        return item.credentials
    }
}
