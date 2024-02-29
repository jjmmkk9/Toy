//
//  SearchBar.swift
//  Toy
//
//  Created by 조문기 on 2/25/24.
//

import SwiftUI

class SearchViewModel : ObservableObject{
    
    static let shared = SearchViewModel()
    
    @Published var searchTxt : String = ""{
        didSet{
            self.count = 0
            self.index = 0
            self.text = self.searchTxt
            self.indices = matchingString(of: searchTxt, in: allText)
        }
    }
    @Published var text : String = ""
    @Published var count : Int = 0
    @Published var index : Int = 0
    @Published var isOpen : Bool = false
    @Published var indices : [Int] = []
    var allText : [String] = []
    
    func openBarWithKeyword(keyword : String) {
        if !self.isOpen{
            self.isOpen = true
        }
        self.searchTxt = keyword
    }
    func matchingString(of substring: String, in strings: [String]) -> [Int] {
        return strings.enumerated().flatMap { index, string in
            let cnt = stringCount(str: string, substring: substring)
            return Array(repeating: index, count: cnt)
        }
    }
    func stringCount(str: String, substring: String) -> Int{
        let cnt = str.components(separatedBy: substring).count - 1
        return cnt
    }
    func createRowIndices(from array: [Int]) -> [Int] {
        var counts : [Int] = [0]
        var indices : [Int?] = [array.first]
        var arrcopy = array
        arrcopy.removeFirst()
        for (idx, el) in arrcopy.enumerated() {
            if indices[idx] == el{
                indices.append(el)
                counts.append(counts[idx] + 1)
            }else{
                indices.append(el)
                counts.append(0)
            }
            
        }
        return counts
    }
    
}


struct SearchBar: View {
    @StateObject var searchVm = SearchViewModel.shared
    
    
    var body: some View {
        VStack(spacing: 10){
            
            HStack(alignment: .center){
                //검색창
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                    TextField("음성 기록 검색", text: $searchVm.text)
                        .onSubmit {
                            searchVm.searchTxt = searchVm.text
                        }
                    Spacer()
                    if !searchVm.text.isEmpty{
                        Button{
                            searchVm.text = ""
                        }label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .frame(height: 50)
                        .foregroundStyle(.gray)
                    
                )
                .padding(10)
                
                Text("취소")
                    .onTapGesture {
                        withAnimation{
                            searchVm.text = ""
                            searchVm.searchTxt = ""
                            searchVm.isOpen = false
                        }
                    }
            }
            .padding(.horizontal, 10)
            if !searchVm.searchTxt.isEmpty{
                HStack{
                    Spacer()
                    Button {
                        indexDown()
                    } label: {
                        Image(systemName: "chevron.up")
                            .font(.title3)
                            .foregroundStyle(Color("blackWhite"))
                    }
                    .disabled(searchVm.count < 2)
                    Text("  \(searchVm.index + 1) / \(searchVm.count)  ")
                        .font(.title3)
                    Button {
                        indexUp()
                    } label: {
                        Image(systemName: "chevron.down")
                            .font(.title3)
                            .foregroundStyle(Color("blackWhite"))
                    }
                    .disabled(searchVm.count < 2)
                }
                .padding([.horizontal, .bottom], 20)
            }
        }
        .background(Color("tempColor"))
    }
    
    func indexUp(){
        guard searchVm.count > 0 else {return}
        searchVm.index = (searchVm.index + 1) % searchVm.count
        
    }
    func indexDown(){
        guard searchVm.count > 0 else {return}
        searchVm.index = (searchVm.index + searchVm.count - 1) % searchVm.count
    }
}

//#Preview {
//    //    SearchBar(isOpen: .constant(true), searchTxt: .constant(""), count: .constant(1), index: .constant(0))
//    SearchBar()
//}
