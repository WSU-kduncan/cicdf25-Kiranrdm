# Project 4

# Part 1 - DockerFile & Building Images
**Website Content**
- **Explanation:** This is a simple resume website where it has information about me, my skills, my education, porjects I've worked on, and my work experiences. 

- [index.html](./web-content/index.html)
- [experince.html](./web-content/experience.html)
- [style.css](./web-content/style.css)
- [Web Screenshot index page](./web-content/Screenshots/home_page.png)
- [Web Screenshot experience page](./web-content/Screenshots/eperience_page.png)

**Docker file**
- **Explanation:** It defines how the container image is built. It uses Apache version 2.4 which comes ready to run. The second line of code puts web content files into the Apache web directory. 
- [Dockerfile](./Dockerfile)

**DockerFile Contents:**
```
FROM httpd:2.4
COPY ./web-content/ /usr/local/apache2/htdocs/
```

**How to build image from the repo DockerFile**
- `docker build -t kiranrdm/about-me-site:latest ./web-content`
- `latest` --> refers to the most recent build

**How to run the container**
- `docker run -d -p 8080:80 kiranrdm/about-me-site:latest`
- `-d` runs containers in the background
- `-p 8080:80` --> maps local port 8080 to container port 80
- Webiste Link: (http://localhost:8080)

**DockerHub Instrcutions**
- PAT Instructions: (-- AM USING A MAC --)
    - DockerHub -> Account Settings -> Personal access token -> Generate New Token 
    - set name (project3-token)
    - set-permission (Read, Write, Delete) 
    - Generate
    - terminal -> docker login -u kiranrdm -> enter password (use token)

- Push to DockerHub: `docker push kiranrdm/about-me-site:latest`
- [My DockerHub Repo](https://hub.docker.com/r/kiranrdm/about-me-site)

# Part 2 – GitHub Actions and DockerHub
### Configuring GitHub Repository Secrets

1. Configuring GitHub Repository Secrets:
    - **How to create a PAT for authentication (and recommended PAT scope for this project):**
    DockerHub → Account Settings → Security → New Access Token
    Set permission to **Read, Write, Delete**


    - How to set repository Secrets for use by GitHub Actions
    - Describe the Secrets set for this project
1. CI with GitHub Actions
    - Explanation of workflow trigger
    - Explanation of workflow steps
    - Explanation / highlight of values that need updated if used in a different repository changes in workflow
        - changes in reposi
        - Link to workflow file in your GitHub repository
2. Testing & Validating
    - How to test that your workflow did its tasking
    - How to verify that the image in DockerHub works when a container is run using the image
    - Link to your DockerHub repository











# Citations / Resources Used
- For Part 1 I used my web-contents from Project 3