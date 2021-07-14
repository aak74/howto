#!/bin/bash

SERVER=email-smtp.us-east-1.amazonaws.com
BODY="PUT YOUR MAIL BODY HERE"
SUBJECT="SUBJECT"
USERNAME=YOUR-USERNAME
PASSWORD="YOUR-PASSWORD"
TO=user@example.com
FROM="Noreply <noreply@example.com>"

echo $SUBJECT \
    -S smtp=smtp://$SERVER \
    -S smtp-auth=login \
    -S smtp-auth-user=$USERNAME \
    -S smtp-auth-password=$PASSWORD \
    -S from=$FROM \
    $TO

echo $BODY | mailx -s $SUBJECT \
    -S smtp=smtp://$SERVER \
    -S smtp-auth=login \
    -S smtp-auth-user=$USERNAME \
    -S smtp-auth-password=$PASSWORD \
    -S from=$FROM \
    $TO