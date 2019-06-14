import UIKit
import Foundation

protocol CheckEmailProtocol: class{
    
      func didRecieveDataUpdate(data: String)
      func didRecieveDataAnnouncement(data:NSMutableArray)
      func EmailNotExist(data:String)
      func APNNotExist(data:String)
      func didRecieveDateInfo(data:NSMutableArray)
      func DataNotExist(data:String)
    
}

class CheckEmail:NSObject, URLSessionDataDelegate  {
    weak var delegate: CheckEmailProtocol?
    
    func selectAnnouncement()
    {
        let urlPath = "http://184.172.105.22/select_announcements.php"
      //  let urlPath = "http://localhost/~shivavandana/foo/select_announcements.php"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJobAnnouncement(data!)
            }
        }
        task.resume()
    }
    
    func parseJobAnnouncement(_ data:Data) {
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        var location : Announcements
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            if let message = jsonElement["announcement"] as? String,
               let url=jsonElement["url"] as? String,
               let link=jsonElement["link"] as? String
              // let start=jsonElement["startdigit"] as? Int,
              // let end=jsonElement["enddigit"] as? Int
            {
                let location = Announcements()
                location.message = message
                location.url=url
                location.link=link
               // location.start=start
               // location.end=end
                locations.add(location)
            }
            
        }
        if locations.count>0 {
            delegate?.didRecieveDataAnnouncement(data:locations)
        }
        else
        {
            delegate?.DataNotExist(data: "nodata")
        }
    }
    
    func selectdetails(job_id:String)
    {
        let urlPath = "http://184.172.105.22/select_details.php?job_id=\(job_id)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJobdetails(data!)
            }
        }
        task.resume()
    }
    
    func parseJobdetails(_ data:Data) {
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        let location = DateInfo()
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            if let date = jsonElement["date"] as? String,
                let subdivision = jsonElement["subdivision_name"] as? String,
                let status = jsonElement["job_status"] as? String,
                let lot = jsonElement["lot"] as? String,
                let jobtype = jsonElement["jobtype"] as? String
                {
                location.date = date
                location.subdivision = subdivision
                location.status = status
                location.lot = lot
                location.jobtype = jobtype
                }
            locations.add(location)
        }
        if locations.count>0 {
            delegate?.didRecieveDateInfo(data:locations)
        }
        else
        {
            delegate?.DataNotExist(data: "nodata")
        }
    }
    
    func selectdates(id:String)
    {
         let urlPath = "http://184.172.105.22/select_dates.php?contact_id=\(id)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJobdate(data!)
            }
        }
        task.resume()
    }
    
    func selectpastdates(id:String)
    {
        let urlPath = "http://184.172.105.22/select_pastdates.php?contact_id=\(id)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJobdate(data!)
            }
        }
        task.resume()
    }
    
    func parseJobdate(_ data:Data) {
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        var location : DateInfo
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            if let date = jsonElement["schedule_date"] as? String,
                let jobid = jsonElement["job_id"] as? String,
                let status = jsonElement["job_status"] as? String
            {
                location = DateInfo()
                location.date = date
                location.jobid = jobid
                location.status = status
                locations.add(location)
            }
        }
        if locations.count>0 {
            delegate?.didRecieveDateInfo(data:locations)
        }
        else
        {
            delegate?.DataNotExist(data: "nodata")
        }
    }

    
    func findEmail(email: String) {
        let urlPath = "http://184.172.105.22/Check_email.php?email=\(email)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
        if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to download data")
        }else {
                print("Data downloaded")
                self.parseJSON(data!)
              }
        }
        task.resume()
    }
 
    
    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        let location = EmailModel()
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            if let name = jsonElement["id"] as? String,
                let email = jsonElement["email"] as? String
            {
                location.name = name
                location.email = email
            }
            locations.add(location)
        }
        if locations.count>0 {
            delegate?.didRecieveDataUpdate(data:location.name!)
        }
        else
        {
            delegate?.EmailNotExist(data: "noemail")
        }
    }
    
    
    
    func findNewCustomer(email_id:String)
    {
        let urlPath = "http://184.172.105.22/Check_NewCustomer.php?id=\(email_id)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
        }
        task.resume()
        
    }

    
    
    func parseJSONNewCustomer(_ data:Data) {
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        let location = EmailModel()
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            if let name = jsonElement["apn_token"] as? String
            {
                location.name = name
            }
            locations.add(location)
        }
      if locations.count>0 {
        delegate?.didRecieveDataUpdate(data:location.name!)
        }
      else
      {
        delegate?.APNNotExist(data: "noAPN")
      }
    }
    
    func insertItems(id:String,token:String) {
        let urlPathinsert = "http://184.172.105.22/Insert_Registration.php?contact_id=\(id)&token=\(token)"
        print(urlPathinsert)
        let url: URL = URL(string: urlPathinsert)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to insert data")
            }else {
                print("Data inserted")
            }
        }
        task.resume()
    }
    
    
    func YesStatus(jobid:String,confirmed_from:String,job_notes:String) {
        let urlPathinsert = "http://184.172.105.22/Update_StatusYes.php?jobid=\(jobid)&confirmed_from=\(confirmed_from)&job_notes=\(job_notes)"
        print(urlPathinsert)
        let url: URL = URL(string: urlPathinsert)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to insert yes data")
            }else {
                print("Data inserted")
            }
        }
        task.resume()
    }
    
    func Update_scheduledate(jobid:String,schedule_date:String,confirmed_from:String) {
        let urlPathinsert = "http://184.172.105.22/Update_Scheduledate.php?jobid=\(jobid)&schedule_date=\(schedule_date)&confirmed_from=\(confirmed_from)"
        let url: URL = URL(string: urlPathinsert)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to update schedule data")
            }else {
                print("Data inserted")
            }
        }
        task.resume()
    }
    func Update_Message(id:String,msg:String)
    {
        let urlPathinsert = "http://184.172.105.22/Update_Message.php?id=\(id)&message=\(msg)"
        print(urlPathinsert)
        let url: URL = URL(string: urlPathinsert)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error ------\(String(describing: error))")
                print("Failed to update schedule data")
            }else {
                print("Data inserted")
            }
        }
        task.resume()
        
    }
}

