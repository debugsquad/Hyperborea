import UIKit

class VSearchContentCellOrigins:VSearchContentCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self,
            constant:kLabelBottom)
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
        label.attributedText = controller.modelEntry?.origins.attributedString
    }
}
