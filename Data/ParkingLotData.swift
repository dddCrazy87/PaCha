import CoreLocation
import Foundation

struct ParkingLotDataForApp: Identifiable {
    let id = UUID()
    
    var name: String
    var address: String
    var payex: String
    var latitude : Double
    var longitude : Double
    var totalCar: Int
    var parkingLotData: ParkingLotData
    
//    init?(from parkingLot: ParkingLotData) {
//        guard let latitude = Double(parkingLot.y),
//              let longitude = Double(parkingLot.x) else {
//            return nil
//        }
//
//        self.name = parkingLot.name
//        self.totalCar = parkingLot.totalcar
//        self.latitude = latitude
//        self.longitude = longitude
//        self.address = parkingLot.address
//        self.payex = parkingLot.payex
//        self.parkingLotData = parkingLot
//    }
    
    var img = ""
    var pricePerHour = 0
    var distance = 0.0
    var isFavorite = false
    var isRecommend = false
}

struct ParkingLotData: Codable, Identifiable {
    let id: String
    let area: String
    let name: String
    let summary: String
    let address: String
    let tel: String
    let payex: String
    let serviceTime: String
    let x: String
    let y: String
    let totalcar: Int
    let pregnancyFirst: String
    let handicapFirst: String
    let chargingStation: String
    let taxiOneHRFree: String
    let aedEquipment: String
    let accessibilityElevator: String
    let fareInfo: FareInfo
    let entranceCoord: EntranceCoord

    enum CodingKeys: String, CodingKey {
        case id, area, name, summary, address, tel, payex, serviceTime, x, y, totalcar
        case pregnancyFirst = "Pregnancy_First"
        case handicapFirst = "Handicap_First"
        case chargingStation = "ChargingStation"
        case taxiOneHRFree = "Taxi_OneHR_Free"
        case aedEquipment = "AED_Equipment"
        case accessibilityElevator = "Accessibility_Elevator"
        case fareInfo = "FareInfo"
        case entranceCoord = "EntranceCoord"
    }
}

extension ParkingLotData {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        area = try values.decode(String.self, forKey: .area)
        name = try values.decode(String.self, forKey: .name)
        summary = try values.decode(String.self, forKey: .summary)
        address = try values.decode(String.self, forKey: .address)
        tel = try values.decode(String.self, forKey: .tel)
        payex = try values.decode(String.self, forKey: .payex)
        serviceTime = try values.decode(String.self, forKey: .serviceTime)
        x = try values.decode(String.self, forKey: .x)
        y = try values.decode(String.self, forKey: .y)
        totalcar = try values.decode(Int.self, forKey: .totalcar)
        
        pregnancyFirst = try values.decodeIfPresent(String.self, forKey: .pregnancyFirst) ?? "0"
        handicapFirst = try values.decodeIfPresent(String.self, forKey: .handicapFirst) ?? "0"
        chargingStation = try values.decodeIfPresent(String.self, forKey: .chargingStation) ?? "0"
        taxiOneHRFree = try values.decodeIfPresent(String.self, forKey: .taxiOneHRFree) ?? "0"
        aedEquipment = try values.decodeIfPresent(String.self, forKey: .aedEquipment) ?? "0"
        accessibilityElevator = try values.decodeIfPresent(String.self, forKey: .accessibilityElevator) ?? "0"
        
        fareInfo = try values.decode(FareInfo.self, forKey: .fareInfo)
        entranceCoord = try values.decode(EntranceCoord.self, forKey: .entranceCoord)
    }
}

struct FareInfo: Codable {
    let workingDay: [Period]
    let holiday: [Period]

    enum CodingKeys: String, CodingKey {
        case workingDay = "WorkingDay"
        case holiday = "Holiday"
    }
}

extension FareInfo {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        workingDay = try values.decodeIfPresent([Period].self, forKey: .workingDay) ?? []
        holiday = try values.decodeIfPresent([Period].self, forKey: .holiday) ?? []
    }
}

struct Period: Codable {
    let period: String
    let fare: String

    enum CodingKeys: String, CodingKey {
        case period = "Period"
        case fare = "Fare"
    }
}

struct EntranceCoord: Codable {
    let entrancecoordInfo: [EntranceCoordInfo]

    enum CodingKeys: String, CodingKey {
        case entrancecoordInfo = "EntrancecoordInfo"
    }
}

extension EntranceCoord {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        entrancecoordInfo = try values.decodeIfPresent([EntranceCoordInfo].self, forKey: .entrancecoordInfo) ?? []
    }
}

struct EntranceCoordInfo: Codable {
    let coordinate: CLLocationCoordinate2D

    enum RootCodingKeys: String, CodingKey {
        case xcod = "Xcod"
        case ycod = "Ycod"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        let xcod = try container.decodeIfPresent(String.self, forKey: .xcod) ?? "0"
        let ycod = try container.decodeIfPresent(String.self, forKey: .ycod) ?? "0"
        coordinate = CLLocationCoordinate2D(latitude: Double(xcod) ?? 0, longitude: Double(ycod) ?? 0)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: RootCodingKeys.self)
        try container.encode(String(coordinate.longitude), forKey: .ycod)
        try container.encode(String(coordinate.latitude), forKey: .xcod)
    }
}
