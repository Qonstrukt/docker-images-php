# Change Log

## Version 8

### Initial

#### New features

- Support for PHP 8.4

#### Dropped features

- PHP 8.1 is dropped

#### Breaking changes

- Base image is Ubuntu 24.04

## Version 7

### 2024-06-10

#### New features

- Support for Node 22

### Initial

#### New features

- Support for PHP 8.3

#### Dropped features

- PHP 8.0 is dropped
- Node 16 is dropped

## Version 6

### Initial

#### New features

- Support for PHP 8.2
- Support for wkhtmltopdf and wkhtmltoimage to be installed
- Support for Node 20

#### Dropped features

- PHP 7.4 is dropped
- Node 14 is dropped

## Version 5

### Initial

#### New features

- Support for ARM64
- Support for Node 18

#### Dropped features

- PHP 7.2 and 7.3 are dropped
- Node 10 and 12 are dropped

#### Breaking changes

- Base image is Ubuntu 22.04


## Version 4

### Minor changes

* **2021-09-22** 
  * Preview for PHP 8.1 | PHP 8.1 in release candidate 2 (miss many extensions)
  * Support for Node v16 | Version LTS
  * Support more PHP 8.0 extensions | Added : mongodb, swoole, zip and blackfire.
  * Enhance builder | Use BuildKit, add header to blueprint exported files and start a Makefile for common build usages.

### Initial

#### New features

- Support for PHP 8.0
- Support for Node 14

#### Breaking changes

- Base image is Ubuntu 20.04
- Dropped Node 8 images
- Dropped PHP 7.1

## Version 3

### Initial

#### Important changes

v2 images are based on a Debian Stretch. v3 images are based on Ubuntu 18.04.
Interally, v3 images are built from the Ondrej PPA. This is a radical change from v2 that was built from the official PHP Docker image. As a result, the v3 image do not have PECL installed, nor a build environment. This makes the v3 images ~200MB lighter.

#### Changes in extensions

The following extensions are now enabled by default: calendar exif pcntl shmop sockets sysvmsg sysvsem sysvshm wddx zip
The sqlite3 extension was previously enabled by default, but must now be enabled manually

## Version 2

### Initial

#### New features

- thecodingmachine/php image now has a "slim" variant that does not contain any extension but that can be used
  to [build the extensions very easily](https://github.com/thecodingmachine/docker-images-php/blob/dfdaa984f0fcc3d66a1b9fef5a6643582deb4d0d/README.md#compiling-extensions-in-the-slim-image).

#### Breaking changes

- PHP 7.1 base image is now **Debian Stretch**
- Dropped Node 6 images

#### New extensions

- Imagick

#### Organization

The project layout has been deeply changed. There is now only one branch for all the PHP versions.
Each extension now has its own installation script in the `/extensions/core` directory with symlinks for the 
extensions in the `/extensions/7.1` and `/extensions/7.2` directory based on the targeted PHP version.
