//
//  TestLayout.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/20/24.
//

import SwiftUI
//
struct Pet: Identifiable, Equatable{
    let type: String
    var votes : Int = 0
    var id: String {type}
    
    static var exampleData: [Pet] = [
           Pet(type: "Cat", votes: 25),
           Pet(type: "Goldfish", votes: 9),
           Pet(type: "Dog", votes: 16)
       ]
}
struct TestLayout: View {
    @State private var pets: [Pet] = Pet.exampleData
    var totalVotes: Int
    
    var body: some View {
        Grid(alignment: .leading){
            ForEach(pets) { pet in
                GridRow{
                    Text(pet.type)
                    ProgressView(
                        value: Double(pet.votes),
                        total: Double(totalVotes))
                    Text("\(pet.votes)")
                        .gridColumnAlignment(.trailing)
                }
                GridRow{
                    Divider().gridCellColumns(3)
                    //하나의 뷰가 여러 행에 걸쳐서 나타나게 한다 : gridCellColumns 안해주면 위의 cat, goldfish 밑에만 divider 들어감
                }
            }
        }
        //ViewThatFits 컨테이너가 뷰들을 가용공간에 맞는 뷰를 선택 - 더 큰 뷰가 먼저 선언되어야한다.
        ViewThatFits {
            //1 가로
            MyEqualWithHStack{
               Buttons(pets: $pets)
            }
            //2 세로
            VStack{
                Buttons(pets: $pets)
            }
        }
//        .environment(\.dynamicTypeSize, .accessibility3)
    }
}
struct Buttons: View {
    @Binding var pets: [Pet]
    
    var body: some View {
        ForEach($pets) { $pet in
            Button{
                pet.votes += 1
            } label: {
                Text(pet.type)
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(.bordered)
        }
    }
}

struct MyEqualWithHStack: Layout{
    
    func sizeThatFits(
        proposal: ProposedViewSize, //컨테이너에서 제안하는 크기
        subviews: Subviews, //서브뷰에도 크기 제안
        cache: inout Void //중간 계산값 공유
    ) -> CGSize {
        //subviews가 비어있으면 size = zero
        guard !subviews.isEmpty else {return .zero}
        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) {$0 + $1}
        
        return CGSize(
            width: maxSize.width * CGFloat(subviews.count) + totalSpacing, height: maxSize.height
        )
    }
    
    
    func placeSubviews(
            in bounds: CGRect, //영역을 나타내는 테두리
            proposal: ProposedViewSize,
            subviews: Subviews,
            cache: inout Void
        ) {
            // Place child views.
            guard !subviews.isEmpty else { return }
            
            let maxSize = maxSize(subviews: subviews)
            let spacing = spacing(subviews: subviews)
            let placementProposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
            //0 대신 bounds.minX + 버튼 크기의 절반 -> 첫번째 버튼의 센터 위치
            var x = bounds.minX + maxSize.width / 2
            
            for index in subviews.indices {
                //subviews 돌면서 x 차곡차곡 늘려줘
                subviews[index].place(
                    at: CGPoint(x: x, y: bounds.midY),
                    anchor: .center,
                    proposal: placementProposal)
                x += maxSize.width + spacing[index]
            }
        }
    
    private func maxSize(subviews: Subviews) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
            CGSize(
                width: max(currentMax.width, subviewSize.width),
                height: max(currentMax.height, subviewSize.height))
        }

        return maxSize
    }
    private func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal)
        }
    }
    
    
}
#Preview {
    TestLayout(totalVotes: 50)
}
