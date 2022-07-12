//
//  FlickrPhotosTests.swift
//  FlickrPhotosTests
//
//  Created by MGLearniOS on 03/05/22.
//

import XCTest
@testable import FlickrPhotos

class FlickrPhotosTests: XCTestCase {
    
    private var flickrSearchVM : FlickrSearchVM!
    private var apiService : MockAPIService!
    
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiService = MockAPIService()
        flickrSearchVM = FlickrSearchVM(service: FlickrService(apiService: apiService))
    }

    
    func testAPICallWithoutData() {
        flickrSearchVM.fetchData()
        XCTAssertNil(flickrSearchVM.photoResponse)
    }
    
    func testAPIWithData(){
        let dict = ["photos":["page":"2","pages":"89","perpage":"10","total":"881","photo":[
            ["id":"2636","image":"","description":"","owner":"47058503995@N01","secret":"a123456","server":"2","title":"test_04"],["id":"2636","image":"","description":"","owner":"47058503995@N01","secret":"a123456","server":"2","title":"test_04"]]]]
        do {
            apiService.data = try JSONSerialization.data(withJSONObject: dict, options: [])
        } catch let e {
            XCTAssertNil(flickrSearchVM.photoResponse)
        }
        flickrSearchVM.fetchData()
        XCTAssertEqual(flickrSearchVM.photoResponse?.photo.count, 2)
    }
    
   
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        flickrSearchVM = nil
        apiService = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


fileprivate class MockAPIService : APISeviceProtocol {
    var data:Data?
    func callAPI(param: [String : Any]?, urlStr: String, completion: @escaping (Data?, Bool) -> Void) {
        if let data = data {
            completion(data,true)
        } else {
            completion(nil,false)
        }
    }
    
    
}
