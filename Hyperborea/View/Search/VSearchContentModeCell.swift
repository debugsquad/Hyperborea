import UIKit

class VSearchContentModeCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private let kLabelTop:CGFloat = 58
    private let kLabelHeight:CGFloat = 28
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kLabelTop)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self)
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
        if isSelected || isHighlighted
        {
            label.textColor = UIColor.hyperBlue
        }
        else
        {
            label.textColor = UIColor(white:0.8, alpha:1)
        }
    }
    
    //MARK: public
    
    func config(model:MSearchContentModeItem)
    {
        label.attributedText = model.attributedString
        hover()
    }
}
