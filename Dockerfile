FROM node:18

# Instalar ffmpeg, curl, yt-dlp y rclone
RUN apt update && apt install -y ffmpeg curl unzip \
  && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
  && chmod a+rx /usr/local/bin/yt-dlp \
  && curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip \
  && unzip rclone-current-linux-amd64.zip \
  && cd rclone-*-linux-amd64 \
  && cp rclone /usr/bin/rclone \
  && chmod 755 /usr/bin/rclone \
  && cd .. && rm -rf rclone-*-linux-amd64 rclone-current-linux-amd64.zip

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
CMD ["node", "index.js"]
