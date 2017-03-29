import UIKit

class MSearchContentModeItem
{
    let rawName:String
    var attributedString:NSAttributedString?
    var cellWidth:CGFloat
    
    init(rawName:String)
    {
        self.rawName = rawName
        cellWidth = 0
    }
}
