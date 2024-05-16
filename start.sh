#!/bin/bash

#
# This code is mostly written by GitHub Copilot,
# so don't blame me if it doesn't work as expected.
#

# Configure shock (can only be the same as on the web interface)
MIN_INTENSITY=1
MAX_INTENSITY=20
DURATION=0.3
TIMEOUT=15 # in seconds
USERNAME="Pancake"

# Setup the environment:
# ```bash
# #!/bin/bash
# export PISHOCK_USER="Username"
# export PISHOCK_API_KEY="xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
# export PISHOCK_CODE="FFFFFFFFFFF"
# ```
. shockenv.sh

# Check if CPMA folder exists
if [ ! -d "CPMA" ]; then
    echo "CPMA folder not found. Please copy the CPMA files to this folder."
    exit 1
fi

# Create timeout
NEXT_SHOCK=$(($(date +%s) + $TIMEOUT))

# Launch the server
echo "Launching cnq3-server-x64..."
cd CPMA
stdbuf -oL script -c ./cnq3-server-x64 -f /dev/null | while IFS= read -r line
do
    echo $line

    # Check if the timeout has not been reached
    if [ $(date +%s) -lt $NEXT_SHOCK ]; then
        continue
    fi

    # Check stdout for 'Kill: %d %d %d: %s killed $USERNAME by %s'
    if [[ $line =~ Kill:\ [0-9]*\ [0-9]*\ [0-9]*:\ .*\ killed\ $USERNAME\ by\ .* ]]; then
        ./../shockms.sh $(shuf -i $MIN_INTENSITY-$MAX_INTENSITY -n 1) $DURATION
        NEXT_SHOCK=$(($(date +%s) + $TIMEOUT))
    fi

done
