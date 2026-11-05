
#!/usr/bin/env bash

# Experiment 5: Jenkins Verification

set -euo pipefail

echo "========================================"
echo "JENKINS INSTALLATION VERIFICATION"
echo "========================================"

echo ""
echo "1. Java Version"
if command -v java >/dev/null 2>&1; then
    java -version
else
    echo "Java not found."
fi

echo ""
echo "2. Jenkins Package"

if dpkg-query -W -f='${Version}\n' jenkins \
    2>/dev/null; then
    echo "Jenkins package is installed."
else
    echo "Jenkins package not found."
fi

echo ""
echo "3. Jenkins Service"

if systemctl is-active --quiet jenkins; then
    echo "Jenkins service: ACTIVE"
else
    echo "Jenkins service: INACTIVE"
fi

echo ""
echo "4. Jenkins Port"

if ss -ltn | grep -q ':8080 '; then
    echo "Port 8080: LISTENING"
else
    echo "Port 8080: NOT LISTENING"
fi

echo ""
echo "5. HTTP Response"

if command -v curl >/dev/null 2>&1; then
    status=$(curl -s -o /dev/null \
        -w '%{http_code}' \
        --max-time 5 \
        http://localhost:8080/ || true)

    echo "HTTP status: ${status:-Unavailable}"
else
    echo "curl not installed."
fi

echo ""
echo "========================================"
echo "VERIFICATION COMPLETED"
echo "========================================"
