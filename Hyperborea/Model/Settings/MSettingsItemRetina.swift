import UIKit

class MSettingsItemRetina:MSettingsItem
{
    private let kCellHeight:CGFloat = 90
    private let kSelectable:Bool = false
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellRetina.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
