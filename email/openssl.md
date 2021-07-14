# Send email with openssl

[Test your connection to the Amazon SES SMTP interface using the command line ](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-smtp-client-command-line.html)

```sh
# 587
openssl s_client -crlf -quiet -starttls smtp -connect email-smtp.us-east-1.amazonaws.com:587 < ./bash/aws-mail.txt

# 465
openssl s_client -crlf -quiet -connect email-smtp.us-east-1.amazonaws.com:465 < ./bash/aws-mail.txt

```