# Kerberos Debugging Notes.

- `export KRB5_TRACE=/dev/stdout` will allow lots of logging which is very helpful
- The default keytab location is not where gss_acquire_cred looks for credentials, but rather /etc/krb5/user/*user-id*/client.keytab
- that file is not created by default by kinit. It has to be set up with ktutil
   ```
   ktutil:  addent -password -p v-brucc@SCX.COM -k 1 -e RC4-HMAC
   Password for v-brucc@SCX.COM:
   ktutil:  wkt /etc/krb5/user/2738/client.keytab
   ktutil:  q
   ```
   will create a keytab (2738 is uid)    

   I had to set permissions to v-brucc:scxdev on the keytab make everything work





