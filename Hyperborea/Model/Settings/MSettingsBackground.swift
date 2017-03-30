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
    
    init()
    {
        items = []
        maxWidth = 0
        maxHeight = 0
    }
    
    //MARK: public
    
    func tick()
    {
        let shoudlAddItem:UInt32 = arc4random_uniform(kRatioAddItem)
        
        if shoudlAddItem == 0
        {
            if items.count < kMaxItems
            {
                
                
                let item:MSettingsBackgroundItem = MSettingsBackgroundItem()
            }
        }
    }
    
    func draw(context:CGContext)
    {
        
    }
}
