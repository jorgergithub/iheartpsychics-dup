# PayPal Setup

1. Create a sandbox account;

2. Log in at http://www.sandbox.paypal.com with the account;

3. Click Profile (the main link, not any of subitems);

4. Under "More selling tools", click "Encrypted payment settings";

5. Under "Your Public Certificates", click "Add";

6. Go to the command line and create your key (in case you don't have one) under the `certs/` dir:

    `openssl genrsa -out iheartpsychics_dev_key.pem 1024`

7. From the key, create a certificate:

    `openssl req -new -key iheartpsychics_dev_key.pem -x509 -days 365 -out iheartpsychics_dev_cert.pem`

8. Upload the iheartpsychics_dev_cert.pem file created on step 7;

9. Take note on the Cert ID as you'll need to replace it on the config file;

