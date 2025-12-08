## **Project Contents Summary**  

**Overview:**
This repository contains all configuration, infrastructure, CI, and CD components for deploying an automated Docker-based web application using AWS EC2, DockerHub, GitHub Actions, and a custom webhook listener.

- `BISWA-lb-cf.yml` - AWS Cloud Formation template from Project 3 which I used on the new AWS account. 
- `README-CI.md` - README file for Project 4 where it goes over Cotinuous integration this includes details about GitHub actions, tags, and auto pushing docker images. 
- `README-CD.md`- README file for Project 5 which goes over Continous Deployment. Inlcudes info about Docker webhooks, bash scripts, and webhook service. 

- `.github/workflows/main.yml` - GitHub action that triggers only on a commit/push to the main branch. 
- `.github/workflows/semantic.yml` - GitHub action that triggers when tags with semantic versioning is pushed (ex. v1.2.3). 

- `deployment/hooks.json` - Webhok defintion file that refreshes the site by running refresh-container.sh script when there is a valid webhook request is recieved. Only authenticated triggers can refresh the the web container. 
- `deployment/refresh-container.sh` - This script stops any previously running containers and pulls the latest version of the image from DockerHub and starts a new container. 
- `deployment/webhook.service` - Starts the webhook listening on boot and restart if it fails. 

- `web-content/Dockerfile` - Builds apache http server image and copies all the contents from directory into apache document root (/usr/local/apache2/htdocs/). 
- `web-content/experience.html` - HTML file containing website information: my resume -- xperiences, and projects. 
- `web-content/index.html` - HTML file containing website information: my resume -- about me, skills, and education. 
- `web-content/style.css` - CSS file that styles my website contents. 

- `web-content/Screenshots/.` - these has screenshots of many things that were mostly referenced in P4 README-CI.md


---
[P4 README-CI.md](./README-CI.md)  
**Brief Summary:**
This is the readme for Project 4. It goes over how the porject implements CI that automatically builds and pushes Docker container images triggered by certain actions/events. These are some of the information you can find there:  
- explanation of Dockerfile
- how to build image 
- how to run the containers
- DockerHub Instructions for generating a token and logging into DockerHub from terminal
- link to my DockerHub Repo
- Configuring GitHub Repo secrets
- Semantic Versioning
- Testing and validating
- Diagram
- Citations/Resouces used

[P5 README-CD.md](./README-CD.md)  
**Breif Summary:**
This is the readme for Project 5. tIt goes over the project's implementation of a fully automated continuos deployment. These are some of the information you can find there:  
- information on refresh-container.sh
- Docker setup on EC2 instance 
- webhook listener on EC2 instance
- Payload info
- Project description & Diagram
- References/Resources used