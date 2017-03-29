import UIKit

class VSearchBar:UIView
{
    private(set) weak var viewField:VSearchBarField!
    private weak var controller:CSearch!
    private weak var border:VBorder!
    let kFieldTop:CGFloat = 20
    private let kBorderHeight:CGFloat = 1
    private let kFieldMarginHorizontal:CGFloat = 10
    
    init(controller:CSearch)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        self.border = border
        
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
    
    //MARK: public
    
    func beginEditing()
    {
        border.backgroundColor = UIColor(white:0, alpha:0.4)
    }
    
    func endEditing()
    {
        border.backgroundColor = UIColor(white:0, alpha:0.1)
    }
}
