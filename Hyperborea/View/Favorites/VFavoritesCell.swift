import UIKit

class VFavoritesCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private let kMarginHorizontal:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:17)
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kMarginHorizontal)
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
            backgroundColor = UIColor.hyperBlue
            label.textColor = UIColor.white
        }
        else
        {
            backgroundColor = UIColor.white
            label.textColor = UIColor.black
        }
    }
    
    //MARK: public
    
    func config(model:MRecentEntry)
    {
        label.text = model.word
        hover()
    }
}
