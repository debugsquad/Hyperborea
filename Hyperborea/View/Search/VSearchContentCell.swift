import UIKit

class VSearchContentCell:UICollectionViewCell
{
    private(set) weak var label:UILabel!
    let kLabelMarginHorizontal:CGFloat = 10
    let kLabelBottom:CGFloat = -40
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        self.label = label
        
        addSubview(label)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(controller:CSearch)
    {
    }
}
