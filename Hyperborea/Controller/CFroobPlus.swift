import UIKit

class CFroobPlus:CController
{
    private(set) weak var viewFroob:VFroobPlus!
    private weak var timer:Timer?
    private let kTimerInterval:TimeInterval = 0.3
    
    deinit
    {
        timer?.invalidate()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(
            timeInterval:kTimerInterval,
            target:self,
            selector:#selector(actionTimer(sender:)),
            userInfo:nil,
            repeats:true)
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewFroob.animateShow()
    }
    
    override func loadView()
    {
        let viewFroob:VFroobPlus = VFroobPlus(controller:self)
        self.viewFroob = viewFroob
        view = viewFroob
    }
    
    //MARK: actions
    
    func actionTimer(sender timer:Timer)
    {
        viewFroob.viewContent.updateTimer()
    }
    
    //MARK: public
    
    func back()
    {
        timer?.invalidate()
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func openStore()
    {
        timer?.invalidate()
    }
}
