import Foundation

class RSettings
{
    enum SettingsId
    {
        case unknown
    }
    
    let settingsId:SettingsId
    let urlString:String
    
    var settingsId:RequestSettingsId = RequestSettingsId.unknown
    var urlString:String = ""
    var parser:RequestParser = RequestParser()
    var type:RequestSettingsType = RequestSettingsType.Get()
    var timeout:TimeInterval
    var multipart:Bool = false
    var token:Bool = false
    var body:Any?
    let urlList:[String:String]
    let kBoundary:String = "SuggesticBoundaryFormPostingData"
    private let kTimeout:TimeInterval = 24
    
    init()
    {
        let resURL:URL = Bundle.main.url(
            forResource:"resourcesUrls",
            withExtension:"plist")!
        let urlsDictionary:NSDictionary = NSDictionary(contentsOf:resURL)!
        urlList = urlsDictionary as! [String:String]
        timeout = kTimeout
    }
}
