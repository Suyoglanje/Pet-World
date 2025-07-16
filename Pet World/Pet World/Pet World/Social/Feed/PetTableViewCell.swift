//
//  PetTableViewCell.swift
//  Pet World
//
//  Created by Suyog Lanje on 15/07/25.
//

import UIKit

class PetTableViewCell: UITableViewCell {

    // MARK: - UI Components
    let petImageView = UIImageView()
    let nameLabel = UILabel()
    let typeLabel = UILabel()
    let dateLabel = UILabel()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        petImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        petImageView.contentMode = .scaleAspectFill
        petImageView.clipsToBounds = true
        petImageView.layer.cornerRadius = 8

        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        typeLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .gray

        let stack = UIStackView(arrangedSubviews: [nameLabel, typeLabel, dateLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(petImageView)
        contentView.addSubview(stack)
        contentView.backgroundColor = UIColor.systemGray6
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            petImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            petImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            petImageView.widthAnchor.constraint(equalToConstant: 60),
            petImageView.heightAnchor.constraint(equalToConstant: 60),

            stack.leadingAnchor.constraint(equalTo: petImageView.trailingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with pet: Pet) {
        nameLabel.text = "🐾 \(pet.name ?? "No Name")"
        typeLabel.text = "Breed: \(pet.type ?? "Unknown")"

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateLabel.text = "Next Checkup: \(formatter.string(from: pet.checkupDate ?? Date()))"

        if let data = pet.imageData, let image = UIImage(data: data) {
            petImageView.image = image
        } else {
            petImageView.image = UIImage(named: "add_pet") // fallback
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12))
        contentView.backgroundColor = UIColor.systemGray6
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}
