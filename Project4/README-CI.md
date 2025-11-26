# Project 4

# DockerFile & Building Images
**Website Content**
- **Explanation:** This is a simple resume website where it has information about me, my skills, my education, porjects I've worked on, and my work experiences. 
- [index.html](./web-content/index.html)
- [experince.html](./web-content/experience.html)
- [style.css](./web-content/style.css)
- Webiste Link: (http://localhost:8080)
- [Web Screenshot index page](./web-content/Screenshots/home_page.png)
- [Web Screenshot experience page](./web-content/Screenshots/eperience_page.png)

**Docker file**
- **Explanation:** It defines how the container image is built. It uses Apache version 2.4 which comes ready to run. The second line of code puts web content files into the Apache web directory. 
- [Dockerfile](./web-content/Dockerfile)

**DockerHub Instructions**
- `docker build -t kiranrdm/about-me-site:latest ./web-content`
- `docker run -d -p 8080:80 kiranrdm/about-me-site:latest`

- PAT Instructions: (-- AM USING A MAC --)
    - DockerHub -> Account Settings -> Personal access token -> Generate New Token 
    - set name (project3-token)
    - set-permission (Read, Write, Delete) 
    - Generate
    - terminal -> docker login -u kiranrdm -> enter password (use token)

- Push to DockerHub: `docker push kiranrdm/about-me-site:latest`
- [My DockerHub Repo](https://hub.docker.com/r/kiranrdm/about-me-site)

