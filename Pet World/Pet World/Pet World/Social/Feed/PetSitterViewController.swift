//
//  PetSitterViewController.swift
//  Pet World
//
//  Created by Suyog Lanje on 16/07/25.
//

import UIKit

class PetSitterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UI Components
    let nameField = UITextField()
    let ageField = UITextField()
    let genderSegment = UISegmentedControl(items: ["Male", "Female", "Other"])
    let phoneField = UITextField()
    let daysAvailableField = UITextField()
    let experienceField = UITextField()

    let chooseImageButton = UIButton(type: .system)
    let datePicker = UIDatePicker()
    var selectedImage: UIImage?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFormUI()
    }

    func setupFormUI() {
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Pet Sitter Register"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center

        // Labels
        let nameLabel = UILabel(); nameLabel.text = "Name:"
        let ageLabel = UILabel(); ageLabel.text = "Age:"
        let genderLabel = UILabel(); genderLabel.text = "Gender:"
        let emailLabel = UILabel(); emailLabel.text = "Email:"
        let phoneLabel = UILabel(); phoneLabel.text = "Phone:"
        let typeLabel = UILabel(); typeLabel.text = "Pet Type:"
        let daysAvailableLabel = UILabel(); daysAvailableLabel.text = "Days Available:"
        let experienceLabel = UILabel(); experienceLabel.text = "Years of Experience:"
        let photoLabel = UILabel(); photoLabel.text = "Photo:"
        let checkupLabel = UILabel(); checkupLabel.text = "Next Checkup:"

        // Fields
        [nameField, ageField, phoneField, daysAvailableField, experienceField].forEach {
            $0.borderStyle = .roundedRect
        }
        genderSegment.selectedSegmentIndex = 0

        // Image Picker Button
        chooseImageButton.setTitle("Choose Photo", for: .normal)
        chooseImageButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)

        // Date Picker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact

        // Stack View for Form Layout
        let photoRow = UIStackView(arrangedSubviews: [photoLabel, chooseImageButton])
        photoRow.axis = .horizontal
        photoRow.spacing = 8
        photoRow.distribution = .fillProportionally

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            nameLabel, nameField,
            ageLabel, ageField,
            genderLabel, genderSegment,
            phoneLabel, phoneField,
            daysAvailableLabel, daysAvailableField,
            experienceLabel, experienceField,
            photoRow
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        // Save Button
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        saveButton.addTarget(self, action: #selector(savePet), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)

        // Constraints
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            saveButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func openImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    // Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
        }
        picker.dismiss(animated: true)
    }

    @objc func savePet() {
        // You can process or save the sitter's info here.
        showAlert(title: "Pet sitter", message: "\n\nPet sitter update will be implemented soon.")
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
