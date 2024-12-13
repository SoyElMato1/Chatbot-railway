release: apt-get update && apt-get install -y supervisor python3-pip && pip install rasa rasa-sdk django && echo "export PATH=$PATH:~/.local/bin" >> ~/.bashrc

web: supervisord -c supervisord.conf

# release: pip install rasa django
# train: rasa train
# web: rasa run --enable-api --cors "*" --port 5005
# actions: rasa run actions