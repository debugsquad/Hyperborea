import UIKit

class MSettingsItemRetina:MSettingsItem
{
    private let kCellHeight:CGFloat = 90
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellRetina.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
