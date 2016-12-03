import UIKit

class CParent:UIViewController
{
    weak var viewParent:VParent!
    private var statusBarStyle:UIStatusBarStyle
    private var barHidden:Bool
    
    init()
    {
        statusBarStyle = UIStatusBarStyle.default
        barHidden = false
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let home:CHome = CHome()
        pushController(controller:home)
    }
    
    override func loadView()
    {
        let viewParent:VParent = VParent(controller:self)
        self.viewParent = viewParent
        view = viewParent
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return statusBarStyle
    }
    
    override var prefersStatusBarHidden:Bool
    {
        return barHidden
    }
    
    //MARK: public
    
    func pushController(controller:CController)
    {
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:false)
        
        guard
            
            let vview:VView = controller.view as? VView
        
        else
        {
            return
        }
            
        viewParent.pushView(
            view:vview)
        {
            controller.endAppearanceTransition()
        }
    }
}
