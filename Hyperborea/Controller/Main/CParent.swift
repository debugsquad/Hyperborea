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
        
        let loading:CLoading = CLoading()
        mainController(controller:loading)
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
    
    func mainController(controller:CController)
    {
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:false)
        
        guard
            
            let vView:VView = controller.view as? VView
        
        else
        {
            return
        }
            
        viewParent.mainView(view:vView)
        controller.endAppearanceTransition()
    }
    
    func animateOver(controller:CController)
    {
        guard
            
            let currentController:CController = childViewControllers.last as? CController,
            let vView:VView = controller.view as? VView
            
        else
        {
            return
        }
        
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:true)
        currentController.beginAppearanceTransition(false, animated:true)
        
        viewParent.animateOver(
            view:vView)
        {
            controller.endAppearanceTransition()
            currentController.endAppearanceTransition()
        }
    }
    
    func dismissAnimateOver()
    {
        guard
            
            let currentController:CController = childViewControllers.last as? CController,
            let vView:VView = currentController.view as? VView
            
        else
        {
            return
        }
        
        currentController.removeFromParentViewController()
        
        guard
            
            let previousController:CController = childViewControllers.last as? CController
        
        else
        {
            return
        }
        
        currentController.beginAppearanceTransition(false, animated:true)
        previousController.beginAppearanceTransition(true, animated:true)
        
        viewParent.dismissAnimateOver(
            view:vView)
        {
            currentController.endAppearanceTransition()
            previousController.endAppearanceTransition()
        }
    }
}
