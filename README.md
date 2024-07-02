# Advanced Secure Copy Script

## Overview

This Bash script provides an interactive way to securely copy files to and from a remote server using the `scp` command. It supports both upload and download operations, and includes advanced features such as using a jump server (bastion host) and specifying a private key file.

## Features

- Interactive prompts for server details and file paths
- Support for upload and download operations
- Option to use a jump server for connections to hosts behind a bastion
- Ability to specify a custom private key file
- Error handling and usage instructions

## Requirements

- Bash shell
- SSH client with SCP support
- SSH access to the target server (and jump server if applicable)

## Installation

1. Download the script:

- ```curl -O https://raw.githubusercontent.com/yourusername/yourrepository/main/interactive_secure_copy.sh```

2. Make the script executable:

- ```chmod +x interactive_secure_copy.sh```

## Usage

### Basic Usage

- ```./interactive_secure_copy.sh [-u|-d] [-j jump_server] [-i identity_file]```

### Options

- `-u`: Upload mode (local to remote)
- `-d`: Download mode (remote to local)
- `-j jump_server`: Specify a jump server (optional)
- `-i identity_file`: Specify a private key file (optional)

### Examples

1. Upload a file:

- ```./interactive_secure_copy.sh -u```

2. Download a file:

- ```./interactive_secure_copy.sh -d```

3. Upload using a jump server:

- ```./interactive_secure_copy.sh -u -j user@jumphost.example.com```

4. Download using a specific private key:

- ```./interactive_secure_copy.sh -d -i ~/.ssh/my_private_key```

5. Upload through a jump server with a specific private key:

- ```./interactive_secure_copy.sh -u -j user@jumphost.example.com -i ~/.ssh/my_private_key```

## Interactive Prompts

After running the script with the desired options, you will be prompted to enter:

1. Remote username
2. Remote host (IP or hostname)
3. Source path (local for upload, remote for download)
4. Destination path (remote for upload, local for download)

## Security Considerations

- Always use trusted networks when transferring sensitive data.
- Ensure that your SSH keys have appropriate permissions (typically 600).
- Be cautious when using jump servers, ensuring they are properly secured.

## Troubleshooting

- If you encounter "Permission denied" errors, check your SSH key permissions and ensure you have the necessary access rights on the remote server.
- For connection issues through a jump server, verify that SSH forwarding is enabled and that the jump server is correctly configured.

## Contributing

Contributions to improve the script are welcome. Please submit pull requests or open issues on the GitHub repository.

## License

[Specify your license here, e.g., MIT License, GPL, etc.]

## Author

[Your Name]

## Version History

- 1.0.0: Initial release with basic upload/download functionality
- 1.1.0: Added support for jump servers and custom identity files