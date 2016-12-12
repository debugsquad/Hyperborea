import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    let flux:MSessionFlux
    private(set) var language:MSessionLanguage?
    
    private init()
    {
        flux = MSessionFlux()
    }
    
    //MARK: private
    
    private func asyncLoadSession()
    {
        
    }
    
    //MARK: public
    
    func loadSession()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadSession()
        }
    }
    
    func changeLanguage(language:MSessionLanguage)
    {
        if language.languageId != self.language?.languageId
        {
            self.language = language
            
            NotificationCenter.default.post(
                name:Notification.languageChanged,
                object:nil)
        }
    }
}
