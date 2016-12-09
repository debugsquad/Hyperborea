import UIKit

class MSessionLanguage
{
    let languangeId:String
    let image:UIImage
    
    init(languangeId:String, image:UIImage)
    {
        self.languangeId = languangeId
        self.image = image
    }
    
    init()
    {
        fatalError()
    }
}
