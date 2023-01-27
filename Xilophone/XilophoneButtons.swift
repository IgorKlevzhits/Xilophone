import UIKit
import AVFoundation

class XilophoneButtons: UIView {
    
    private let dictanseEdgesButton: CGFloat = 10
    private let cornerRadiusButton: CGFloat = 15
    private let fontSizeButton: CGFloat = 50
    
    private var buttons: [UIButton] = []
    
    var player: AVAudioPlayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        setButtons()
        setupButtons()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        for button in buttons {
            self.addSubview(button)
        }
    }
    
    private func setButtons() {
        let titleButtons = [ "C", "D", "E", "F", "G", "A", "B" ]
        let colorButtons = [ UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.cyan, UIColor.blue, UIColor.purple]
        for index in 0..<7 {
            let button = UIButton(type: .system)
            button.backgroundColor = colorButtons[index]
            button.layer.cornerRadius = cornerRadiusButton
            button.setTitle(titleButtons[index], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSizeButton)
            button.tintColor = .white
            button.addTarget(self, action: #selector(keyPressed), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            buttons.append(button)
        }
    }
    
    @IBAction func keyPressed(_ sender: UIButton) {
        playSound((sender.titleLabel?.text)!)
        }
        
    func playSound(_ nameButton: String) {
            let url = Bundle.main.url(forResource: nameButton, withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                    
        }

}

extension XilophoneButtons {
    
    private func setConstraints() {
        
        
        NSLayoutConstraint.activate([
            buttons[0].topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            buttons[0].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: dictanseEdgesButton),
            buttons[0].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -dictanseEdgesButton),
            buttons[0].bottomAnchor.constraint(equalTo: buttons[1].topAnchor, constant: -10)
        ])
        for index in 1..<6 {
            NSLayoutConstraint.activate([
                buttons[index].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: dictanseEdgesButton * CGFloat(index + 1)),
                buttons[index].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -dictanseEdgesButton * CGFloat(index + 1)),
                buttons[index].bottomAnchor.constraint(equalTo: buttons[index + 1].topAnchor, constant: -10)
            ])
        }
        NSLayoutConstraint.activate([
            buttons[6].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: dictanseEdgesButton * 7),
            buttons[6].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -dictanseEdgesButton * 7),
            buttons[6].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        for index in 0..<6 {
            NSLayoutConstraint.activate([
                buttons[index].heightAnchor.constraint(equalTo: buttons[index + 1].heightAnchor, multiplier: 1)
            ])
        }
    }
}
