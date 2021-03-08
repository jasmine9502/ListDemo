//
//  LDNetwork.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/4.
//
import Moya

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<LDApi>.RequestResultClosure) -> Void in

    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}
let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = 20
        // 打印请求参数
        if let requestData = request.httpBody {
            NSLog("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            NSLog("\(request.url!)"+"\n"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

let ApiProvider = MoyaProvider<LDApi>(requestClosure:requestClosure)

enum LDApi {
    case getUser(keyWork:String,intPage:Int)//用户列表
}

extension LDApi: TargetType {

    var baseURL: URL { return URL.init(string: "https://api.github.com")! }

    var path: String {
        switch self {
        /*用户列表*/
        case .getUser: return "/search/users"

        }
    }

    var method: Moya.Method {
            return .get
    }

    var task: Task {
        var parmeters: [String : Any] = [:]
        switch self {
        case .getUser(let keyword,let page):
            parmeters["page"] = max(1, page)
            parmeters["q"] = keyword
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

struct LDNetwork {
    static func request(_ target: LDApi, successCallback: @escaping (NSDictionary) -> Void,
                        failure failureCallback: @escaping (String) -> Void){
        ApiProvider.request(target) { (result) in
            switch result{
            case let .success(response):
                if let json = try? response.mapJSON() as! NSDictionary{
                    successCallback(json["items"] as! NSDictionary)
                    print(json as Any)
                }
                else{
                    print("服务器连接成功,数据获取失败")
                }
            case let .failure(error):
                failureCallback(error.errorDescription!)
            }
        }
    }
}



