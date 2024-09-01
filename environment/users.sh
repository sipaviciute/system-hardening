#!/bin/bash

sudo useradd -m -G adm adminUser1
sudo useradd -m -G adm adminUser2
sudo useradd -m -G sudo sudoUser1
sudo useradd -m -G sudo sudoUser2
sudo useradd -m -G sudo sudoUser3
sudo useradd -m userStandard1
sudo useradd -m userStandard2
sudo useradd -m userStandard3

echo "adminUser1:Adm1n\$tr@t0r" | sudo chpasswd
echo "adminUser2:\$uperAdm1n2024" | sudo chpasswd
echo "sudoUser1:SudoU\$3r1Pass" | sudo chpasswd
echo "sudoUser2:UseR2Sud0Pw!" | sudo chpasswd
echo "sudoUser3:3Sud0U\$erPwd" | sudo chpasswd
echo "userStandard1:St@ndardU1Pw!" | sudo chpasswd
echo "userStandard2:MiniM@lU2P@ss" | sudo chpasswd
echo "userStandard3:BasicU3\$erPwd" | sudo chpasswd