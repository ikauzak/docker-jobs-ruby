require 'serverspec'
require 'docker'

# Setting docker url connection
Docker.url = 'tcp://localhost:2375/'

# Setting docker image name and tag
image_tag = ENV['IMAGE_TAG']
image_name = ENV['IMAGE']

# Setting registry to be authenticated
registry = 'https://' + ENV['REGISTRY']

# Setting gcr key to be read to login
gcr_auth_key = ENV['GCR_AUTH_KEY']
file = File.open(gcr_auth_key, 'r')

puts image_tag + image_name + docker_tls_certdir

Docker.authenticate!('username' => '_json_key', 'serveraddress' => registry, 'password' => file.read)
