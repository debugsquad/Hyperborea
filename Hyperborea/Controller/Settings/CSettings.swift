import UIKit

class CSettings:CController
{
    private weak var viewSettings:VSettings!
    
    deinit
    {
        viewSettings.viewBackground.timer?.invalidate()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.statusBarAppareance(statusBarStyle:UIStatusBarStyle.lightContent)
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
}
