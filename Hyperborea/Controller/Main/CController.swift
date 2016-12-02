import UIKit

class CController:UIViewController
{
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    weak var shadow:VShadow?
    
    init()
    {
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    open var name:NSString
    {
        get
        {
            let classType:AnyClass = object_getClass(self)
            
            return NSStringFromClass(classType) as NSString
        }
    }
    
    var parentController:CParent
    {
        get
        {
            return self.parent as! CParent
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        FMain.sharedInstance.analytics?.screenView(controller:self)
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.viewParent.bar.label.text = title
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    override var prefersStatusBarHidden:Bool
    {
        return false
    }
    
    //MARK: public
    
    func addShadow()
    {
        let shadow:VShadow = VShadow()
        self.shadow = shadow
        
        view.addSubview(shadow)
        
        let views:[String:UIView] = [
            "shadow":shadow]
        
        let metrics:[String:CGFloat] = [:]
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        view.layoutIfNeeded()
    }
}
