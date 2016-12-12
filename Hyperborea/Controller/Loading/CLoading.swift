import UIKit

class CLoading:CController
{
    private weak var viewLoading:VLoading!
    
    override func viewDidLoad()
    {
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(self.notifiedSessionLoaded(sender:)),
            name:Notification.sessionLoaded,
            object:nil)
        
        MSession.sharedInstance.loadSession()
    }
    
    override func loadView()
    {
        let viewLoading:VLoading = VLoading(controller:self)
        self.viewLoading = viewLoading
        view = viewLoading
    }
    
    //MARK: notified
    
    func notifiedSessionLoaded(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            
        }
    }
}
