import UIKit

class MSessionLanguageSpanish:MSessionLanguage
{
    private let kLanguageId:MSessionLanguage.LanguageId = MSessionLanguage.LanguageId.spanish
    private let kCode:String = "es"
    
    override init()
    {
        let name:String = NSLocalizedString("MSessionLanguageSpanish_name", comment:"")
        
        super.init(
            languageId:kLanguageId,
            code:kCode,
            image:#imageLiteral(resourceName: "assetHomeLanguageSpanish"),
            name:name)
    }
    
    override init(
        languageId:MSessionLanguage.LanguageId,
        code:String,
        image:UIImage,
        name:String)
    {
        fatalError()
    }
}
