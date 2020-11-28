{httpPort, host}:
''
version: '2'
services:
  app:
    container_name: filestash
    image: machines/filestash
    restart: always
    environment:
    - APPLICATION_URL=
    - GDRIVE_CLIENT_ID=<gdrive_client>
    - GDRIVE_CLIENT_SECRET=<gdrive_secret>
    - DROPBOX_CLIENT_ID=<dropbox_key>
    - ONLYOFFICE_URL=http://onlyoffice
    ports:
    - "${toString host}:${toString httpPort}:${toString httpPort}"

  onlyoffice:
    container_name: filestash_oods
    image: onlyoffice/documentserver
    restart: always
''
