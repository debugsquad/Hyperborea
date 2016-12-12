import UIKit

class MSessionLanguageEnglish:MSessionLanguage
{
    private let kLanguageId:MSessionLanguage.LanguageId = MSessionLanguage.LanguageId.english
    private let kCode:String = "en"
    
    override init()
    {
        let name:String = NSLocalizedString("MSessionLanguageEnglish_name", comment:"")
        
        super.init(
            languageId:kLanguageId,
            code:kCode,
            image:#imageLiteral(resourceName: "assetHomeLanguageEnglish"),
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
