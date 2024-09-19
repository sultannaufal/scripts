# PHP Version Switcher for Windows

This script allows you to easily switch between PHP versions on Windows.

## Prerequisites

Ensure you have downloaded the PHP versions you want to switch between.

**Note**: Back up your original `PATH` before running this script.

## How to Run

1. Download the script.
2. Place the script in your desired directory.
3. Modify the `phpDir` variable in the script to point to your PHP installations.
4. Open `cmd` as Administrator.
5. Run the script using:
   ```bash
   .\switch-php.bat
   ```

### Create a Shortcut

To make the script easier to run, you can create a desktop shortcut:

1. Right-click on the `.bat` file.
2. Select **Send to → Desktop (create shortcut)**.
3. On your desktop, right-click the newly created shortcut and select **Properties**.
4. Go to the **Shortcut** tab and click **Advanced**.
5. Check the box for **Run as administrator** to ensure the script has the necessary permissions.

## How It Works

This script modifies the **user** environment variable `PATH`, finds the existing PHP version, and replaces it with the new version you choose.

## Troubleshooting

If the script doesn't work:

- Ensure that the **system** `PATH` does not contain any reference to a PHP directory, as this may override the user-level `PATH`.
