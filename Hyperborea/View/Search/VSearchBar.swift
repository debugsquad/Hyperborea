import UIKit

class VSearchBar:UIView
{
    private weak var controller:CSearch!
    private(set) weak var viewField:VSearchBarField!
    private let kBorderHeight:CGFloat = 1
    private let kFieldMarginHorizontal:CGFloat = 10
    private let kFieldTop:CGFloat = 20
    
    init(controller:CSearch)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let viewField:VSearchBarField = VSearchBarField(
            controller:controller)
        self.viewField = viewField
        
        addSubview(border)
        addSubview(viewField)
        
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewField,
            toView:self,
            constant:kFieldTop)
        NSLayoutConstraint.bottomToBottom(
            view:viewField,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewField,
            toView:self,
            margin:kFieldMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
