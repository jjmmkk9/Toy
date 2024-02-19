//
//  Calender.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/6/24.
//

import SwiftUI



struct CalenderView: View {
    //현재 달력의 월 정보 들고 있는 month
    @State private var month : Date = Date()
    @State private var offset: CGSize = CGSize()
    @State private var clickedDate: Date = Date()
    @State private var isToday: Bool = true
    @State private var changedMonth: Int = 0
    @State private var dateViewModel = DateViewModel.shared
    
    var today : Date = Date()
    var history = ModelData.modelData.history
    //전체 레코드
    @State private var records : [Record] = ModelData.modelData.records
    @Binding var clicked : Bool
    @Binding var wheelOn : Bool
    
    @State private var record : Record?

    var body: some View {
        NavigationStack{
            
            VStack {
                headerView
                calendarGridView
            }
            .padding()
            .onChange(of: dateViewModel.newMonth){ newValue in
                updateStates(date: newValue)
            }
            //드래그 제스처로 달 옮기기
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                    }
                    .onEnded { gesture in
                        if self.offset.width < -100 {
                            changeMonth(by: 1)
                            
                        } else if self.offset.width > 100 {
                            changeMonth(by: -1)
                            
                        }
                        self.offset = CGSize()
                    }
            )
            //clickedDate에 해당하는 레코드
            VStack{
                
                let filterdRecord : [Record] = ModelData.modelData.dayRecords(date: clickedDate)
                if !filterdRecord.isEmpty {
                    ScrollView{
                        ForEach(filterdRecord.indices) { index in
                            let record = filterdRecord[index]
                            SimpleRecordItem(record: record)
                                .onTapGesture {
                                    records[index] = record
                                    records[index].isPresented.toggle()
                                }
                                .fullScreenCover(isPresented: $records[index].isPresented, content: {
                                    RecordDetailView(record: record)
                                })
                        }
                        Text("")
                            .frame(height: 50)
                    }
                    .padding(.bottom, 20)
                }else{
                    Text("노트가 없습니다.")
                    
                }
            }
            .padding()
            .frame(maxHeight: .infinity)
        }
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        let daysSymbol = ["일", "월", "화", "수", "목", "금", "토"]
        return VStack {
            //달 선택
            HStack(alignment: .top){
                Button{
                    clicked = true
                    wheelOn = true
                }label: {
                    HStack(alignment: .top){
                        Text(month, formatter: Self.dateFormatter)
                            .font(.title)
                            .padding(.bottom)
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(.top, 13)
                    }
                    .foregroundStyle(Color("blackWhite"))
                }
                
                Spacer()
                //버튼 누르면 오늘날짜로 이동 - 기능
                //이미 오늘 날짜 선택되어있으면 오늘 버튼 그레이로 - state
                Text("오늘")
                    .frame(width: 60, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(isToday ? Color("blackWhite") : .secondary, lineWidth: 2)
                        
                    )
                    .foregroundStyle(isToday ? Color("blackWhite") : .secondary)
                    .onTapGesture {
                        if !isToday{
                            combackToday()
                            clickedDate = today
                            isToday = true
                        }
                    }

            }
            HStack {
                ForEach(Array(daysSymbol.enumerated()), id: \.1) { index, symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(index == 0 ? .red : Color("blackWhite"))
                }
            }
            .padding(.bottom, 10)
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday {
                        //0부터 4까지는 .clear
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        //그 이후로는 생성 1부터 lastIndex까지 생성
                        let date = getDate(for: index - firstWeekday)
                        
                        let day = index - firstWeekday + 1
                        let clicked = isSameDay(date1: clickedDate, date2: date)
                        let isSunday = Calendar.current.component(.weekday, from: date) == 1
                        let isExists = !history.filter{isSameDay(date1: date, date2: $0)}.isEmpty
                        
                        //일자 생성
                        CellView(day: day, clicked: clicked, isSunday : isSunday, isExists : isExists)
                            .onTapGesture {
                                if !clicked {
                                    clickedDate = date
                                    isToday = isSameDay(date1: clickedDate, date2: today)
                                    
                                }
                            }
                        
                    }
                    
                }
            }
            .padding(.bottom, 10)
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    var day: Int
    var clicked: Bool = false
    var isSunday: Bool = false
    var isExists: Bool = false
    
    var body: some View {
        ZStack {
            if clicked {
                ClickedCellView(day: day)
                
            }else{
                RoundedRectangle(cornerRadius: 5)
                    .padding(15)
                    .opacity(0)
                    .overlay(Text(String(day)))
                    .foregroundColor(isSunday ? .red : Color("blackWhite"))
                
                
            }
            Text(".")
                .font(.system(size: 40))
                .offset(y:10)
                .foregroundStyle(.blue)
                .opacity(isExists ? 1 : 0)
        }
        .frame(height: 40)
    }
}
private struct ClickedCellView: View{
    var day: Int
    var body: some View{
        RoundedRectangle(cornerRadius: 5)
            .padding(15)
            .opacity(0)
            .overlay(
                Text(String(day))
                    .bold()
                    .foregroundStyle(Color("tempColor"))
                    .background(
                        Circle()
                            .foregroundStyle(Color("blackWhite"))
                            .scaledToFill()
                            .frame(width: 30)
                    )
            )
    }
}


// MARK: - 내부 메서드
extension CalenderView {
    /// 특정 해당 날짜
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일 - 일요일=1, 월요일=2, ..., 토요일=6
    func firstWeekdayOfMonth(in date: Date) -> Int {
        //components에 넣는 date가 2024년 2월
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 월 변경 - by Value : today로부터의 거리 -1 이면 -1달
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            //month 업데이트
            self.month = newMonth
            clickedDate = startOfMonth()
            isToday = isSameDay(date1: clickedDate, date2: today)
            changedMonth += value
            print(month)
            
        }
    }
    //오늘 눌렀을때 돌아가기
    func combackToday(){
        self.month = today
        clickedDate = today
        isToday = isSameDay(date1: clickedDate, date2: today)
        changedMonth = 0
    }
    func differenceInMonths(from date: Date, to secondDate: Date) -> Int{
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.month], from: date, to: secondDate)
        return difference.month ?? 0
    }
    
    func updateStates(date : Date) {
        print("update month : \(date)")
        self.month = date
        changedMonth += differenceInMonths(from: today, to: date)
        if changedMonth == 0 {
            clickedDate = today
        }else{
            clickedDate = startOfMonth()
            print("changed month : \(changedMonth)")
        }
        isToday = isSameDay(date1: clickedDate, date2: today)
        
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
}


// MARK: - Static 프로퍼티
extension CalenderView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.M"
        return formatter
    }()
    
}

#Preview {
    CalenderView(clicked: .constant(true), wheelOn: .constant(true))
}

