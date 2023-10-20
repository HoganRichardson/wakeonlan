# Wake on LAN Script
$Mac=$args[0]
Write-Output "Sending Magic Packet to $Mac..."
$MacByteArray = $Mac -split "[:-]" | ForEach-Object { [Byte] "0x$_" }
[Byte[]] $MagicPacket = (,0xff * 6) + ($MacByteArray * 16)

$UdpClient = New-Object System.Net.Sockets.UdpClient
$UdpClient.Connect(([System.Net.IPAddress]::Broadcast),7)
$UdpClient.Send($MagicPacket,$MagicPacket.Length)
$UdpClient.Close()
