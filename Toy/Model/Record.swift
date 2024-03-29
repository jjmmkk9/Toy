//
//  Record.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import Foundation

struct Record: Hashable, Identifiable {
    var id: Int
    
    var name : String = "회의"
    var summary : String = "국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다. 선거에 있어서 최고득표자가 2인 이상인 때에는 국회의 재적의원 과반수가 출석한 공개회의에서 다수표를 얻은 자를 당선자로 한다."
    var people: Int = 4
    private var totalTime : Int = 3035
    
    var totalTimeString : String {
        return "\(totalTime / 60 ) 분 \(totalTime % 60) 초"
    }
    private var editTime : Date = Date()
    
    var editTimeString : String {
        return editTimeToString(editTime: editTime)
    }
    var createTime : Date? = stringToDateTime(dateString: "2024-02-05 14:30:00")
    
    var simpleTimeString : String{
        return simpleRecordTimeString(createTime: createTime!)
    }
    var detailTimeString : String {
        return recordDetailTimeString(createTime: createTime!, editTime: editTime)
    }
    
    var category: String = "기본"
    var keyword : [String] = ["쿠폰 할인" , "할인 쿠폰", "자제", "감사합니다", "반", "국민", "팝업", "정산", "다운로드", "만료", "ios", "클라이언트", "코코", "쩸", "바코", "서텔라", "상세", "결제", "유저", "지슬란", "별의 커비", "에어팟", "법률"]
    
    var allText : [String] = ["그치 좀 자제하겠습니다.", "아이고 감사합니다. 반반 반반 반 말고 반반", "이래 오래 걸리나", "유저를 위해 결제를 ios로 했는데 클라이언트 국민 팝업 정산이 오래걸리잖아","엄청 느려요. 저거 나름 사양 높은 건데 저거 그때 그거 크롤링 한번 하고 나서 많이 났잖아요. 그럼 도매장 해야 되는거 아니에요?", "포맷하고 다 했어 했는데 그때 간 거야. 그때 어플리케이션 10개를 24시간 한 달 돌렸잖아", "만료 만요 만료 만뇨","오버클럭됐네. 아마 그 이후로 좀 많이 느리더라고요. 맞죠? 그 몸이 많이 안 좋아졌네.","관리자 조금 많이 힘들어하네요.","별의 커비 귀여워" ,"서텔라는 재해를 예방하고 그 위험으로부터 바코을 보호하기 위하여 노력하여야 한다. 코코의 모든 자유와 권리는 국가안전보장·쩸 또는 공공복리를 위하여 필요한 경우에 한하여 법률로써 제한할 수 있으며, 제한하는 경우에도 자유와 권리의 본질적인 내용을 침해할 수 없다.", "상세 페이지는 코코를 죽여","모든 국민은 법률이 정하는 바에 의하여 공무담임권을 가진다. 선거에 관한 경비는 법률이 정하는 경우를 제외하고는 정당 또는 후보자에게 부담시킬 수 없다. 감사합니다.", "지슬란은 회계연도마다 예산안을 편성하여 회계연도 개시 90일전까지 국회에 제출하고, 국회는 회계연도 개시 30일전까지 이를 의결하여야 한다. 전직대통령의 신분과 예우에 관하여는 법률로 정한다.", "에어팟이 고장난 사람은 슬프다."]
    
    init(id: Int) {
        self.id = id
    }
    
    var memo : String = ""
    
}

extension Record {
    /// 파일 업로드시 record 추가 생성자 : name, totalTime에 int로 캐스팅해서 넣기, id는 걍 넣기^^
    init(id: Int, name: String, totalTime: Int, createTime: Date){
        self.id = id
        self.name = name
        self.totalTime = totalTime
        self.createTime = createTime
    }
    
}


class RecordViewModel: ObservableObject{
    static let shared = RecordViewModel()
    @Published var presented : Record?{
        didSet{
            print("presented changed")
        }
    }
    
    @Published var records : [Record]
    @Published var filteredRecords : [Record]
    
    init() {
        self.records = ModelData.modelData.records
      self.filteredRecords = []
    }
    
    func dayRecords(date : Date) -> [Record]{
        let fr = records.filter{
            Calendar.current.isDate(date, inSameDayAs: $0.createTime ?? Date())
        }
        return fr
    }

    func updateRecord(record: Record) {
        if let index = self.records.firstIndex(where: { $0.id == record.id }) {
            self.records[index] = record
        }
    }
        //memo 넣은 record 객체를 presented에 update
    func updatePresented(record: Record){
        self.presented = record
    }
}
