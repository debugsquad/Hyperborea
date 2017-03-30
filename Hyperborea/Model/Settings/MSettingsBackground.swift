import UIKit

class MSettingsBackground
{
    var maxWidth:CGFloat
    var maxHeight:CGFloat
    private(set) var items:[MSettingsBackgroundItem]
    private let attributes:[String:AnyObject]
    private let drawingOptions:NSStringDrawingOptions
    private let maxLetterSize:CGSize
    private let deltaUpperCase:UInt32
    private let deltaLowerCase:UInt32
    private let kSpeedY:CGFloat = -1
    private let kFontSize:CGFloat = 20
    private let kMaxLetterWidth:CGFloat = 300
    private let kMaxLetterHeight:CGFloat = 30
    private let kMaxItems:Int = 200
    private let kDeltaPositionX:CGFloat = 30
    private let kRatioAddItem:UInt32 = 20
    private let kUpperCaseMin:UInt32 = 65
    private let kUpperCaseMax:UInt32 = 90
    private let kLowerCaseMin:UInt32 = 97
    private let kLowerCaseMax:UInt32 = 122
    private let kLowerOrUpper:UInt32 = 2
    
    init()
    {
        items = []
        maxWidth = 0
        maxHeight = 0
        deltaUpperCase = kUpperCaseMax - kUpperCaseMin
        deltaLowerCase = kLowerCaseMax - kLowerCaseMin
        attributes = [
            NSFontAttributeName:UIFont.bold(size:kFontSize),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.2)]
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        maxLetterSize = CGSize(
            width:kMaxLetterWidth,
            height:kMaxLetterHeight)
    }
    
    //MARK: private
    
    private func randomLetter() -> String?
    {
        let unicode:UInt32
        let lowerOrUpper:UInt32 = arc4random_uniform(kLowerOrUpper)
        
        if lowerOrUpper == 0
        {
            unicode = arc4random_uniform(deltaLowerCase) + kLowerCaseMin
        }
        else
        {
            unicode = arc4random_uniform(deltaUpperCase) + kUpperCaseMin
        }
        
        guard
            
            let unicodeScalar:UnicodeScalar = UnicodeScalar(unicode)
        
        else
        {
            return nil
        }
        
        let string:String = String(unicodeScalar)
        
        return string
    }
    
    private func randomPositionX() -> CGFloat
    {
        let contentX:UInt32 = UInt32(maxWidth)
        let randomX:UInt32 = arc4random_uniform(contentX)
        let randomFloat:CGFloat = CGFloat(randomX)
        let floatPositionX:CGFloat = randomFloat - kDeltaPositionX
        
        return floatPositionX
    }
    
    //MARK: public
    
    func tick()
    {
        let shoudlAddItem:UInt32 = arc4random_uniform(kRatioAddItem)
        
        if shoudlAddItem == 0
        {
            if self.items.count < kMaxItems
            {
                guard
                    
                    let letter:String = randomLetter()
                
                else
                {
                    return
                }
                
                let attributedString:NSAttributedString = NSAttributedString(
                    string:letter,
                    attributes:attributes)
                let stringRect:CGRect = attributedString.boundingRect(
                    with:maxLetterSize,
                    options:drawingOptions,
                    context:nil)
                let positionX:CGFloat = randomPositionX()
                let positionY:CGFloat = maxHeight
                let width:CGFloat = ceil(stringRect.size.width)
                let height:CGFloat = ceil(stringRect.size.height)
                
                let item:MSettingsBackgroundItem = MSettingsBackgroundItem(
                    letter:attributedString,
                    positionX:positionX,
                    positionY:positionY,
                    width:width,
                    height:height)
                
                self.items.append(item)
            }
        }
        
        var newItems:[MSettingsBackgroundItem] = []
        
        for item:MSettingsBackgroundItem in items
        {
            item.positionY += kSpeedY
            
            let itemMaxY:CGFloat = item.positionY + item.height
            
            if itemMaxY > 0
            {
                newItems.append(item)
            }
        }
        
        self.items = newItems
    }
    
    func draw(context:CGContext)
    {
        for item:MSettingsBackgroundItem in items
        {
            item.draw(context:context)
        }
    }
}
