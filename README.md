# Task Manager API - DevOps Recruitment Task Documentation

   **Author**: Michał Wysocki
   **Date**: 18.03.2025

## Overview

   This is desription about recruitment task and my aproach to it. Documentation contains steps, and technical decisions. 

## Task prerequisites
   
   - Docker
   - PostgreSQL 15
   - Redis 6.0
   - PHP 8.1 or above
   - Composer
   - Symfony CLI (optional)

## Application Containerization
   
   **Dockerfile**
      The app is containeraized with Docker and RoadRunner instead of PHP-FPM. 
      For this feature project is using PHP 8.1 CLI image whitch is optimized for RR.
      Dockerfile does not contain Composer setup for smaller image - this section is moved to the CI Pipeline.
      Redis and PostgreSQL are settled up as separate services in docker-compose.yaml for better scaling, debugging and maintenance. 

## CI/CD
   
   CI System chosen for this task is GitHub Actions. Task will be provided to PragmaGo via GitHub repository, so keeping everything in one platform is easier and less complex. 
   It's prevents more chokepoints for possible errors. Also, I've never used GitHub Actions so it was the opportunity to learn new tool. 

**CI/CD pipeline steps**
   
   - Repository checkout
   - Setting up the PHP
   - Installation of Baldinof RR bundle - I had a sever problems with this bundle and composer.lock file provided by You. Also not knowing why, I couldn't download PHP on my locl machine, so this is only fix I could done right now.
   - Installation of composer dependencies with .lock file update
   - Start of static code analysis
   - Docker image build
   - Docker image tag

## Security

   For security there were no many secrets to use. Those used in the code were settled up for my practice. 
   

##Troubleshooting

   The only issue approached during setting up this project were issue with installing the RoadRunning bundle.
