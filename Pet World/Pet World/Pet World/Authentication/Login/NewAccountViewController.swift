//
//  NewAccountViewController.swift
//  Pet World
//
//  Created by Suyog Lanje on 15/07/25.
//

import UIKit

class NewAccountViewController: UIViewController, UITextFieldDelegate {
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // MARK: - UI Components
    let gradientLayer = CAGradientLayer()
    let logoImageView = UIImageView()
    var titleLabel = UILabel()
    var nameTextField = UITextField()
    var wing = UITextField()
    var flatNumber = UITextField()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var confirmPasswordTextField = UITextField()
    var submitButton = UIButton(type: .system)
    var createAccountButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Animation addes
        emailTextField.alpha = 0
        passwordTextField.alpha = 0
        submitButton.alpha = 0

        UIView.animate(withDuration: 0.8) {
            self.emailTextField.alpha = 1
            self.passwordTextField.alpha = 1
            self.submitButton.alpha = 1
        }
        logoImageView.transform = CGAffineTransform(translationX: 0, y: -100)
        UIView.animate(withDuration: 1.0,
                       delay: 0.2,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
            self.logoImageView.transform = .identity
        }, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    // MARK: - UI Setup
    func setupUI() {
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
        setupScrollView()
        logoImageView.transform = CGAffineTransform(translationX: 0, y: -100)
        UIView.animate(withDuration: 1.0,
                       delay: 0.2,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.5,
                       options: [],
                       animations: {
            self.logoImageView.transform = .identity
        }, completion: nil)
        view.backgroundColor = .white
        setupTitleLabel()
        setupNameTextField()
        setupWingTextField()
        setupFlatNumberTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        
        setupSubmitButton()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    func setupTitleLabel() {
        titleLabel.text = "Create Account"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.1),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setupNameTextField() {
        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.keyboardType = .emailAddress
        nameTextField.autocapitalizationType = .none
        nameTextField.leftView = imageView(systemName: "person")
        nameTextField.leftViewMode = .always
        nameTextField.delegate = self
        
        contentView.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            nameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 280),
            nameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setupWingTextField() {
        wing.placeholder = "Enter your wing"
        wing.borderStyle = .roundedRect
        wing.keyboardType = .emailAddress
        wing.autocapitalizationType = .none
        wing.leftView = imageView(systemName: "person")
        wing.leftViewMode = .always
        wing.delegate = self
        
        contentView.addSubview(wing)
        wing.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wing.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            wing.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            wing.widthAnchor.constraint(equalToConstant: 280),
            wing.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setupFlatNumberTextField() {
        flatNumber.placeholder = "Enter your Flat Number"
        flatNumber.borderStyle = .roundedRect
        flatNumber.keyboardType = .emailAddress
        flatNumber.autocapitalizationType = .none
        flatNumber.leftView = imageView(systemName: "person")
        flatNumber.leftViewMode = .always
        flatNumber.delegate = self
        
        contentView.addSubview(flatNumber)
        flatNumber.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flatNumber.topAnchor.constraint(equalTo: wing.bottomAnchor, constant: 30),
            flatNumber.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            flatNumber.widthAnchor.constraint(equalToConstant: 280),
            flatNumber.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setupEmailTextField() {
        emailTextField.placeholder = "Enter your email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.leftView = imageView(systemName: "person")
        emailTextField.leftViewMode = .always
        emailTextField.delegate = self
        
        
        contentView.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: flatNumber.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 280),
            emailTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupPasswordTextField() {
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftView = imageView(systemName: "lock")
        passwordTextField.leftViewMode = .always
        passwordTextField.delegate = self
        
        contentView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
        ])
    }
    
    func setupConfirmPasswordTextField() {
        confirmPasswordTextField.placeholder = "Confirm your password"
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.leftView = imageView(systemName: "lock")
        confirmPasswordTextField.leftViewMode = .always
        confirmPasswordTextField.delegate = self
        
        contentView.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            confirmPasswordTextField.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor)
        ])
    }
    
    func setupSubmitButton() {
        submitButton.setTitle("Create Account", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 8
        submitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        contentView.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),
            submitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 280),
            submitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        let bottomConstraint = submitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        bottomConstraint.isActive = true
    }
    // MARK: - Actions
    @objc func buttonPressed() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "Invalid Email", message: "Email is required.")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Invalid Password", message: "Password is required.")
            return
        }
        
        guard isValidPassword(password) else {
            showAlert(title: "Invalid Password", message: "Password must be at least 6 characters.")
            return
        }
        guard passwordTextField.text == confirmPasswordTextField.text else {
            showAlert(title: "Error", message: "Passwords do not match.")
            return
        }
        let user = User(context: context)
        user.name = nameTextField.text
        user.wing = wing.text
        user.flat_Number = flatNumber.text
        user.userName = emailTextField.text
        user.password = passwordTextField.text

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            showAlert(title: "Error", message: "Unable to get AppDelegate.")
            return
        }
        let context = appDelegate.persistentContainer.viewContext

        let feedVC = LoginViewController()
        navigationController?.pushViewController(feedVC, animated: true)
        showAlert(title: "Account Created", message: "Account created successfully.")
    }

    // MARK: - Helper Methods
    func imageView(systemName: String) -> UIView {
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        imageView.tintColor = .gray
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        container.addSubview(imageView)
        return container
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        let keyboardHeight = keyboardFrame.height
        scrollView.contentInset.bottom = keyboardHeight + 20
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight + 20
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        submitAction()
        return true
    }
    func submitAction() {
        buttonPressed()
    }
}

