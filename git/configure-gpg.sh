git config --global commit.gpgsign true
git config --global user.signingkey 53C2E8F678EB5D88

cat <<EOF > ~/.gnupg/gpg-agent.conf
default-cache-ttl 36000
max-cache-ttl 36000
EOF

