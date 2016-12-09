import UIKit

class MSessionLanguage
{
    let languangeId:String
    let image:UIImage
    let name:String
    
    init(languangeId:String, image:UIImage, name:String)
    {
        self.languangeId = languangeId
        self.image = image
        self.name = name
    }
    
    init()
    {
        fatalError()
    }
}
