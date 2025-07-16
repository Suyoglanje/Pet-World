//
//  FeedViewController.swift
//  Pet World
//
//  Created by Suyog Lanje on 15/07/25.
//

import UIKit
import CoreData


class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, AddPetDelegate {
    // MARK: - UI Components
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let addPetImageView = UIImageView()
    let petsTableView = UITableView()
    let callButton = UIButton(type: .system)
    let becomeSitterButton = UIButton(type: .system)
    let findSitterButton = UIButton(type: .system)
    let emptyStateImageView = UIImageView()

    // Load from Core Data
    var newLogin = [NewLogin]()
    var pets: [Pet] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupUI()
        loadPets()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        fetchPets()
    }

    func fetchPets() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let request: NSFetchRequest<Pet> = Pet.fetchRequest()
        
        let loginFetch: NSFetchRequest<NewLogin> = NewLogin.fetchRequest()
        do {
            let loginData = try context.fetch(loginFetch)
            guard let loggedInEmail = loginData.first?.loginEmail else {
                print("❌ No logged in user found.")
                return
            }

            // Filter pets by userEmail
            request.predicate = NSPredicate(format: "userEmail == %@", loggedInEmail)

            pets = try context.fetch(request)
            petsTableView.reloadData()
            updateAddPetImageVisibility()

        } catch {
            print("Failed to fetch pets: \(error)")
        }
    }

    func name() -> String {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Could not get AppDelegate")
            return "NO Name"
        }

        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest1: NSFetchRequest<NewLogin> = NewLogin.fetchRequest()
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            let email = try context.fetch(fetchRequest)
            let newLoginList = try context.fetch(fetchRequest1)
            guard let loginEmail = newLoginList.first?.loginEmail else {
                        return "No login email found"
                    }

                    for user in email {
                        if user.userName == loginEmail {
                            return user.name ?? "No name"
                        }
                    }
        } catch {
            print("Failed to fetch users: \(error)")
        }
        return "no"
    }

    func setupUI() {
        view.backgroundColor = .white

        // Profile Image
        profileImageView.image = UIImage(named: "default-profile")
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)

        // Name Label
        nameLabel.text = name()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        addPetImageView.image = UIImage(named: "add_pet")
        addPetImageView.contentMode = .scaleAspectFit
        addPetImageView.translatesAutoresizingMaskIntoConstraints = false
        addPetImageView.isUserInteractionEnabled = true
        let addPetGesture = UITapGestureRecognizer(target: self, action: #selector(addPetTapped))
        addPetImageView.addGestureRecognizer(addPetGesture)

        // Table View
        petsTableView.dataSource = self
        petsTableView.delegate = self
        petsTableView.backgroundColor = UIColor(red: 250/255, green: 248/255, blue: 245/255, alpha: 1.0)
        petsTableView.register(PetTableViewCell.self, forCellReuseIdentifier: "PetCell")
        petsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Default Image
        emptyStateImageView.image = UIImage(named: "default_pet")
        emptyStateImageView.contentMode = .scaleAspectFit
        emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateImageView)

        // Call Button
        callButton.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        callButton.setTitle(" Vet", for: .normal)
        callButton.tintColor = .white
        callButton.backgroundColor = .systemGreen
        callButton.setTitleColor(.white, for: .normal)
        callButton.layer.cornerRadius = 10
        callButton.addTarget(self, action: #selector(callTapped), for: .touchUpInside)
        callButton.translatesAutoresizingMaskIntoConstraints = false

        // Become Pet Sitter
        becomeSitterButton.setTitle("Be a Pet Sitter", for: .normal)
        becomeSitterButton.backgroundColor = .systemBlue
        becomeSitterButton.setTitleColor(.white, for: .normal)
        becomeSitterButton.layer.cornerRadius = 10
        becomeSitterButton.addTarget(self, action: #selector(becomeSitterTapped), for: .touchUpInside)
        becomeSitterButton.translatesAutoresizingMaskIntoConstraints = false

        // Find Sitter Button
        findSitterButton.setTitle("Find a Pet Sitter", for: .normal)
        findSitterButton.backgroundColor = .systemBlue
        findSitterButton.setTitleColor(.white, for: .normal)
        findSitterButton.layer.cornerRadius = 10
        findSitterButton.addTarget(self, action: #selector(findSitterTapped), for: .touchUpInside)
        findSitterButton.translatesAutoresizingMaskIntoConstraints = false

        // Buttons Stack
        let buttonsStack = UIStackView(arrangedSubviews: [callButton, becomeSitterButton, findSitterButton])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 16
        buttonsStack.distribution = .fillEqually
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        callButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        becomeSitterButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        findSitterButton.setContentHuggingPriority(.defaultLow, for: .horizontal)

        callButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        becomeSitterButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        findSitterButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonsStack.distribution = .fill

        // Add all to view
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(addPetImageView)
        view.addSubview(petsTableView)
        view.addSubview(emptyStateImageView)
        view.addSubview(buttonsStack)

        // Constraints
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),

            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 25),

            addPetImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addPetImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addPetImageView.widthAnchor.constraint(equalToConstant:50),
            addPetImageView.heightAnchor.constraint(equalToConstant: 40),

            petsTableView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            petsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            petsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            petsTableView.bottomAnchor.constraint(equalTo: becomeSitterButton.topAnchor, constant: -26),

            emptyStateImageView.centerXAnchor.constraint(equalTo: petsTableView.centerXAnchor),
            emptyStateImageView.centerYAnchor.constraint(equalTo: petsTableView.centerYAnchor),
            emptyStateImageView.widthAnchor.constraint(equalToConstant: 400),
            emptyStateImageView.heightAnchor.constraint(equalToConstant: 400),

            becomeSitterButton.trailingAnchor.constraint(equalTo: findSitterButton.leadingAnchor, constant: -16),
            becomeSitterButton.heightAnchor.constraint(equalToConstant: 50),

            findSitterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            findSitterButton.widthAnchor.constraint(equalTo: becomeSitterButton.widthAnchor),
            findSitterButton.heightAnchor.constraint(equalToConstant: 50),
            
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonsStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func profileImageTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Update Photo", style: .default, handler: { _ in
            self.openImagePicker()
        }))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
                self.logoutUser()
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }

    func openImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true // Optional: allows cropping
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        if let editedImage = info[.editedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    @objc func addPetTapped() {
        let addPetVC = AddPetViewController()
        addPetVC.delegate = self
        addPetVC.modalPresentationStyle = .formSheet // or .fullScreen
        present(addPetVC, animated: true)
    }

    func logoutUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NewLogin.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs  // ✅ IMPORTANT

        do {
            let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
            if let objectIDs = result?.result as? [NSManagedObjectID] {
                let changes = [NSDeletedObjectsKey: objectIDs]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            }
            print("✅ Logged out and cleared NewLogin data.")

            // Now confirm data is gone (optional)
            let newLoginFetch: NSFetchRequest<NewLogin> = NewLogin.fetchRequest()
            let count = try context.count(for: newLoginFetch)
            print(count == 0 ? "ℹ️ NewLogin is empty." : "⚠️ Still found \(count) items.")

            // Navigate to Login screen
            let loginVC = ViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
        } catch {
            print("❌ Failed to delete login data: \(error)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100  // Change this value as needed
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath) as? PetTableViewCell else {
            return UITableViewCell()
        }

        let pet = pets[indexPath.row]
        cell.configure(with: pet)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let petToDelete = pets[indexPath.row]

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext

            context.delete(petToDelete)
            
            do {
                try context.save()
                pets.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                updateAddPetImageVisibility() // 👈 In case it becomes empty
            } catch {
                print("Failed to delete pet: \(error)")
            }
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }

    @objc func callTapped() {
        let alert = UIAlertController(
            title: "",
            message: "",
            preferredStyle: .actionSheet
        )

        // Add 5 numbers
        alert.addAction(UIAlertAction(title: "Happy Vet Clinic  📞 +91 1234567890", style: .default, handler: { _ in
            self.callNumber("+911234567890")
        }))
        alert.addAction(UIAlertAction(title: "WellPet Vet Clinic  📞 +91 2345678901", style: .default, handler: { _ in
            self.callNumber("+912345678901")
        }))
        alert.addAction(UIAlertAction(title: "VetiX Vet Clinic  📞 +91 3456789012", style: .default, handler: { _ in
            self.callNumber("+913456789012")
        }))
        alert.addAction(UIAlertAction(title: "VetCare Clinic  📞 +91 4567890123", style: .default, handler: { _ in
            self.callNumber("+914567890123")
        }))
        alert.addAction(UIAlertAction(title: "Demo Vet Clinic📞 +91 5678901234", style: .default, handler: { _ in
            self.callNumber("+915678901234")
        }))

        // Cancel option
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }

    func callNumber(_ number: String) {
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("⚠️ Device cannot make calls or number is invalid")
        }
    }

    func didAddPet() {
        fetchPets()
    }

    func loadPets() {
        // Fetch from Core Data
        fetchPets()
    }

    func updateAddPetImageVisibility() {
        emptyStateImageView.isHidden = !pets.isEmpty
    }

    @objc func becomeSitterTapped() {
        let addPetVC = PetSitterViewController()
            addPetVC.modalPresentationStyle = .formSheet
            present(addPetVC, animated: true)
    }

    @objc func findSitterTapped() {
        // Navigate to "List of Pet Sitters"
        let alert = UIAlertController(
            title: "No Pet Sitters",
            message: "No pet sitter registered yet.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

