import Foundation

class RCredentialsItem1:RCredentialsItem
{
    private let kAppId:String = "c4753937"
    private let kAppKey:String = "17a46e20204f62884100cc574e3ee824"
    
    override init()
    {
        super.init(appId:kAppId, appKey:kAppKey)
    }
    
    override init(appId:String, appKey:String)
    {
        fatalError()
    }
}
