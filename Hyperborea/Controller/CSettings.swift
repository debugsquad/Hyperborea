import UIKit

class CSettings:CController
{
    let model:MSettings
    private weak var viewSettings:VSettings!
    private var firstTime:Bool
    private let urlMap:[String:String]?
    private let kResourceName:String = "ResourceUrl"
    private let kResourceExtension:String = "plist"
    private let kReviewKey:String = "review"
    private let kShareKey:String = "share"
    
    override init()
    {
        model = MSettings()
        firstTime = true
        
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let urlDictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl),
            let urlMap:[String:String] = urlDictionary as? [String:String]
            
        else
        {
            self.urlMap = nil
            
            super.init()
            
            return
        }
        
        self.urlMap = urlMap
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
    
    func review()
    {
        guard
            
            let urlString:String = urlMap?[kReviewKey],
            let url:URL = URL(string:urlString)
            
        else
        {
            return
        }
        
        UIApplication.shared.openURL(url)
    }
    
    func share()
    {
        guard
            
            let urlString:String = urlMap?[kShareKey],
            let url:URL = URL(string:urlString)
            
        else
        {
            return
        }
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[url],
            applicationActivities:nil)
        
        if let popover:UIPopoverPresentationController = activity.popoverPresentationController
        {
            popover.sourceView = viewSettings
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
}
