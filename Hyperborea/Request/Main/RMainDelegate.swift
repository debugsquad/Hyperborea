import Foundation

protocol RMainDelegate:class
{
    func requestFinished(
        settingsId:RSettings.SettingsId,
        model:RModel?,
        status:RMain.StatusCode?,
        error:String?)
}
