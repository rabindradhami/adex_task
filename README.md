ADEX


1. Clone the Repository

2. Install Docker, Docker Compose, Terraform, AWS ClI

3. Configure AWS CLI on your local.

4. There are two ways you can run this file.
   a. Manually 
   b. Using the script

A. Manually

   For this method you can remove the following part from the provider.tf and just need to configure aws profile in your local.

   command to configure aws profile:  

    - aws configure
    enter the access key and secret key.

    Note: Make sure you have proper permission for the aws.

  and you can remove the following part from the provider.tf file from both aws_ecr and aws_remaining
  
    access_key = "access_key_id"
    secret_key = "secret_key"

   1. Go to aws_ecr folder and run the following command
      - terraform plan
      - terraform init
      - terraform apply 

      this will create the aws ecr repository needed for us to push the docker image
    
    2. Go to django-docker-quickstart folder
       - cd django-docker-quickstart
       - cp env.example .env
       - DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f docker-compose.yml up --build -d
       - docker images
       - tag it and push it to ecr using the push command from ecr repository
       - copy the docker image url

    3. After that go to aws_remaining folder and run the following command  
      before running the below command update the variable.tf file.
      find the docker_image and add the url you just copied in default value
      
      Now run the following command

      - terraform plan
      - terraform init
      - terraform apply
      this will create the ecs cluster, load balancer, ec2 instances, rds database, vpc, certificate for loadbalancer to listen on https, security groups and will run the image on ecs cluster.



B. Using Script



Please Perform Using Sudo.


1. Update the provider.tf file on both aws_ecr and aws_remaining folder

    access_key = "access_key_id"
    secret_key = "secret_key"

    enter the access key and secret key

3. Go to django-docker-quickstart folder
       - cd django-docker-quickstart
       - cp env.example .env    


4. After that update the xxxxxxxxxxxxxx part with your aws accound id.
   - aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin xxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com
   - docker tag django-docker-quickstart_backend:latest xxxxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/django-repository:latest
   - docker push xxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/django-docker-quickstart_backend:latest

   Note: You can get the following things from the ecr push command. You can simply update the xxxxxx part and everything will be the same.

5. Make the script executable.
   - chmod +x run_all.sh

6. Run the script

   - ./run_all.sh