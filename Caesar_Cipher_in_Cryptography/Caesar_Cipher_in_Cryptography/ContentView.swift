//
//  ContentView.swift
//  Caesar_Cipher_in_Cryptography
//
//  Created by Huy Vu on 10/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = "" //"Plaintext" là văn bản rõ ràng, văn bản mà bạn muốn mã hóa.
    @State private var shiftAmountText = "" // "Shift" là độ dịch, số vị trí mà mỗi chữ cái trong văn bản rõ ràng được thay thế trong bảng chữ cái mật mã.
    @State private var encryptedText = "" //"Ciphertext" là văn bản mã hóa, văn bản sau khi đã được mã hóa.
    
    
    var body: some View {
        VStack {
            TextField("Enter text", text: $inputText)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()  //để người dùng nhập văn bản cần mã hóa.
            
            TextField("Enter shift amount", text: $shiftAmountText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .padding() //để người dùng nhập số nguyên để dịch chuyển.
            
            Button("Encrypt", action: encryptText)
                .padding() // để kích hoạt mã hóa.
            
            Text("Encrypted Text:")
                            .font(.headline)
                            .padding()
            
            Text(encryptedText)
                            .padding() //để hiển thị văn bản đã mã hóa.

        }
        .padding()
    }
    
    func encryptText() {
        guard let shiftAmount = Int(shiftAmountText) else {
                    return
                }

                encryptedText = caesarCipherEncrypt(inputText, shiftAmount: shiftAmount)
    }
    
    func caesarCipherEncrypt(_ text: String, shiftAmount: Int) -> String {
        var encryptedText = ""
        let uppercaseAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lowercaseAlphabet = "abcdefghijklmnopqrstuvwxyz"

        for character in text {
            if let index = uppercaseAlphabet.firstIndex(of: character) {
                let currentIndex = uppercaseAlphabet.distance(from: uppercaseAlphabet.startIndex, to: index)
                let shiftedIndex = (currentIndex + shiftAmount) % 26
                let shiftedCharacter = uppercaseAlphabet[uppercaseAlphabet.index(uppercaseAlphabet.startIndex, offsetBy: shiftedIndex)]
                encryptedText.append(shiftedCharacter)
            } else if let index = lowercaseAlphabet.firstIndex(of: character) {
                let currentIndex = lowercaseAlphabet.distance(from: lowercaseAlphabet.startIndex, to: index)
                let shiftedIndex = (currentIndex + shiftAmount) % 26
                let shiftedCharacter = lowercaseAlphabet[lowercaseAlphabet.index(lowercaseAlphabet.startIndex, offsetBy: shiftedIndex)]
                encryptedText.append(shiftedCharacter)
            } else {
                encryptedText.append(character)
            }
        }

        return encryptedText
    }

}

#Preview {
    ContentView()
}
