FROM microsoft/aspnet:1.0.0-rc1-update1-coreclr

COPY bin/output/ /app/
WORKDIR /app/approot

EXPOSE 5004
ENTRYPOINT ["./web"]

