import UIKit

class VSearchContentCellDefinition:VSearchContentCell
{
    private weak var label:UILabel!
    private let kLabelMarginHorizontal:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CSearch)
    {
        label.attributedText = controller.modelEntry?.attributedString
    }
}
