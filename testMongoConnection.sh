# Testa connessione videos
kubectl exec deployment/gateway -- python3 -c "
import pymongo
try:
    client = pymongo.MongoClient('mongodb://video_user:video_password@mongodb:27017/videos')
    db = client['videos']
    print('Videos DB: OK')
    print('Collections:', db.list_collection_names())
except Exception as e:
    print(f'Videos DB failed: {e}')
"

# Testa connessione mp3s
kubectl exec deployment/gateway -- python3 -c "
import pymongo
try:
    client = pymongo.MongoClient('mongodb://mp3_user:mp3_password@mongodb:27017/mp3s')
    db = client['mp3s']
    print('MP3s DB: OK')
    print('Collections:', db.list_collection_names())
except Exception as e:
    print(f'MP3s DB failed: {e}')
"