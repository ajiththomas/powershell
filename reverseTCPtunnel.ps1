# Set up listener
$listener = New-Object System.Net.Sockets.TcpListener("0.0.0.0", 8080)
$listener.Start()
Write-Host "Listening on port 8080..."

while ($true) {
    $client = $listener.AcceptTcpClient()
    $remote = New-Object System.Net.Sockets.TcpClient("remote.server.com", 80)

    # Stream forwarding
    $streamIn = $client.GetStream()
    $streamOut = $remote.GetStream()
    

    # Forward traffic
    while (($bytes = $streamIn.Read($buffer, 0, $buffer.Length)) -ne 0) {
        $streamOut.Write($buffer, 0, $bytes)
    }

    # Cleanup
    $client.Close()
    $remote.Close()
}
