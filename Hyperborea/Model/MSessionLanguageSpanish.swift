import UIKit

class MSessionLanguageSpanish:MSessionLanguage
{
    private let kLanguageId:String = "es"
    
    override init()
    {
        let name:String = NSLocalizedString("MSessionLanguageSpanish_name", comment:"")
        
        super.init(
            languangeId:kLanguageId,
            image:#imageLiteral(resourceName: "assetHomeLanguageEnglish"),
            name:name)
    }
    
    override init(languangeId:String, image:UIImage, name:String)
    {
        fatalError()
    }
}
