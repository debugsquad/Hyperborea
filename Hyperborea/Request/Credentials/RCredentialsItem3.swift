import Foundation

class RCredentialsItem3:RCredentialsItem
{
    private let kAppId:String = "a913b728"
    private let kAppKey:String = "e74f2d3b8097cdf702d18cbe707e566d"
    
    override init()
    {
        super.init(appId:kAppId, appKey:kAppKey)
    }
    
    override init(appId:String, appKey:String)
    {
        fatalError()
    }
}
