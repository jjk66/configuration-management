#!/bin/bash

# Ensure both IP address and key path were passed as arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "❌ Error: Missing arguments."
    echo "Usage: $0 <new_ip_address> <path_to_private_key>"
    exit 1
fi

NEW_IP="$1"
NEW_KEY="$2"
GROUP_VAR_FILE="./ansible/inventory/group_vars/awsi.yml"

# Ensure the group_vars file exists
if [ ! -f "$GROUP_VAR_FILE" ]; then
    echo "❌ Error: '$GROUP_VAR_FILE' not found. Ensure you are running this from your Ansible root directory."
    exit 1
fi

# Run the cross-platform awk command to safely update the keys
awk -v new_ip="$NEW_IP" -v new_key="$NEW_KEY" '
{
    # Update ip_address field
    if ($1 == "ip_address:") {
        sub(/: .*/, ": " new_ip)
    }
    # Update ssh_pem field
    if ($1 == "ssh_pem:") {
        sub(/: .*/, ": " new_key)
    }
    print
}' "$GROUP_VAR_FILE" > ./ansible/inventory/group_vars/aws.tmp && mv ./ansible/inventory/group_vars/aws.tmp "$GROUP_VAR_FILE"

# Extract the newly written values directly from the file to confirm success
CONFIRMED_IP=$(awk '/^ip_address:/ {print $2}' "$GROUP_VAR_FILE")
CONFIRMED_KEY=$(awk '/^ssh_pem:/ {print $2}' "$GROUP_VAR_FILE")

echo "✅ Successfully updated $GROUP_VAR_FILE!"
echo "   Confirmed IP from file:  $CONFIRMED_IP"
echo "   Confirmed Key from file: $CONFIRMED_KEY"
