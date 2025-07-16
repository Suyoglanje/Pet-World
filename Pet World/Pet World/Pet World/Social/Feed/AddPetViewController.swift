//
//  AddPetViewController.swift
//  Pet World
//
//  Created by Suyog Lanje on 15/07/25.
//


import UIKit
import CoreData


protocol AddPetDelegate: AnyObject {
    func didAddPet()
}
class AddPetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - UI Components
    let nameField = UITextField()
    let typeField = UITextField()
    let chooseImageButton = UIButton(type: .system)
    let datePicker = UIDatePicker()
    var selectedImage: UIImage?

    weak var delegate: AddPetDelegate?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFormUI()
    }

    func setupFormUI() {
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Add Pet"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center

        // Labels
        let nameLabel = UILabel()
        nameLabel.text = "Name:"

        let typeLabel = UILabel()
        typeLabel.text = "Breed:"

        let photoLabel = UILabel()
        photoLabel.text = "Photo:"

        let checkupLabel = UILabel()
        checkupLabel.text = "Next Checkup:"

        // Fields
        nameField.borderStyle = .roundedRect
        typeField.borderStyle = .roundedRect

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

        let checkupRow = UIStackView(arrangedSubviews: [checkupLabel, datePicker])
        checkupRow.axis = .horizontal
        checkupRow.spacing = 8
        checkupRow.distribution = .fillProportionally
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            nameLabel, nameField,
            typeLabel, typeField,
            photoRow,
            checkupRow
        ])

        stack.axis = .vertical
        stack.spacing = 12
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
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
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

    @objc func savePet() {
        let finalImage = selectedImage ?? UIImage(named: "add_pet")!
        let imageData = finalImage.jpegData(compressionQuality: 1.0)

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let newPet = Pet(context: context)
        newPet.name = nameField.text
        newPet.type = typeField.text
        newPet.checkupDate = datePicker.date
        newPet.imageData = imageData


        let loginFetch: NSFetchRequest<NewLogin> = NewLogin.fetchRequest()
        do {
            let loginData = try context.fetch(loginFetch)
            if let loggedInEmail = loginData.first?.loginEmail {
                newPet.userEmail = loggedInEmail
            }
        } catch {
            print("Failed to fetch login email: \(error)")
        }

        do {
            try context.save()
            delegate?.didAddPet()
        } catch {
            print("Error saving pet: \(error)")
        }

        dismiss(animated: true)
    }

    // Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
        }
        picker.dismiss(animated: true)
    }
}
