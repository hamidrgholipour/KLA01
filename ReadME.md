## Create a PowerShell 'DockerHelper' module containing 3 cmdlets

* Create module file and import it

`Import-Module .\DockerHelper.psm1`

* Get imported commands

`Get-Command -Module DockerHelper`

* Build docker image

`Build-DockerImage -Dockerfile "C:\KLA\FibonacciApp\Dockerfile" -Tag "fibo:v1" -Context "C:\KLA\FibonacciApp\"`

* Copy files to a remote host

`Copy-Prerequisites -ComputerName "RemoteHost" -Path "C:\KLA\FibonacciApp\*" -Destination "C:\KLA\DockerFiles"`

* Run docker Fibonacci app 

`Run-DockerContainer -ImageName "fibo:v1"  -DockerParams 15`
