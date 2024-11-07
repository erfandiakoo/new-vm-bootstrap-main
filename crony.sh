# Set non-interactive installation mode
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=l

# Update package lists and install Chrony
apt update
apt install -y chrony

# Specify the Chrony configuration file
config_file="/etc/chrony/chrony.conf"

# Comment out existing Ubuntu NTP pool entries to avoid using them
sed -i '/^pool ntp.ubuntu.com/s/^/#/' "$config_file"
sed -i '/^pool 0.ubuntu.pool.ntp.org/s/^/#/' "$config_file"
sed -i '/^pool 1.ubuntu.pool.ntp.org/s/^/#/' "$config_file"
sed -i '/^pool 2.ubuntu.pool.ntp.org/s/^/#/' "$config_file"

# Add Iran NTP server at the top
sed -i '1i\server time.ir    iburst' "$config_file"
sed -i '2i\server ir.pool.ntp.org    iburst' "$config_file"

# Modify the makestep parameter to ensure accurate synchronization even after large time changes
sed -i 's/makestep 1 3/makestep 1 -1/' "$config_file"

# Set the timezone to Asia/Tehran
timedatectl set-timezone Asia/Tehran

# Display a message indicating the configuration update
echo "Configuration updated successfully."

# Display the current date and time
echo "Current datetime: $(date)"

# Restart Chrony to apply the new settings
systemctl restart chrony

# Wait for 5 seconds to allow changes to take effect
echo "Waiting 5 seconds for changes to take effect..."
sleep 5

# Display the updated date and time
echo "Updated datetime: $(date)"