import UIKit

class MSessionLanguageEnglish:MSessionLanguage
{
    private let kLanguageId:String = "en"
    
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
