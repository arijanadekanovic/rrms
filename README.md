# **RESIDENT RELATIONS MANAGEMENT SOFTWARE** 

## **RRMS Backend**

This is the backend part of the RRMS application. Follow the steps below to set up and run the backend locally using Docker.
## **Clone the Project**

- Download the project from the repository to your local machine.
## **Prerequisites**

#### RRMS_secrets.zip
- Make sure you have *RRMS_secrets.zip* sent to you!
- Unzip RRMS_secrets.zip
- The structure of RRMS_secrets folder resembles the projects structure, files from RRMS_secrets are private keys that are not present in git source control so they need to be copied manually in the project, in the specific folders that are mirror image project-RRMS_secrets (mobile: app_settings.dart and API: firebase json)


Make sure you have the following installed:
- **Docker** (Ensure Docker is installed and running on your device)
- **Visual Studio Enterprise 2022** (with Docker support)
- **.NET8**


## **Steps to Set Up the Backend**
### **1. Set Docker as Startup Project**

In **Visual Studio**:
1. Open the solution.
2. Right-click on the **docker-compose** file and select **Set as Startup Project**.

### **2. Run Docker Desktop**
Ensure that Docker Desktop is running.

### **3. Install secrets**

Paste the firebase json file into `src\RRMS.API`.

### **4. Seed the Database**

After setting up docker-compose as the startup project, seed the database by running the seeding logic.

- For debugging to seed data select and run **Docker Compose (Dataseeder)**

### **5. To start the application choose Docker Compose (All APIs) as debugging option**

__________________________________________________________________________________________

# **RRMS Frontend**

### **Installation**

Follow these steps to set up and run the application locally.
### **1. Install secrets**
Paste the **app_settings.dart** file into `lib\config\app_settings`.

### **2. Run Flutter Commands**

After downloading the project, navigate to the main project directory and execute the following commands in the terminal of the project to get the needed dependencies:

- `flutter clean`
- `flutter pub get`

### **4. Run mobile application**
- Choose your wishing emulator and run application
- If you want to start both Android and Windows at the same time in the menu section *Run & Debug* choose the option `Android & Windows`
- `Note:` While starting both `Android & Windows` please change the **emulator ID** in the **launch.json** file located in the .vscode folder
### **5. User credentials for login:**
###  **Resident:**
- username: **resident0**, password: **demo**
- username: **resident1**, password: **demo**
- username: **resident2**, password: **demo**

###  **Landlord:**
`Note:` Use these credentials for CRUD
- username: **landlord0**, password: **demo**
- username: **landlord1**, password: **demo**
- username: **landlord2**, password: **demo**

### **6. User credentials for PayPal:**
- email: **sb-isqwh32561331@personal.example.com**, password: **9H7?<z<B**

