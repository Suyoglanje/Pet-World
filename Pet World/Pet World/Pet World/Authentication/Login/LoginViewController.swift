//
//  LoginViewController.swift
//  Pet World
//
//  Created by Suyog Lanje on 14/07/25.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // MARK: - UI Components
    let gradientLayer = CAGradientLayer()
    let logoImageView = UIImageView()
    var titleLabel = UILabel()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var submitButton = UIButton(type: .system)
    var forgotPasswordButton = UIButton(type: .system)
    var createAccountButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NewLogin> = NewLogin.fetchRequest()

            do {
                let loginData = try context.fetch(fetchRequest)

                // Check if login data exists
                if !loginData.isEmpty {
                    let feedViewController = FeedViewController()
                    navigationController?.pushViewController(feedViewController, animated: true)
                }
            } catch {
                print("Failed to fetch NewLogin data: \(error)")
            }
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

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
        setupEmailTextField()
        
        setupPasswordTextField()
        setupSubmitButton()
        setupForgotPasswordButton()
        setupCreateAccountButton()
    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        logoImageView.image = UIImage(named: "pet_logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            // Important: This allows vertical scrolling only
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    func setupTitleLabel() {
        titleLabel.text = "Login"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.2),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
        
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
        
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
        ])
    }
    
    func setupSubmitButton() {
        submitButton.setTitle("Login", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        submitButton.layer.cornerRadius = 10
        submitButton.backgroundColor = UIColor.systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 280),
            submitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupForgotPasswordButton() {
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.systemBlue, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgotPasswordButton.contentHorizontalAlignment = .right
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 8),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: submitButton.leadingAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupCreateAccountButton() {
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.darkGray, for: .normal)
        createAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        
        view.addSubview(createAccountButton)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 8),
            createAccountButton.trailingAnchor.constraint(equalTo: submitButton.trailingAnchor),
            createAccountButton.heightAnchor.constraint(equalToConstant: 20)
        ])
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

        print("Login successful with email: \(email) and password: \(password)")
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userName == %@ AND password == %@", email, password)

        do {
            let results = try context.fetch(fetchRequest)
            if let _ = results.first {
                
                
                let newlogin = NewLogin(context: context)
                newlogin.loginEmail = emailTextField.text
                
                
                appDelegate.saveContext()
                // Navigate to next screen
                let feedVC = FeedViewController() // or LoginViewController if you use it
                navigationController?.pushViewController(feedVC, animated: true)
            } else {
                showAlert(title: "Login Failed", message: "Invalid email or password.")
            }
        } catch {
            print("❌ Error during login fetch: \(error)")
            showAlert(title: "Error", message: "Something went wrong. Please try again.")
        }
    }

    @objc func forgotPasswordTapped() {
        showAlert(title: "Forgot Password", message: "Password recovery flow goes here.")
    }

    @objc func createAccountTapped() {
        let feedVC = NewAccountViewController()
        navigationController?.pushViewController(feedVC, animated: true)
    }

    // MARK: - Helper Methofds
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
        return password.count >= 6
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
