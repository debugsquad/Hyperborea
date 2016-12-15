import Foundation

class RCredentialsItem4:RCredentialsItem
{
    private let kAppId:String = "325bf5c8"
    private let kAppKey:String = "f814a4b83f804bb0fdcc22a95c569ab5"
    
    override init()
    {
        super.init(appId:kAppId, appKey:kAppKey)
    }
    
    override init(appId:String, appKey:String)
    {
        fatalError()
    }
}
