import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    private(set) var language:MSessionLanguage
    
    private init()
    {
        language = MSessionLanguageEnglish()
    }
    
    //MARK: public
    
    func changeLanguage(language:MSessionLanguage)
    {
        self.language = language
        
        NotificationCenter.default.post(
            name:Notification.languageChanged,
            object:nil)
    }
}
