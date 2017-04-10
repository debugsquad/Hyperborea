import UIKit

class MSettingsItemReview:MSettingsItem
{
    private let kCellHeight:CGFloat = 90
    private let kSelectable:Bool = true
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellReview.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override func selected(controller:CSettings)
    {
        controller.review()
    }
}
