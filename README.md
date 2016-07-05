# LAMP
Basic LAMP Web server configured by knife zero

## Command
`berks vendor cookbooks; knife zero converge 'name:monosense-LAMP-cooked' -a knife_zero.host -i ../monosense-web-db-1.pem -x ec2-user --sudo -W`
