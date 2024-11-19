# Etapa 1: Construcción del proyecto con Maven
FROM maven:3.8.6-openjdk-11 AS build

# Directorio de trabajo para el proyecto
WORKDIR /app

# Copiar el archivo pom.xml y descargar las dependencias
COPY pom.xml .

# Descargar las dependencias de Maven
RUN mvn dependency:go-offline

# Copiar todo el código fuente al contenedor
COPY src /app/src

# Construir el proyecto y empaquetar el WAR
RUN mvn clean package -DskipTests

# Etapa 2: Crear la imagen final con Tomcat
FROM tomcat:9-jdk11-openjdk

# Copiar el archivo WAR generado a la carpeta webapps de Tomcat
COPY --from=build /app/target/mvn-hello-world.war /usr/local/tomcat/webapps/

# Exponer el puerto 8080 donde Tomcat escucha
EXPOSE 8080

# Comando por defecto para ejecutar Tomcat
CMD ["catalina.sh", "run"]
