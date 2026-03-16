#!/usr/bin/env -S bash

USERNAME=$1
if [[ -z "$USERNAME" ]]; then
    echo "Usage: $0 <username>"
    exit 1
fi

# create user with specific group, or add it to group if it already exists
if id -u "$USERNAME" >/dev/null 2>&1; then
    usermod -s /bin/bash -a -G mail ${USERNAME}
else
    useradd -s /bin/bash -G mail -m ${USERNAME}
    passwd ${USERNAME}
fi

cat > "/home/${USERNAME}/.muttrc" <<EOF
set spoolfile="+Inbox"
EOF
