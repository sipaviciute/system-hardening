# System Hardening

This was a 4th semester university project. After the defence, got the maximum amount of points for it.

## The task was:

Create scripts to make "some website safer". For this, you will need at least 4 machines. Machine 1 would be the master, machine 2 is the webserver, machine 3 is the database, machine 4 is the backup server. Machines 2 and 3 would be the system you're trying to make more secure. For this, you would need to use Ansible or any other automation platform.

Environment:

1. Use an existing OpenNebula debian/ubuntu/any other template.

2. Install a low version web server application.

3. Install a low version SQL engine. Add 10 random users with weak dictionary passwords to the SQL server.

4. Install a low version WordPress (6 or lower) CMS. Install at least 5 low version plugins with possible vulnerabilities and their CVE codes present (you must add additional 5 to the default ones). Add at least 7 admin users to the CMS with different roles.

5. Create at least 8 random distribution users with somewhat safe (e.g. Pa$$w0rD) passwords. Two of the users should have admin rights, three with sudo rights, others - the most minimal rights.

Automated tasks list:

1. Secure your login procedures: for every user created change the password length to a minimum 22 while using sha-256, AES-256, bcrypt encryption algorithms.

2. Update all the software, plugins, and other things to the latest version (CMS, Web server, SQL server etc.).

3. Remove sudo permissions for all other users. Remove the possibility for users to browse other users' accounts.

4. Install ModSecurity WAF for the server. Make paranoia level 2 in WAF. WAF must send you reports once per day from webserver.

5. Limit login attempts to your CMS and change the default connection URL. 

6. Disable file editing in the user permissions dashboard.

7. Disable xml-rpc file.

8. Delete all the unnecessary metadata from everywhere (e.g. wp version in the page source, in the admin panel, the readme.html, the rss feed, etc.)

9. Limit CMS user permissions. 

10. Enable the Directory Index Protection, preventing directory index listings and defaulting, deny any request not using POST, REQUEST. Deny any badly formed HTTP PROTOCOL in requests.

11. Create a backup of the system in the backup server.
