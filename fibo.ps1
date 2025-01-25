function Fibonacci {
    param (
        [bigint]$n
    )
    
    $a = [bigint]0
    $b = [bigint]1

    if ($n -eq 0) {
        return $a
    }

    for ($i = 1; $i -lt $n; $i++) {
        $temp = $a
        $a = $b
        $b = $temp + $b
    }

    return $b
}

if ($args.Count -gt 0) {
    $n = [bigint]$args[0]
    Write-Host "$(Fibonacci -n $n)"

} else {
    $n = 50  
    for ($i = 0; $i -lt $n; $i++) {
        Write-Host $(Fibonacci -n $i)
        Start-Sleep -Milliseconds 500  
    }
}
