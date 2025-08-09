# get the jwt
curl -X POST http://mp3converter.com/login -u user@example.com:admin

# upload the video
curl -X POST -F 'file=@./video.mp4' -H 'Authorization: Bearer <jwt>' http://mp3converter.com/upload
