
import XCTest
@testable import GraphQL_Apollo_Demo

@MainActor
final class DefaultProductRepositoryTests: XCTestCase {
    
    var mockClient: MockApolloClient!
    var countryRepository: CountryRepository!
    
    override func setUp() async throws {
        mockClient = MockApolloClient()
        mockClient.mockData = try await mockClient.createMockCountriesData()
        countryRepository = DefaultProductRepository(apollo: mockClient)
    }
    
    
    func test_countrylistSuccess() async throws {
        let countrylist = try await countryRepository.getCountries()
        
        XCTAssertEqual(countrylist.count, 1)
        
        let first = countrylist.first
        XCTAssertTrue(first?.name == "India")
    }
    
    func test_countrylistFail() async {
        mockClient.shouldFail = true
        mockClient.mockError = NSError(domain: "MockError", code: 500)
        
        do {
            _ = try await countryRepository.getCountries()
            XCTFail("Expected getCountries() to throw an error")
        } catch {
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "MockError")
            XCTAssertEqual(nsError.code, 500)
        }
    }
}
