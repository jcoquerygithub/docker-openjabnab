# docker-openjabnab
(Fork of [fbricon/openjabnab-docker](https://github.com/fbricon/openjabnab-docker) with some issues fixes)


Image build on DockerHub : https://hub.docker.com/r/antoineaumjaud/docker-openjabnab/

## Updates
TODO after image pulled: 
- change [OpenJabNabServers] in config file /var/www/OpenJabNab/server/bin with your domain

## Ports
- port 80:  PHP web site for administraction (shoul be exposed)
- port 8080: Nabaztag server, is used internaly only (call from PHP web site)
- port 5222: (to expose) is use for [XMPP](https://fr.wikipedia.org/wiki/Extensible_Messaging_and_Presence_Protocol)

## URLs
- URL admin access is: http://<my.domain>/ojn_admin/
