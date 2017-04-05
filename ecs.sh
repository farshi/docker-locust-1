version: '2'
services:
  master:
    image: dockerlocust1_master
    ports:
      - 5557:5557
      - 5558:5558
      - 8089:8089
    environment:
      - ROLE=master
      - TARGET_HOST=$TARGET_HOST
      - LOCUST_FILE=$LOCUST_FILE
   slave:
        depends_on:
        - master
        network_mode: "service:master"
        environment:
        - DEBUG=True
        - ROLE=slave
        - MASTER_HOST=master
        - TARGET_HOST=$TARGET_HOST
        - LOCUST_FILE=$LOCUST_FILE
        - SLAVE_MUL=$SLAVE_NUM
        - OAUTH=$OAUTH
        - TOKEN_URL=$TOKEN_URL
        - OAUTH_SCOPE=$OAUTH_SCOPE
    controller:
        container_name: docker_locusts_controller
        depends_on:
        - master
        network_mode: "service:master"
        environment:
        - ROLE=controller
        - MASTER_HOST=master
        - AUTOMATIC=$AUTOMATIC
        - USERS=$USERS
        - HATCH_RATE=$HATCH_RATE
        - SLAVE_MUL=$SLAVE_NUM
        - DURATION=$DURATION
