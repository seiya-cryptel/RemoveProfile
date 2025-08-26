# RemoveProfile

A PowerShell script suite for managing Windows user profiles with administrative privileges.

## Overview

This repository contains PowerShell scripts designed to help system administrators manage user profiles on Windows systems. The scripts can list existing user profiles and remove unnecessary ones while protecting critical system accounts.

## Features

- **Profile Listing**: Display all user profiles with current user identification
- **Safe Removal**: Remove unnecessary user profiles with built-in protection for system accounts
- **Admin Rights Check**: Automatic elevation to administrator privileges when needed
- **Error Handling**: Comprehensive error handling and user feedback
- **Exclusion List**: Configurable list of protected profiles

## Files

- `RemoveProfile.ps1` - Main script for removing unnecessary user profiles
- `ListupProfile.ps1` - Script for listing user profiles
- `RemoveProfile.bat` - Batch file for easy execution with admin privileges
- `ListupProfile.bat` - Batch file for profile listing with admin privileges

## Requirements

- Windows operating system
- PowerShell 5.0 or later
- Administrator privileges (scripts will auto-elevate if needed)

## Usage

### Method 1: Direct PowerShell Execution
```powershell
# List user profiles
.\ListupProfile.ps1

# Remove unnecessary profiles
.\RemoveProfile.ps1
```

### Method 2: Batch File Execution (Recommended)
1. Double-click `ListupProfile.bat` to list profiles
2. Double-click `RemoveProfile.bat` to remove unnecessary profiles

The batch files will automatically request administrator privileges through UAC.

## Protected Accounts

The following user profiles are automatically excluded from deletion:
- Administrator
- Public
- Default
- DefaultAccount
- Guest
- TEMP (temporary profiles)
- localadmin
- Currently logged-in user

## Configuration

You can modify the exclusion list in `RemoveProfile.ps1` by editing the `$ExclusionList` array:

```powershell
$ExclusionList = @(
    "Administrator"
    "Public"
    "Default"
    "DefaultAccount"
    "Guest"
    "TEMP"
    "localadmin"
    # Add more usernames here
)
```

## ⚠️ DISCLAIMER

**IMPORTANT: NO WARRANTY OR LIABILITY**

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

**The author(s) assume absolutely no responsibility for:**
- Data loss or corruption
- System instability or crashes
- Unintended profile deletions
- Any direct or indirect damages resulting from the use of these scripts

**Use at your own risk. Always test in a non-production environment first.**

## Best Practices

1. **Test First**: Always test the scripts in a non-production environment
2. **Backup**: Create system backups before running profile deletion scripts
3. **Review**: Carefully review the list of profiles before deletion
4. **Verify**: Ensure no critical user data will be lost
5. **Document**: Keep records of what profiles were removed and when

## Troubleshooting

### Script Won't Run
- Ensure PowerShell execution policy allows script execution
- Run PowerShell as administrator
- Check file permissions

### UAC Issues
- Use the provided batch files for automatic elevation
- Manually run PowerShell as administrator

### Profile Won't Delete
- Check if the user is currently logged in
- Verify the profile isn't in use by system services
- Ensure sufficient disk space for temporary operations

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is provided under the MIT License. See the LICENSE file for details.

## Support

For questions or issues, please open an issue on GitHub. Note that support is provided on a best-effort basis with no guarantees.

---

**Remember: These scripts modify system user profiles. Use with extreme caution and always maintain proper backups.**
