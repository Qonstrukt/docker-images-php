# Migrating from v7 to v8 images

Important changes:

- v7 images are based on **Ubuntu 22.04**. v8 images are based on **Ubuntu 24.04**.
- PHP 8.1 is dropped as it hasn't received active support anymore for a long time.

# Migrating from v6 to v7 images

Important changes:

- PHP 8.0 is dropped as it has reached EOL.
- Node 16 has been removed as it has reached EOL.

# Migrating from v5 to v6 images

Important changes:

- PHP 7.4 is dropped as it has reached EOL.
- Node 14 has been removed in favor of Node 20.

# Migrating from v4 to v5 images

Important changes:

- v4 images are based on **Ubuntu 20.04**. v5 images are based on **Ubuntu 22.04**.
- Node 12 has been removed in favor of Node 18.
- Images are now also built for ARM64.

# Migrating from v3 to v4 images

Important changes:

- v3 images are based on **Ubuntu 18.04**. v4 images are based on **Ubuntu 20.04**.
- Internally, the image will attempt to set up extensions / parameters on container startup (in the image entry point),
  but also when PHP is run. This should help alleviate a part of the problems when the entrypoint is overloaded by the
  user.

# Migrating from v2 to v3 images

Important changes:

- v2 images are based on a Debian Stretch. v3 images are based on **Ubuntu 18.04**.
- Internally, v3 images are built from the [Ondrej PPA](https://launchpad.net/%7Eondrej/+archive/ubuntu/php/+index?batch=75&memo=75&start=75).
  This is a radical change from v2 that was built from the official PHP Docker image.
  As a result, the v3 image do not have PECL installed, nor a build environment. This makes the v3 images ~200MB lighter. 

Changes in extensions:

- The following extensions are now **enabled by default**: `calendar exif pcntl shmop sockets sysvmsg sysvsem sysvshm wddx zip`
- The `sqlite3` extension was previously enabled by default, but must now be enabled manually
