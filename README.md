# aws-ec2-terraform-test
Serverspec test for the [aws-ec2-terraform](https://github.com/swiftsoftwaregroup/aws-ec2-terraform) deployment

## Setup for macOS

### AWS CLI

[Setup macOS for AWS Cloud DevOps](https://blog.swiftsoftwaregroup.com/setup-macos-for-aws-cloud-devops)

[AWS Authentication](https://blog.swiftsoftwaregroup.com/aws-authentication)

Install `rbenv` via Homebrew:

```bash
# install
brew install rbenv

# initialize
rbenv init
```

## Development

Configure project:

```bash
source configure.sh
```

Open the project in Visual Studio Code:

```bash
code .
```

## Run Tests

Make sure you have deployed [aws-ec2-terraform](https://github.com/swiftsoftwaregroup/aws-ec2-terraform) and that you can connect to the instance via SSH:

```bash
# SSH access key
key="aws-ec2-key"

# instance name
instance="nginx-server-tf"

# instance IP
instance_public_ip=$(aws ec2 describe-instances --filters Name=tag:Name,Values=$instance | jq -r '.Reservations[-1].Instances[-1].PublicIpAddress')

ssh -i ~/.ssh/$key ec2-user@$instance_public_ip
```

Run tests:

```bash
./test.sh

# or
export SPEC_HOST=$instance_public_ip
export SPEC_USER="ec2-user"
export SPEC_SSH_KEY="~/.ssh/$key"

bundle exec rspec spec/nginx-server-tf
```

## How to create a new project

### Create Ruby project

```bash
# install ruby 
rbenv install 3.3.0
rbenv local 3.3.0 

# install bundler
gem install bundler

# init project (creates empty Gemfile)
bundle config set path '.bundle'
bundle init

# install gems

# test framework
bundle add serverspec
# needed for ssh connections
bundle add ed25519
bundle add bcrypt_pbkdf
```

### Init Serverspec

```bash
serverspec-init

Select OS type:

  1) UN*X
  2) Windows

Select number: 1

Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 1

Vagrant instance y/n: n
Input target host name: nginx-server-tf

# rename nginx-server-tf/sample_spec.rb to nginx-server-tf/default_spec.rb
mv spec/nginx-server-tf/sample_spec.rb spec/nginx-server-tf/default_spec.rb
```
