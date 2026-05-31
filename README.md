# Chatwoot en Railway

## Pasos para deployar

### 1. Subir este repositorio a GitHub
```bash
cd chatwoot-railway
git init
git add .
git commit -m "Chatwoot Railway deploy"
gh repo create chatwoot-railway --public --push --source=.
```
(necesitás tener `gh` instalado, o crearlo manualmente en github.com)

### 2. Crear proyecto en Railway
1. Ir a https://railway.app/new
2. **Deploy from GitHub repo** → seleccionar `chatwoot-railway`

### 3. Agregar PostgreSQL
1. En el proyecto → **New Service** → **Database** → **PostgreSQL**
2. Esto genera `DATABASE_URL` automáticamente

### 4. Agregar Redis
1. En el proyecto → **New Service** → **Database** → **Redis**
2. Esto genera `REDIS_URL` automáticamente

### 5. Configurar Variables del servicio Chatwoot (web service)
En el servicio chatwoot-railway → **Variables** → agregar:
```
SECRET_KEY_BASE=<genera uno con: openssl rand -hex 64>
RAILS_ENV=production
NODE_ENV=production
INSTALLATION_ENV=docker
FRONTEND_URL=https://<tu-app>.up.railway.app
```
El `DATABASE_URL` y `REDIS_URL` se vinculan automáticamente desde los plugins.

### 6. Primera corrida: setup de DB
En Railway → servicio web → **Deploy Logs** → cuando esté corriendo:
1. Ir a **Settings** → **Execute Command**:
```
bundle exec rails db:chatwoot_prepare
```

### 7. Agregar servicio Worker (Sidekiq)
1. **New Service** → **GitHub Repo** → mismo repo `chatwoot-railway`
2. Override start command: `bundle exec sidekiq -C config/sidekiq.yml`
3. Mismas variables de entorno que el web service

### 8. Acceder
- Railway genera una URL tipo: `https://chatwoot-railway-production.up.railway.app`
- Crear cuenta admin en esa URL
- Copiar la URL y pegarla en ERPNext → Chatbot → **⚙ Configurar URL**
