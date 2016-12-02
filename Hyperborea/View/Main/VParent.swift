import UIKit

class VParent:UIView
{
    weak var bar:VBar!
    private weak var layoutBarHeight:NSLayoutConstraint!
    let kBarHeight:CGFloat = 64
    let kBarMinHeight:CGFloat = 20
    private let kAnimationDuration:TimeInterval = 0.3
    
    convenience init(parent:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.main
        
        let barDelta:CGFloat = kBarHeight - kBarMinHeight
        let bar:VBar = VBar(parent:parent, barHeight:kBarHeight, barDelta:barDelta)
        self.bar = bar
        addSubview(bar)
        
        let views:[String:UIView] = [
            "bar":bar]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBarHeight = NSLayoutConstraint(
            item:bar,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kBarHeight)
        
        addConstraint(layoutBarHeight)
    }
    
    //MARK: private
    
    func addControllerView(
        controller:CController,
        underBar:Bool,
        constantLeft:CGFloat,
        constantRight:CGFloat,
        constantTop:CGFloat,
        constantBottom:CGFloat)
    {
        if underBar
        {
            insertSubview(controller.view, belowSubview:bar)
        }
        else
        {
            addSubview(controller.view)
        }
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:constantLeft)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:constantRight)
        controller.layoutTop = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:constantTop)
        controller.layoutBottom = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:constantBottom)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
        addConstraint(controller.layoutTop)
        addConstraint(controller.layoutBottom)
        
        layoutIfNeeded()
    }
    
    //MARK: public
    
    func scroll(
        controller:CController,
        currentController:CController,
        delta:CGFloat,
        underBar:Bool,
        completion:@escaping(() -> ()))
    {
        addControllerView(
            controller:controller,
            underBar:underBar,
            constantLeft:-delta,
            constantRight:-delta,
            constantTop:0,
            constantBottom:0)
        
        controller.layoutLeft.constant = 0
        controller.layoutRight.constant = 0
        currentController.layoutLeft.constant = delta
        currentController.layoutRight.constant = delta
        
        UIView.animate(withDuration:kAnimationDuration,
                       animations:
        {
            self.layoutIfNeeded()
        })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func over(
        controller:CController,
        underBar:Bool,
        animate:Bool,
        completion:@escaping(() -> ()))
    {
        addControllerView(
            controller:controller,
            underBar:underBar,
            constantLeft:0,
            constantRight:0,
            constantTop:0,
            constantBottom:0)
        
        if animate
        {
            controller.view.alpha = 0
            
            UIView.animate(withDuration:kAnimationDuration,
                           animations:
            {
                controller.view.alpha = 1
            })
            { (done:Bool) in
                
                completion()
            }
        }
        else
        {
            completion()
        }
    }
    
    func push(
        controller:CController,
        currentController:CController,
        underBar:Bool,
        completion:@escaping(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        let width_2:CGFloat = width / 2.0
        
        addControllerView(
            controller:controller,
            underBar:underBar,
            constantLeft:width,
            constantRight:width,
            constantTop:0,
            constantBottom:0)
        
        controller.layoutLeft.constant = 0
        controller.layoutRight.constant = 0
        currentController.layoutLeft.constant = -width_2
        currentController.layoutRight.constant = -width_2
        currentController.addShadow()
        bar.push(name:controller.title)
        
        UIView.animate(withDuration:kAnimationDuration,
                       animations:
        {
            self.layoutIfNeeded()
            currentController.shadow?.maxAlpha()
        })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func pop(
        currentController:CController,
        previousController:CController,
        popBar:Bool,
        completion:@escaping(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        currentController.layoutRight.constant = width
        currentController.layoutLeft.constant = width
        previousController.layoutLeft.constant = 0
        previousController.layoutRight.constant = 0
        
        if popBar
        {
            bar.pop()
        }
        
        UIView.animate(withDuration:kAnimationDuration,
                       animations:
        {
            self.layoutIfNeeded()
            previousController.shadow?.minAlpha()
        })
        { (done:Bool) in
            
            previousController.shadow?.removeFromSuperview()
            completion()
        }
    }
    
    func dismiss(
        currentController:CController,
        completion:@escaping(() -> ()))
    {
        UIView.animate(withDuration:kAnimationDuration,
                       animations:
        {
            currentController.view.alpha = 0
        })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func dismissBelow(
        currentController:CController,
        completion:@escaping(() -> ()))
    {
        let height:CGFloat = bounds.maxY
        currentController.layoutBottom.constant = height
        currentController.layoutTop.constant = height
        
        UIView.animate(withDuration:kAnimationDuration,
                       animations:
        {
            self.layoutIfNeeded()
        })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func scrollDidScroll(scroll:UIScrollView)
    {
        var offsetY:CGFloat = kBarHeight - scroll.contentOffset.y
        
        if offsetY < kBarMinHeight
        {
            offsetY = kBarMinHeight
        }
        
        layoutBarHeight.constant = offsetY
    }
}
