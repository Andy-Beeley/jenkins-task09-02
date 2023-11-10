pipeline {
    agent any
    stages {
        stage('Clean up') {
            steps {
                script {
                    try {
                        sh "bash cleanup.sh"
                    } catch (Exception e) {
                        echo "Failed to clean up"
                    }
                }
            }
        }
        stage('Build images') {
            steps {
                script {
                    try {
                        sh "docker build -t trio-task-mysql:5.7 db"
                        sh "docker build -t trio-task-flask-app:latest flask-app"
                    } catch (Exception e) {
                        echo "Failed to build images"
                    }
                }
            }
        }
        stage('Create network') {
            steps {
                script {
                    try {
                        sh "docker network create task2-network"
                    } catch (Exception e) {
                        echo "Failed to create network again"
                    }
                }
            }
        }
        stage('Create volume') {
            steps {
                script {
                    try {
                        sh "docker volume create new-volume"
                    } catch (Exception e) {
                        echo "Failed to create volume"
                    }
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    try {
                        sh 'docker run -d --name mysql --network task2-network --mount type=volume,source=new-volume,target=/var/lib/mysql trio-task-mysql:5.7'
                        sh 'docker run -d -e MYSQL_ROOT_PASSWORD=password --name flask-app --network task2-network trio-task-flask-app:latest'
                        sh 'docker run -d --name nginx -p 80:80 --network task2-network --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf nginx:latest'
                    } catch (Exception e) {
                        echo "Failed to run node app container"
                    }
                }
            }
        }
    }
}
