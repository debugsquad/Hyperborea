import UIKit

class VHome:VView
{
    private weak var controller:CHome!
    private weak var viewInput:VHomeInput!
    private weak var layoutInputTop:NSLayoutConstraint!
    private weak var layoutInputHeight:NSLayoutConstraint!
    private let kInputMaxHeight:CGFloat = 300
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        
        self.controller = controller as? CHome
        
        let viewInput:VHomeInput = VHomeInput(controller:self.controller)
        self.viewInput = viewInput
        
        addSubview(viewInput)
        
        layoutInputTop = NSLayoutConstraint(
            item:viewInput,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        layoutInputHeight = NSLayoutConstraint(
            item:viewInput,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kInputMaxHeight)
        let layoutInputLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewInput,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutInputRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewInput,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutInputTop,
            layoutInputHeight,
            layoutInputRight,
            layoutInputLeft])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
