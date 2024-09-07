# **RESIDENT RELATIONS MANAGEMENT SOFTWARE** 

## **RRMS Backend**

This is the backend part of the RRMS application. Follow the steps below to set up and run the backend locally using Docker.
## **Clone the Project**

- Download the project from the repository to your local machine.
## **Prerequisites**

#### RRMS_secrets.zip
- Make sure you have *RRMS_secrets.zip* sent to you!
- Unzip RRMS_secrets.zip
- The structure of RRMS_secrets folder resembles the projects structure, files from RRMS_secrets are private keys that are not present in git source control so they need to be copied manually in the project, in the specific folders that are mirror image project-RRMS_secrets (mobile: app_settings.dart, API: firebase json and ngrok.yml)


Make sure you have the following installed:
- **Docker** (Ensure Docker is installed and running on your device)
- **Visual Studio Enterprise 2022** (with Docker support)
- **.NET8**

- **Install Ngrok**

    **Steps for ngrok:**
If Ngrok is not installed on your machine, follow these steps to install it:

    Visit the Ngrok official website and download the version for your operating system.
Unzip and install Ngrok as per the instructions on the website.
Move the Ngrok executable to the ngrok folder within your project directory if it’s not there already.

    Visit ngrok official website for download: https://ngrok.com/download , and download the ngrok file for your operating system (preferably Windows). Unzip the file and paste the `ngrok.exe` Application file into the ngrok folder in the project.
    
    **Start Ngrok**
Once Ngrok is installed into the ngrok folder of the project, follow these steps:
1. In the ngrok folder open the ngrok application file and run the command: `ngrok start --all`
This will start Ngrok and open tunnels for your services. Make sure that the tunnels for ports `5001 (mainApiUrl)` and `5003 (storageApiUrl)` are running. 

## **Steps to Set Up the Backend**
### **1. Set Docker as Startup Project**

In **Visual Studio**:
1. Open the solution.
2. Right-click on the **docker-compose** file and select **Set as Startup Project**.

### **2. Run Docker Desktop**
Ensure that Docker Desktop is running.

### **3. Seed the Database**

After setting up docker-compose as the startup project, seed the database by running the seeding logic.

- For debugging to seed data select and run **Docker Compose (Dataseeder)**

### **4. Update API URLs**

In the `appSettings.Development.json` file which is located in `rrms\RRMS.API\src\Microservices\RRMS.Storage\RRMS.Storage.API`, update the `ApiUrl` with the Ngrok storageApi URL with port **5003**.

### **5. To start the application choose Docker Compose (All APIs) as debugging option**
__________________________________________________________________________________________

# **RRMS Frontend**

### **Installation**

Follow these steps to set up and run the application locally.

### **2. Run Flutter Commands**

After downloading the project, navigate to the main project directory and execute the following commands in the terminal of the project to get the needed dependencies:

- `flutter clean`
- `flutter pub get`

### **3. Update API URLs**
In the `development_app_settings.dart` file which is located in `lib\config\app_settings`, update the following values with the ngrok URLs:

- For `mainApiUrl` use the ngrok URL with port 5001
- For `storageApiUrl` use the ngrok URL with port 5003

### **4. Run mobile application**
- Choose your wishing emulator/device and run application
- If you want to start both Android and Windows at the same time in the menu section *Run & Debug* choose the option `Android & Windows`
### **5. User credentials for login:**
###  **Resident:**
- username: **resident0**, password: **demo**
- username: **resident1**, password: **demo**
- username: **resident2**, password: **demo**

###  **Landlord:**
- username: **landlord0**, password: **demo**
- username: **landlord1**, password: **demo**
- username: **landlord2**, password: **demo**

### **6. User credentials for PayPal:**
- email: **sb-isqwh32561331@personal.example.com**, password: **9H7?<z<B**

