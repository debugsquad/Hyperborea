import Foundation

class RCredentialsItem2:RCredentialsItem
{
    private let kAppId:String = "7b3c630e"
    private let kAppKey:String = "e1497641b34f4a3fefc31f0c76839bf8"
    
    override init()
    {
        super.init(appId:kAppId, appKey:kAppKey)
    }
    
    override init(appId:String, appKey:String)
    {
        fatalError()
    }
}
