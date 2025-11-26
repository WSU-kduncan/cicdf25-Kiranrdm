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

**1. Configuring GitHub Repository Secrets:**
- **How to create a PAT for authentication (and recommended PAT scope for this project):**  
  DockerHub -> Account Settings -> Security -> New Access Token -> Enter token description and set permission -> Generate
  Set permission to **Read, Write, Delete**  

- **How to set repository Secrets for use by GitHub Actions:**  
  Go to GitHub -> Your Repository -> Settings -> Secrets and variables -> Actions -> New repository secret -> 
  Created two secrets:
    - `DOCKER_USERNAME` → kiranrdm  
    - `DOCKER_TOKEN` → DockerHub Personal Access Token (I could NOT paste herre as it resulted in `GITHUB PUSH PROTECTION` Conflict) 

- **Describe the Secrets set for this project:**  
  - `DOCKER_USERNAME` = **kiranrdm**  
  - `DOCKER_TOKEN` = **DockerHub PAT** used to authenticate the GitHub workflow and push container images  

---
**2. CI with GitHub Actions**
- **Explanation of workflow trigger:**  
  The workflow is triggered when a commit is pushed only to the `main` branch.

- **Explanation of workflow steps:**  
    1. Uses `actions/checkout@v3` to pull repo files into the workflow environment.  
    2. Uses `docker/login-action@v2` with the GitHub Secrets for authentication.  
    3. Uses `docker/build-push-action@v5` to build the Docker image from the Dockerfile and push it to DockerHub with the `latest` tag. 

- **Explanation / highlight of values that need updated if used in a different repository:**  
  - **Changes in workflow:**  
    - Update `tags value` to match DockerHub repo name 
    - Update the `file:` or `context:` paths if the Dockerfile is not in the root folder.  

  - **Changes in repository:**  
    - Ensure Secrets (`DOCKER_USERNAME`, `DOCKER_TOKEN`) exist in the new repo.  
    - The main branch name must match the trigger branch in the workflow.  

- [**workflow file:**](./.github/workflows/ci-docker-build.yml)

---
**3. Testing & Validating**
- **How to test that your workflow did its tasking:**  
  Push any commit to the `main` branch → Go to GitHub → Actions tab → check if the workflow runs successfully and finishes without errors.

- **How to verify that the image in DockerHub works when a container is run using the image:**  
  Run the following commands on your machine:
  ```bash
  docker pull kiranrdm/about-me-site:latest
  docker run -d -p 8080:80 kiranrdm/about-me-site:latest
  ```

- Check `http://localhost:8080` it will have my resume site

- **[My DockerHub Repo]**(https://hub.docker.com/r/kiranrdm/about-me-site)











# Citations / Resources Used
- For Part 1 I used my web-contents from Project 3
- I used ChatGPT to help identify why GitHub was blocking my push due to a leaked DockerHub PAT in a previous commit. The AI guided me on how to remove the affected commits and fix the issue using git reset and a force push. All steps were reviewed and performed by me. I used `git log --oneline --decorate --graph -05` and `git reset --hard` and git `push --force` commands. 