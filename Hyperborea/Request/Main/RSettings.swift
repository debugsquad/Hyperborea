import Foundation

class RSettings
{
    enum SettingsId
    {
        case unknown
    }
    
    static let kTimeOut:TimeInterval = 20
    let settingsId:SettingsId
    let urlString:String
    let timeOut:TimeInterval
    
    init(
        settingsId:SettingsId,
        urlString:String,
        timeOut:TimeInterval = kTimeOut)
    {
        self.settingsId = settingsId
        self.urlString = urlString
        self.timeOut = timeOut
    }
    
    init()
    {
        fatalError()
    }
}
