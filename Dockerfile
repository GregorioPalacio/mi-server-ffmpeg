FROM node:18

# Instalar ffmpeg
RUN apt update && apt install -y ffmpeg

# Crear carpeta de trabajo
WORKDIR /app

# Copiar archivos y dependencias
COPY package*.json ./
RUN npm install

# Copiar el resto de los archivos
COPY . .

# Exponer el puerto
EXPOSE 3000

# Comando para iniciar el servidor
CMD ["node", "index.js"]
