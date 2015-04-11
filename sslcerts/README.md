#SSL certs.

JR has the password that was used will creating the CSR.
Pythian has it stored in their "secret servers"

Create CA chain:
cat COMODORSADomainValidationSecureServerCA.crt COMODORSAAddTrustCA.crt AddTrustExternalCARoot.crt > ca-chain.crt

aws iam upload-server-certificate \
 --server-certificate-name kipapp-co --certificate-body file://kipapp_co.crt \
 --private-key file://kipapp-co.key --certificate-chain file://ca-chain.crt


{
    "ServerCertificateMetadata": {
        "ServerCertificateId": "ASCAIB7H55QXETG66MVYK",
        "ServerCertificateName": "kipapp-co",
        "Expiration": "2016-04-10T23:59:59Z",
        "Path": "/",
        "Arn": "arn:aws:iam::127521922525:server-certificate/kipapp-co",
        "UploadDate": "2015-04-11T00:19:40.798Z"
    }
}

