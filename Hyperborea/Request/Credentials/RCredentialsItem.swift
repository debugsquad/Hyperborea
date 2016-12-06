import Foundation

class RCredentialsItem
{
    let credentials:[String:String]
    private let kAppIdKey:String = "app_id"
    private let kAppKeyKey:String = "app_key"
    
    init(appId:String, appKey:String)
    {
        credentials = [
            kAppIdKey:appId,
            kAppKeyKey:appKey]
    }
    
    init()
    {
        fatalError()
    }
}
