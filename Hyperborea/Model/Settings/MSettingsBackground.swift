import UIKit

class MSettingsBackground
{
    var maxWidth:CGFloat
    var maxHeight:CGFloat
    private(set) var items:[MSettingsBackgroundItem]
    private let deltaUpperCase:UInt32
    private let deltaLowerCase:UInt32
    private let kMaxItems:Int = 100
    private let kRatioAddItem:UInt32 = 10
    private let kItemWidth:CGFloat = 16
    private let kItemHeight:CGFloat = 20
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
    
    //MARK: public
    
    func tick()
    {
        let shoudlAddItem:UInt32 = arc4random_uniform(kRatioAddItem)
        
        if shoudlAddItem == 0
        {
            if items.count < kMaxItems
            {
                guard
                    
                    let letter:String = randomLetter()
                
                else
                {
                    return
                }
                
                print("random: \(letter)")
            }
        }
    }
    
    func draw(context:CGContext)
    {
        
    }
}
