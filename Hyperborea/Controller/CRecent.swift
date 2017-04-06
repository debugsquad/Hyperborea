import UIKit

class CRecent:CController
{
    private(set) var model:MRecent?
    private(set) weak var viewRecent:VRecent!
    
    override func loadView()
    {
        let viewRecent:VRecent = VRecent(controller:self)
        self.viewRecent = viewRecent
        view = viewRecent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLoad()
        }
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        parentController.statusBarAppareance(statusBarStyle:UIStatusBarStyle.lightContent)
        viewRecent.animateShow()
    }
    
    //MARK: private
    
    private func asyncLoad()
    {
        guard
        
            let recent:[DEntry] = MSession.sharedInstance.settings?.recent?.array as? [DEntry]
        
        else
        {
            return
        }
        
        model = MRecent(entries:recent)
        viewRecent.refresh()
    }
    
    //MARK: public
    
    func back()
    {
        parentController.statusBarAppareance(statusBarStyle:UIStatusBarStyle.default)
        parentController.dismissAnimateOver(completion:nil)
    }
}
