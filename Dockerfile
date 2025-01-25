FROM mcr.microsoft.com/powershell:alpine-3.20

WORKDIR /app

COPY fibo.ps1 .

ENTRYPOINT ["pwsh", "-File", "fibo.ps1"]
CMD []
