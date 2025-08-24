
kubectl exec -it mongodb-0 -- mongosh

use admin
db.auth("root", "password123")

# Controlla utenti nel database videos
use videos
db.getUsers()

# Controlla utenti nel database mp3s
use mp3s
db.getUsers()

exit