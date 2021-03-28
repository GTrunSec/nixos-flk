function docker-clean
         docker rmi (docker images -f "dangling=true" -q)
end
