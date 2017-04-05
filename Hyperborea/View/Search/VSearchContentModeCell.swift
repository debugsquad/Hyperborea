import UIKit

class VSearchContentModeCell:UICollectionViewCell
{
    private weak var labelTitle:UILabel!
    private let kLabelTop:CGFloat = 64
    private let kTitleHeight:CGFloat = 20
    private let kTitleFontSize:CGFloat = 11
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.regular(size:kTitleFontSize)
        self.labelTitle = labelTitle
        
        addSubview(labelTitle)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
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
            labelTitle.textColor = UIColor.hyperBlue
        }
        else
        {
            labelTitle.textColor = UIColor(white:0.8, alpha:1)
        }
    }
    
    //MARK: public
    
    func config(model:MSearchContentModeItem)
    {
        labelTitle.text = model.title
        hover()
    }
}
