NETWORKMANAGER IS NOT MY FRIEND
===
A workaround I use to get past the lack of functionality that comes with nmcli 
on debian-based systems is to use commands to copy an existing VPN config file 
in the /etc/NetworkManager/system-settings folder to a new file (as root, 
of course) in the same folder and make string replacements to the permitted user, 
gateway, username and password values in the new copy. 
Then I restart network manager to apply the changes.

For example:

A typical config file in /etc/NetworkManager/system-settings folder might look as such:

[connection]
id=<<id>>
uuid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx
type=vpn
permissions=user:<<permissions_user>>:;
autoconnect=false

[vpn]
password-flags=0
service-type=org.freedesktop.NetworkManager.pptp
require-mppe-128=yes
mppe-stateful=yes
user=<<user>>
refuse-eap=yes
refuse-chap=yes
gateway=<<gateway>>
refuse-pap=yes

[vpn-secrets]
password=<<password>>

[ipv4]
method=auto

... so you can just create a new config file that looks similar to the one above...

cd /etc/NetworkManager/system-settings
cp "existing-working-vpn-config-file" "new-vpn-config-file"

...then replace the '<<>>' values above with your own VPN settings, eg:

sed -i "s/<<permissions_user>>/my_permissions_user/g" new-vpn-config-file
sed -i "s/<<user>>/my_user/g" new-vpn-config-file
sed -i "s/<<gateway>>/my_gateway/g" new-vpn-config-file
sed -i "s/<<password>>/my_password/g" new-vpn-config-file

... and then finally restart network manager via the following command:

service network-manager restart OR systemctl restart NetworkManager

Also, If you are adding a new file rather than copying, make sure the permissions 
to the file are set to 600 (read and write), and the owner is root.
