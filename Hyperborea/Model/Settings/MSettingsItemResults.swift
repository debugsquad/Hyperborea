import UIKit

class MSettingsItemResults:MSettingsItem
{
    private let kCellHeight:CGFloat = 90
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellLanguage.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
