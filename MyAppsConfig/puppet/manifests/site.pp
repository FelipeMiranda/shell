node 'prod1.intranet' {}
node 'prod2.intranet' {}
node 'prod3.intranet' {}

#include ambiente-dev

include git
include helloworld
include apache

#class { 'helloworld': }
class { 'helloworld::motd': }
class { 'private_keys': }
#class { 'apache': }

git::config { 'user.name':   value => 'Rafael Quirino', }
git::config { 'user.email':  value => 'quirinobytes@gmail.com',}
class { git::clone: repo => 'shell' } # essa classe top clona o repositorio.
