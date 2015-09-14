# Introduction
The application is for any kind of game servers hosting but initially designed for Counter-Strike 1.6 game servers hosting

# Requirements
* Debian 8.2 x86_64
* Root user access
* TLS v1.2 Certificate (https://www.comodo.com)
* Stripe API (https://stripe.com)
* Twilio API (https://twilio.com)
* DigitalOcean API (https://digitalocean.com)

# Install
Login as root and run:

```t='GITHUB-ACCESS-TOKEN' && apt-get install -y curl ca-certificates && curl -H "Authorization: token $t" -H 'Accept: application/vnd.github.v3.raw' -O -L https://api.github.com/repos/kurbaitis/hosting/contents/public/s && bash s $t```

Put your TLS cert into ```tls/cert``` and the key into ```tls/key```

Edit ```.env``` file

```vi .env```

# Start
``` ./bin/start ```
# Stop
``` ./bin/stop ```