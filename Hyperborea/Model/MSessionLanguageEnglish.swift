import UIKit

class MSessionLanguageEnglish:MSessionLanguage
{
    private let kLanguageId:String = "en"
    
    override init()
    {
        let name:String = NSLocalizedString("MSessionLanguageEnglish_name", comment:"")
        
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
