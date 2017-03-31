import UIKit

class CSettings:CController
{
    private weak var viewSettings:VSettings!
    private var firstTime:Bool
    
    override init()
    {
        firstTime = true
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        viewSettings.viewBackground.timer?.invalidate()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.statusBarAppareance(statusBarStyle:UIStatusBarStyle.lightContent)
        
        if firstTime
        {
            firstTime = false
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                    
                self?.viewSettings.viewBackground.startTimer()
            }
        }
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        parentController.statusBarAppareance(statusBarStyle:UIStatusBarStyle.default)
    }
    
    override func loadView()
    {
        let viewSettings:VSettings = VSettings(controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
