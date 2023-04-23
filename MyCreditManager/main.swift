//
//  main.swift
//  MyCreditManager
//
//  Created by 추현호 on 2023/04/23.
//

import Foundation

//MARK: - 성적 변환기
let grade: [String : Double] = ["A+" : 4.5,
                                "A" : 4.0,
                                "B+" : 3.5,
                                "B" : 3.0,
                                "C+" : 2.5,
                                "C" : 2.0,
                                "D+" : 1.5,
                                "D" : 1.0,
                                "F" : 0]

//MARK: - 학생성적기록부 클래스
class StudentGradeBook {
    
    private var students: Set<String> = []
    private var grades: [String: [String: String]] = [:]
    
    //MARK: - 학생추가 메소드
    func addStudent(name: String) {
        if !students.contains(name) {
            students.insert(name)
            grades[name] = [:]
        } else {
            print("\(name)은 이미 존재하는 학생입니다")
        }
    }
    //MARK: - 학생삭제 메소드
    func removeStudent(name: String) {
        if grades[name] != nil {
            grades[name] = nil
        } else {
            print("\(name)학생을 찾지 못했습니다")
        }
    }
    //MARK: - 성적추가(변경) 메소드
    func addGrade(input: String) {
        let components = input.split(separator: " ")
        guard components.count == 3 else {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            return
        }
        guard grade.keys.contains(String(components[2])) else {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            return
        }
        let name = String(components[0])
        let subject = String(components[1])
        let grade = String(components[2])
        guard students.contains(name) else {
            print("\(name)학생을 찾지 못했습니다.")
            return
        }
        grades[name]![subject] = grade
        print("성적이 추가되었습니다.")
        
    }
    //MARK: - 성적삭제 메소드
    func removeGrade(name: String, subject: String) {
        if grades[name] != nil {
            grades[name]![subject] = nil
        } else {
            print("\(name)학생을 찾지 못했습니다")
        }
    }
    //MARK: - 평점보기 메소드
    func showGrades(name: String) {
        if grades[name] != nil {
            var average: Double = 0.0
            for x in grades[name]! {
                print("\(x.key): \(x.value)")
                average += grade[x.value]!
            }
            print("평점: \(average / Double(grades[name]!.count))")
        } else {
            print("\(name)학생을 찾지 못했습니다")
        }
    }
}

//MARK: - Operation

let gradeBook = StudentGradeBook()

while true {
    print("원하는 기능을 선택해주세요.")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    let input = readLine()
    switch input {
        
    case "1":
        print("추가할 학생의 이름을 입력해주세요.")
        let name = readLine()!
        gradeBook.addStudent(name: name)
        
    case "2":
        print("삭제할 학생의 이름을 입력해주세요.")
        let name = readLine()!
        gradeBook.removeStudent(name: name)
        
    case "3":
        print("성적을 추가할 학생의 이름, 과목, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")

        let input = readLine()!
        gradeBook.addGrade(input: input)
        
    case "4":
        print("성적을 삭제할 학생의 이름과 과목을 입력해주세요. (예: Mickey English)")
        let input = readLine()!
        let components = input.split(separator: " ")
        guard components.count == 2 else {
            print("입력이 잘못되었습니다. 학생의 이름과 과목을 스페이스로 구분하여 입력해주세요.")
            continue
        }
        let name = String(components[0])
        let subject = String(components[1])
        gradeBook.removeGrade(name: name, subject: subject)
        
    case "5":
        print("평점을 조회할 학생의 이름을 입력해주세요.")
        let name = readLine()!
        gradeBook.showGrades(name: name)
        
    case "X":
        print("프로그램을 종료합니다...")
        exit(0)
        
    default:
        print("입력이 잘못되었습니다.  1~5 사이의 숫자 혹은 X를 입력해주세요")
        continue
    }
}
