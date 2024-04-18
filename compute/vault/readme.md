# Vault
This is a local instance of VaultWarden, an open source version of BitWarden.

Vault is for you to securely keep all your secrets in one place and be able to access it over a CIM.

For lots of reasons, hosting all your passwords at a vendor location is quite shocking that people can trust it.

Most of these are not free and you might loose all your saved passwords if something happens to the vendor, or you decide to stop paying them.

Besides, we don't want to require internet access to read our passwords.

If I am running locally offline (even because of a temporary outage) I need my passwords, and all the other secrets I keep in a Vault.

This is a critical step in maintaining your security.

Typically you will see this created behind a reverse proxy, but a CIM already has that, so we don't want it in our container.

