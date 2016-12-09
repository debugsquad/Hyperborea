import UIKit

class MSessionLanguageSpanish:MSessionLanguage
{
    private let kLanguageId:String = "es"
    
    override init()
    {
        super.init(
            languangeId:kLanguageId,
            image:#imageLiteral(resourceName: "assetHomeLanguageEnglish"))
    }
    
    override init(languangeId:String, image:UIImage)
    {
        fatalError()
    }
}
