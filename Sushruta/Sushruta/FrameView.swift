//
//  FrameView.swift
//  Sushruta
//
//  Created by 劉鈺祥 on 2022/10/5.
//
import SwiftUI
import UIKit

struct FrameView: View {
    var image: CGImage?
    var bbox: CGRect?
    private let label = Text("frame")
    
    var body: some View {
        if let image = image {
            if(bbox == nil){
                Image(decorative: image, scale: 1.0)
                    .resizable()
                    .frame(width: 500, height: 350)
            }else{
                Image(decorative: image, scale: 1.0)
                    .resizable()
                    .frame(width: 500, height: 350)
                    .overlay(
                        GeometryReader { geometry in
                            Rectangle()
                                .path(in: bbox!)
                                .stroke(Color.red, lineWidth: 2.0)
                        }
                    )
            }
        } else {
            Color.black
        }
    }
}
