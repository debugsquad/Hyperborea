import UIKit

class MSettingsBackgroundItem
{
    private let letter:NSAttributedString
    var positionX:CGFloat
    var positionY:CGFloat
    let width:CGFloat
    let height:CGFloat
    
    init(
        letter:NSAttributedString,
        positionX:CGFloat,
        positionY:CGFloat,
        width:CGFloat,
        height:CGFloat)
    {
        self.letter = letter
        self.positionX = positionX
        self.positionY = positionY
        self.width = width
        self.height = height
    }
}
