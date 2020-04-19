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

# Authenticating in registry
Docker.authenticate!('username' => '_json_key',
                     'serveraddress' => registry, 'password' => file.read)

describe 'Dockerfile' do
  before(:all) do
    # Setting up the image to be pulled
    @image = Docker::Image.create('fromImage' => "#{image_name}:#{image_tag}")

    # Setting up serverspec environment test with a docker image
    set :os, family: :ubuntu
    set :backend, :docker
    set :docker_image, @image.id

    # Setting the container's entrypoint
    set :docker_container_create_options, { 'Entrypoint' => ['sh'] }
  end
end
