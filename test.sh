# get the jwt
$TOKEN = $(curl -X POST http://mp3converter.com/login -u user@example.com:admin)

# upload the video
curl -X POST -F 'file=@./video.mp4' -H "Authorization: Bearer $TOKEN" http://mp3converter.com/upload
