import UIKit

class VBarCell:UICollectionViewCell
{
    private weak var icon:UIImageView!
    private weak var model:MMainItem!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.clipsToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = UIViewContentMode.center
        self.icon = icon
        
        addSubview(icon)
        
        let views:[String:UIView] = [
            "icon":icon]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
        if isSelected || isHighlighted
        {
            icon.image = UIImage(named:model.iconImageOn)
        }
        else
        {
            icon.image = UIImage(named:model.iconImageOff)
        }
    }
    
    //MARK: public
    
    func config(model:MMainItem)
    {
        self.model = model
        hover()
    }
}
