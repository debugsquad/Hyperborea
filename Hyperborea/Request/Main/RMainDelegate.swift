import Foundation

protocol RMainDelegate:class
{
    func requestFinished(
        model:RModel?,
        status:RMain.StatusCode?,
        error:String?)
}
