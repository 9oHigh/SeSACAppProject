# 새싹 커뮤니티 🌱

### 주요 기술 스택
`MVVM` `SnapKit` `URLSession` 

---

##  ✔ 학습 및 적용 🏃🏻‍♂️

### 1. SnapKit 
   * 프로젝트의 모든 뷰를 SnapKit을 활용해 만들었습니다. 기존의 AutoLayout을 이용할 수 있었지만 코드 베이스의 UI를 학습 및 적용하기 위해 사용했습니다. 다만, 사용하면서 SnapKit에 더욱 빠지게 되었다는😊


### 2. MVVM
   * MVVM : 기존의 크고 작은 프로젝트들은 모두 MVC 디자인 패턴을 활용했지만 새싹 커뮤니티 프로젝트에서는 MVVM을 학습 및 적용했습니다. 
   * 기존의 MVC와 비교해 UI의 변경사항만 ViewController에 적용함으로써 가독성이 좋아졌고 오류가 발생했을 때 발생지점을 찾는 것이 수월해 졌습니다.

      * Observable 클래스를 이용하여 View와 viewModel을 연결 및 업데이트 

        ```swift
         class Observable<T> {

            private var listener: ( (T) -> Void )?

            var value: T {
                didSet{
                    listener?(value)
                }
            }

            init(_ value: T){
                self.value = value
            }

            func bind(_ closure: @escaping (T) -> Void){
                closure(value)
                listener = closure
            }
         }
        ```
        
### 3. EndPoint, URLSession and RESTful API
   * HTTP Method(POST, GET, PUT, DELETE)를 이용해 CRUD Operation을 처음으로 적용해본 프로젝트입니다. 
   * 회원가입, 회원탈퇴, 비밀번호 변경, 게시물 게시 및 수정, 삭제등을 구현해봄으로써 RESTful API를 학습했습니다.
   
      * Enum을 이용해 각 HTTPMethod를 사용  

        ```swift
        enum HttpMethod : String{
            case GET
            case POST
            case PUT
            case DELETE
        }
        ```        

     * Enum을 이용해 EndPoint를 구분 / url 프로퍼티를 생성하고 각 케이스에 맞는 EndPoint를 반환 및 활용

        ```swift
        enum Endpoint {
          case signup
          case signin
          case post
          case posts
          case comments
          case changePWD
          case uploadPost
          case uploadComment
         }

        extension Endpoint {

            var url: URL {

            switch self {
            case .signup: return .makeEndpoint("auth/local/register")
            case .signin: return .makeEndpoint("auth/local")
            case.changePWD : return .makeEndpoint("custom/change-password")
            case .post:
                return .makeEndpoint("posts/")
            case .posts : return .makeEndpoint("posts?_sort=created_at:desc")
            case .uploadPost: return .makeEndpoint("posts")
            case .comments:
                return .makeEndpoint("comments?post=")

            case .uploadComment:
                return .makeEndpoint("comments")
                }
            }
        }
        ```

     * URL의 baseURL을 지정하고 EndPoint를 부여후 반환

        ```swift
        extension URL {

            static let baseURL = "http://test.monocoding.com:1231/"

            static func makeEndpoint(_ endpoint: String) -> URL {
                URL(string: baseURL + endpoint)!
            }
        }
        ```
     * URLSession과 Generic을 이용하여 API 호출 및 응답 (Decodable)

        ```swift
        extension URLSession {
    
            typealias Handler = (Data?, URLResponse?, Error? ) -> Void

            //외부
            @discardableResult //내부 반환 필요없음
            func dataTask(_ endpoint: URLRequest, handler : @escaping Handler) -> URLSessionDataTask {
                let tasks = dataTask(with: endpoint, completionHandler: handler)
                tasks.resume()
                return tasks
            }

            //내부
            static func request<T : Decodable>(_ session: URLSession = .shared,endpoint: URLRequest,completion : @escaping  (T?, APIError?) -> Void){
                session.dataTask(endpoint) { data, response, error in
                    guard error == nil else {
                        completion(nil, .failed)
                        return
                    }

                    guard let data = data else {
                        completion(nil, .noData)
                        return
                    }

                    guard let response = response as? HTTPURLResponse else {
                        completion(nil, .invalidResponse)
                        return
                    }

                    guard response.statusCode == 200 else {
                        switch response.statusCode {
                            case 400 : completion(nil,.badRequest)
                            case 401: completion(nil,.unAuthorized)
                            case 404: completion(nil,.notFound)
                            case 408: completion(nil,.timeout)
                            default:
                            completion(nil,.failed)
                        }
                        return
                    }

                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(T.self, from: data)
                        completion(decoded, nil)
                    } catch {
                        print("Decode Error")
                        completion(nil,.invalidData)
                    }

                }
            }
        }
        ```
        
<br></br>

###  ✔ 배워야할 & 배우고 싶은 기술 🏃🏻‍♂️
  * RxSwift : MVVM 디자인 패턴을 학습하면서 RxSwift라는 라이브러리를 알게 되었습니다. MVVM에서 활용했던 바인딩과 함께 RxSwift를 활용할 경우 더욱 용이하게 UI를 최신 상태를 유지할 수 있다는 점에서 학습의 필요성을 느꼈습니다.


  * Moya : URLSession은 가독성이 떨어지고 모듈화를 따로 진행해야하는 등 개발 측면에서 다소 불편함이 있다고 생각했습니다. 주로 Alamofire를 사용해왔기에 다음 번 프로젝트에서는 이를 더 추상화 시킨 Moya를 경험하고 싶어졌습니다. 

<br></br>

### ✔ UI 및 기능 구현 🧑🏻‍💻
<div : center>
  
|첫번 째|두번 째|
|:---:|:---:|
|<img src="https://user-images.githubusercontent.com/53691249/152357393-6680d3dd-9218-4a4e-af7d-48c525031ce5.gif" width="300" height="600"/>|<img src="https://user-images.githubusercontent.com/53691249/152357638-a2c281ab-7af4-41c2-b09f-c242dd273ba5.gif" width="300" height="600"/>|
| 회원가입 : 이메일, 닉네임 및 입력한 비밀번호가 일치하는지 여부를 판단<br></br> 로그인 : 등록된 유저의 계정을 이용해 로그인| 작성 : 게시물 및 댓글을 작성할 수 있으며 수정 및 삭제기능도 구현하였음 <br></br>메인화면 : 스크롤시 테이블뷰를 리프레쉬하면서 데이터를 다시 받아오는 기능을 구현|

</div>



