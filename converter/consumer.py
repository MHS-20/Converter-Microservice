import pika, sys, os, time
from pymongo import MongoClient
import gridfs
from convert import to_mp3

def main (): 
    mongo_uri = os.environ.get("MONGO_URI")
    client = MongoClient(mongo_uri)
    # client = MongoClient("host.minikube.internal", 27017)
    db_videos = client.videos
    db_mp3s = client.mp3s

    # mongo_videos_uri = os.environ.get("MONGO_VIDEOS_URI")
    # mongo_mp3s_uri = os.environ.get("MONGO_MP3S_URI")

    # client_videos = MongoClient(mongo_videos_uri)
    # client_mp3s = MongoClient(mongo_mp3s_uri)
    
    # db_videos = client_videos.videos
    # db_mp3s = client_mp3s.mp3s

    fs_videos = gridfs.GridFS(db_videos)
    fs_mp3s = gridfs.GridFS(db_mp3s)

    connection = pika.BlockingConnection(pika.ConnectionParameters(host='rabbitmq'))
    channel = connection.channel()

    def callback(ch, method, properties, body):
        err = to_mp3.start(body, fs_videos, fs_mp3s, ch)
        if err: 
            ch.basic_nack(delivery_tag=method.delivery_tag)
        else: 
            ch.basic_ack(delivery_tag=method.delivery_tag)

    channel.basic_consume(
        queue=os.environ.get('VIDEO_QUEUE'),
        on_message_callback=callback
    )

    print("Waiting for messages.")

    channel.start_consuming()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("Interrepted")
        try: 
            sys.exit(0)
        except SystemError:
            os._exit(0)


