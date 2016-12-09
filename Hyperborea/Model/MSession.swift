import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    private(set) var language:MSessionLanguage
    
    private init()
    {
        language = MSessionLanguageEnglish()
    }
}
