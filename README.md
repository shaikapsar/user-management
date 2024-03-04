docker build . -t user-mamangement:0.0.2

docker run --rm -it -p 80:80 user-mamangement:0.0.2 /bin/bash


docker run  -p 80:80 user-mamangement:0.0.2 


docker run  -p 80:80 shaikapsar/user-mamangement:0.0.2