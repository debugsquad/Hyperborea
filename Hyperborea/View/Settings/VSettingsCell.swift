import UIKit

class VSettingsCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected
        {
            backgroundColor = UIColor(white:1, alpha:0.6)
        }
        else
        {
            backgroundColor = UIColor.clear
        }
    }
    
    //MARK: public
    
    func config(model:MSettingsItem, controller:CSettings)
    {
        hover()
    }
}
