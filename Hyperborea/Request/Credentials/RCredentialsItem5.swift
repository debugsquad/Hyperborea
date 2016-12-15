import Foundation

class RCredentialsItem5:RCredentialsItem
{
    private let kAppId:String = "ed6776de"
    private let kAppKey:String = "8d22c90ebfa0aed7d57eea8f29170550"
    
    override init()
    {
        super.init(appId:kAppId, appKey:kAppKey)
    }
    
    override init(appId:String, appKey:String)
    {
        fatalError()
    }
}
