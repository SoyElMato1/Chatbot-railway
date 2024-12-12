release: apt-get update && apt-get install -y supervisor python3-pip && pip install rasa rasa-sdk
web: supervisord -c /PruebaCharbot/chatbot/supervisord.conf

# release: pip install rasa
# train: rasa train
# web: rasa run --enable-api --cors "*" --port 5005
# actions: rasa run actions