# Pet World iOS App 🐾

## Overview 🌐
Pet World is a society driven iOS application designed to connect pet lovers within a society. Built with **Swift 5** using **UIKit**, it features **Core Data** for local persistence and follows the **MVC architectural pattern**. The app facilitates pet management, vet connections, and pet sitting services within local communities.

---

## Technical Specifications ⚙️

| *Category*       | *Technologies*                          |
|--------------------|-------------------------------------------|
| Language           | Swift 5                                   |
| UI Framework       | UIKit (Programmatic UI + Storyboards)     |
| Architecture       | Model-View-Controller (MVC)               |
| Persistence        | Core Data (SQLite backend)                |
| Testing            | XCTest (Unit Tests)                       |
| Dependency Manager | None (Pure Swift)                         |
| Minimum iOS        | iOS 15.0+                                 |

---

## Features 🚀

### 1️⃣ Authentication System 🔐
-	📥 Login Screen — Users can log in with valid credentials only. Secure and validated login ensures privacy.
- 🆕 Signup Screen — New users can create an account quickly and securely.
-	❌ Invalid credentials will be rejected with error alerts.⁠
 
  - ⁠**Core Data Entities**: ⁠User ⁠, ⁠ Pet ⁠

```swift
// User Entity Attributes:
userID: UUID
username: String
passwordHash: Data
profileImage: BinaryData?
```

### 2️⃣ Pet Management 🐶🐱
•⁠  ⁠**Add Pets**: 
  - Photo upload via ⁠`UIImagePickerController` ⁠
  - A floating Add Pet button on the top-right of the Feed screen lets users create pet profiles.
  - Users can enter pet details like name, breed, etc., and store them using Core Data.

•⁠  ⁠**Pet Feed**:
  - 🏠 This is your pet dashboard! View all your added pets with their full details.
  - ⁠`UICollectionView` ⁠with diffable data source
  - Dynamic cell sizing with ⁠`UICollectionViewFlowLayout`

### 3️⃣ User Profile Management 👤
-	📸 Tap the user icon on the top-left to: Update your profile picture
-	🔓 Logout securely from the app



### 4️⃣ Community Services 🤝
•⁠  ⁠**📞 Call Vet**:
-	Displays a list of nearby veterinarians available in your society.
-	Uses static data for demo; can be extended using MapKit or API integration.

•⁠  ⁠**🐾 Become a Pet Seater**:
- Launches a form screen where users can submit:
- Personal information
-	Past pet care experience
-	Availability and contact details	-	Stored securely in Core Data for internal use.

•⁠  ⁠**🔍 Find a Pet Seater**:
- Fetches and displays all registered pet seaters in the community.
-	Includes contact info and experience summary of each seater.

---

## Screen Architecture 📱

⁠<pre> ```mermaid
graph TD
    A[Login] --> B[Signup]
    A --> C[Feed Screen]
    C --> D[Add Pet]
    C --> E[Pet Sitter Services]
    E --> F[Become Sitter]
    E --> G[Find Sitter]``` </pre>
 

### Key View Controllers:
- 1.⁠ ⁠⁠ `LoginViewController` ⁠: Handles auth logic
- 2.  `NewAccountViewController` : Create new account
- 3.⁠ ⁠⁠ `FeedViewController` ⁠: Main collection view and Pet info display
- 4.⁠ ⁠⁠ `PetSitterViewController` ⁠: Pet Register Form
- 5.  `AddPetViewController` : Add new pets

---
## Core Data Model 🗄️

### 🐶 Pet

| Property         | Type        | Description         |
|------------------|-------------|---------------------|
| `checkupDate`             | Date        | Next Checkup Date   |
| `image`           | BinaryData      | Pet's Image          |
| `name`            | String       | Pet's Name           |
| `type` | String?     | String |Pet's Bread
| `userEmail`          | String        | Relationship email  |

### 👩‍⚕️ User

| Property         | Type        | Description           |
|------------------|-------------|-----------------------|
| `userName`| String       | User Name  |
| `password`            | String      | Password            |
| `name`           | String        | Name of user  |
| `image`| BinaryData       | Image   |
| `wing`            | String      | Wing            |
| `flat_Number`           | String        | Flat number  |


⁠<pre>func testLoginScreenUIElementsExist() throws {
        XCTAssertTrue(app.textFields["Enter your email"].exists)
        XCTAssertTrue(app.secureTextFields["Enter your password"].exists)
        XCTAssertTrue(app.buttons["Login"].exists)
        XCTAssertTrue(app.buttons["Forgot Password?"].exists)
        XCTAssertTrue(app.buttons["Create Account"].exists)
} </pre>

---

## Testing Strategy 🧪
•⁠  ⁠**Test Cases**:
- The app uses XCTestCase to validate critical user flows such as login.
- Ensures stability and robustness with a test-driven approach.

Example test case:

<pre> func testInvalidLogin() { 
  let sut = LoginViewController() 
  sut.credentials = (username: "wrong", password: "12345") 
  XCTAssertFalse(sut.validateCredentials(), "Invalid credentials should fail") 
  } </pre>

## Future Enhancements 🔮
- Community Connect
- Push notifications for pet sitting requests
⁠- CloudKit sync for cross-device support
- AR pet preview using RealityKit
- Pet medical records scanner with Vision
