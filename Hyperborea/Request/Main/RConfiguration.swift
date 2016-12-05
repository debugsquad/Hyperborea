import Foundation

class RConfiguration
{
    static let sharedInstance:RConfiguration = RConfiguration()
    let oxfordCredentials:[String:String]
    let kSourceLang:String = "en"
    private let kAppIdKey:String = "app_id"
    private let kAppKeyKey:String = "app_key"
    private let kAppIdValue:String = "c4753937"
    private let kAppKeyValue:String = "17a46e20204f62884100cc574e3ee824"
    
    private init()
    {
        oxfordCredentials = [
            kAppIdKey:kAppIdValue,
            kAppKeyKey:kAppKeyValue
        ]
    }
}
