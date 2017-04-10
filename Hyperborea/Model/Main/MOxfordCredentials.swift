import Foundation

class MOxfordCredentials
{
    private let credentials:[[String:String]]
    private let countItems:UInt32
    private let kResourceName:String = "ResourceOxfordCredentials"
    private let kResourceExtension:String = "plist"
    
    init()
    {
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let credentialsArray:NSArray = NSArray(
                contentsOf:resourceUrl),
            let credentials:[[String:String]] = credentialsArray as? [[String:String]]
            
        else
        {
            self.credentials = [[:]]
            self.countItems = 0
            
            return
        }
        
        self.credentials = credentials
        countItems = UInt32(credentials.count)
    }
    
    //MARK: public
    
    func credentialHeaders() -> [String:String]
    {
        let random:Int = Int(arc4random_uniform(countItems))
        let headers:[String:String] = credentials[random]
        
        return headers
    }
}
