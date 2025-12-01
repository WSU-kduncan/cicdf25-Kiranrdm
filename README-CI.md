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
- [Dockerfile](./DockerFile)

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

- [**Workflow file:**](.github/workflows/main.yml)

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


# Part 3 - Semantic Versioning

**1. Generating tags** 
- **How to see tags in a git repository**  
  - `git tag` -> this'll list tags in the repo
- **How to generate a tag in a git repository**
  - `git tag-a v1.0.0 -m "new tag v1.0.0"`
- **How to push a tag in a git repository to GitHub**
  - `git push origin v10.0.0`

**2. Semantic Versioning Container Images with GitHub Actions**
- **Explanation of workflow trigger**
  - workflow is traggers when a git tag like v*.*.* (ex. v1.0.0.0) is pushed. 

- **Explanation of workflow steps**
  - pulls repo files into workflow
  - logs in to dockerhub using sercrets stored in GitHub
  - extract version components seperates the major, minor, and full version 
  - builds image using dockerfile and pushes multiple tags (ex. latest, v1, v1.0, v1.0.0)
  
- **Explanation / highlight of values that need updated if used in a different repository**
  - DockerHub repo name will need to be updated in the tags section  
  - make sure GitHub secrets exist (in out case: DOCKER_USERNAME, DOCKER_TOKEN)  

  - **changes in workflow**  
    - might have to adjust tags  

  - **changes in repository**  
    - make sure branch name matches workflow trigger  
    - needs to have dockerhub secrets if not add it to github  

- [**Semantic Workflow file:**](.github/workflows/semantic.yml)

**3. Testing & Validating**  
- **How to test that your workflow did its tasking**  
  - create a test tag `git tag -a v1.0.0.0 -m "test release tag"`
  - push it `git push origin v1.0.0.0`
  - Go to your repo in GitHub -> Actions -> check workflow  

- **How to verify that the image in DockerHub works when a container is run using the image**  
  - `docker pull kiranrdm/about-me-site:1.0.0`
  - `docker run -d -p 8080:80 kiranrdm/about-me-site:1.0.0`
  - then open in browser `http://localhost:8080` to see your changes  

- **Link to your DockerHub repository with evidence of the tag set**
  - [DockerHub Tag Link](https://hub.docker.com/repository/docker/kiranrdm/about-me-site/tags)
  - [Screenshot DockerHub Tag](./web-content/Screenshots/dockerhub-tag.png)


## Part 4 - Project Description & Diagram











# Citations / Resources Used
- For Part 1 I used my web-contents from Project 3  

- I used ChatGPT to help identify why GitHub was blocking my push due to a leaked DockerHub PAT in a previous commit. The AI guided me on how to remove the affected commits and fix the issue using git reset and a force push. All steps were reviewed and performed by me. I used `git log --oneline --decorate --graph -05` and `git reset --hard` and git `push --force` commands.  
 
- For the sematic.yml, I wrote the base but I was very confused on how to write this section and I used chatGPT to help me reform mine. The first code is what I wrote and I asked ai to help me and I ended upn with the second one. Prompt i used: "Here's a version extraction code i code, but i am not sure if it correct. Can you help me clean this up and explain to me what's wrong with my code."  
  ``` 
  this is the code I had: 
        - name: Exctract version components 
        id: version
        run:
        TAG=$GITHUB_REF
        VERSION=${Tag#v}
        MAJOR=${Version%%.*}
        MINOR=${Version%.*}

        echo "tag=$VERSION"
        echo "major=$MAJOR"
        echo "minor=$MINOR" ```
  
  ```
        this is refined code with ai assistance: 
        - name: Extract version components
        id: version
        run: |
          # GITHUB_REF looks like: refs/tags/v1.2.3
          TAG="${GITHUB_REF#refs/tags/}"   # -> v1.2.3
          VER="${TAG#v}"                   # -> 1.2.3 (strip leading 'v')
          MAJOR="${VER%%.*}"               # -> 1
          MAJORMINOR="${VER%.*}"           # -> 1.2
          echo "tag=${VER}" >> $GITHUB_OUTPUT
          echo "major=${MAJOR}" >> $GITHUB_OUTPUT
          echo "majorminor=${MAJORMINOR}" >> $GITHUB_OUTPUT ```