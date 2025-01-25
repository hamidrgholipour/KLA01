function Build-DockerImage {
    param(
        [Parameter(Mandatory = $true)][string]$Dockerfile,
        [Parameter(Mandatory = $true)][string]$Tag,
        [Parameter(Mandatory = $true)][string]$Context,
        [string]$ComputerName
    )

    if ($ComputerName) {
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            docker build -f $using:Dockerfile -t $using:Tag $using:Context
        }
    } else {
        docker build -f $Dockerfile -t $Tag $Context
    }
}

function Copy-Prerequisites {
    param(
        [Parameter(Mandatory = $true)][string]$ComputerName,
        [Parameter(Mandatory = $true)][string[]]$Path,
        [Parameter(Mandatory = $true)][string]$Destination
    )

    foreach ($item in $Path) {
        $itemName = Split-Path -Path $item -Leaf
        $destPath = "\\$ComputerName\$($Destination.Replace(':', '$'))\$itemName"
        Copy-Item -Path $item -Destination $destPath -Recurse -Force
    }
}

function Run-DockerContainer {
    param (
        [Parameter(Mandatory = $true)][string]$ImageName,
        [Parameter(Mandatory = $false)][string]$DockerParams,
        [Parameter(Mandatory = $false)][string]$ComputerName
    )

    if ($ComputerName) {
        $containerName = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            param ($ImageName, $DockerParams)
            if ($DockerParams) {
                docker run --rm $ImageName $DockerParams
            } else {
                docker run --rm $ImageName
            }
        } -ArgumentList $ImageName, $DockerParams

        Write-Host "Container executed on remote host '$ComputerName': $containerName"
    } else {
        if ($DockerParams) {
            $output = docker run --rm $ImageName $DockerParams
        } else {
            $output = docker run --rm $ImageName
        }

        Write-Host $output

        $containerName = docker ps --latest --format "{{.Names}}"
    }

    return $containerName
}


Export-ModuleMember -Function Build-DockerImage, Copy-Prerequisites, Run-DockerContainer
