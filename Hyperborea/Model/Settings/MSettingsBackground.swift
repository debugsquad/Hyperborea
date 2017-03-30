import UIKit

class MSettingsBackground
{
    var maxWidth:CGFloat
    var maxHeight:CGFloat
    private(set) var items:[MSettingsBackgroundItem]
    private let kMaxItems:Int = 100
    private let kRatioAddItem:UInt32 = 10
    private let kItemWidth:CGFloat = 16
    private let kItemHeight:CGFloat = 20
    private let kLowerCaseMin:UInt32 = 65
    private let kLowerCaseMax:UInt32 = 90
    private let kUpperCaseMin:UInt32 = 97
    private let kUpperCaseMax:UInt32 = 122
    
    init()
    {
        items = []
        maxWidth = 0
        maxHeight = 0
    }
    
    //MARK: private
    
    private func randomLetter() -> String?
    {
        guard
            
            let unicodeScalar:UnicodeScalar = UnicodeScalar(0)
        
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
