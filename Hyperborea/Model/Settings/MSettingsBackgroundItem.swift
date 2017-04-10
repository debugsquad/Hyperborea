import UIKit

class MSettingsBackgroundItem
{
    private let letter:NSAttributedString
    var positionY:CGFloat
    let positionX:CGFloat
    let width:CGFloat
    let height:CGFloat
    let speedY:CGFloat
    
    init(
        letter:NSAttributedString,
        positionX:CGFloat,
        positionY:CGFloat,
        width:CGFloat,
        height:CGFloat,
        speedY:CGFloat)
    {
        self.letter = letter
        self.positionX = positionX
        self.positionY = positionY
        self.width = width
        self.height = height
        self.speedY = speedY
    }
    
    //MARK: public
    
    func draw(context:CGContext)
    {
        let rect:CGRect = CGRect(
            x:positionX,
            y:positionY,
            width:width,
            height:height)
        
        letter.draw(in:rect)
    }
}
