import UIKit

class VRecentCell:UICollectionViewCell
{
    private weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:15)
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equals(
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
