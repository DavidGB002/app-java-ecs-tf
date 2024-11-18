# Usar la imagen base de Tomcat con JDK 11
FROM tomcat:10-jdk11

# Establecer una variable para el directorio de despliegue en Tomcat
ENV DEPLOY_DIR /usr/local/tomcat/webapps/

# Copiar el archivo .war generado por Maven al directorio de despliegue de Tomcat
COPY target/mvn-hello-world.war ${DEPLOY_DIR}

# Exponer el puerto 8080 para acceder a la aplicación web
EXPOSE 8080

# Iniciar Tomcat en modo foreground
CMD ["catalina.sh", "run"]
