import UIKit

class MSettingsItemResults:MSettingsItem
{
    private let kCellHeight:CGFloat = 90
    private let kSelectable:Bool = false
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellResults.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
