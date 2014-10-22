
function connect_server()
--  print ("check master:" .. proxy.global.config.master.addr)
  for i = 1, #proxy.global.backends do
    local s = proxy.global.backends[i]
--    print ("check " .. s.dst.name)
    if s.dst.name == proxy.global.config.master.addr then
      proxy.connection.backend_ndx = i
--        print ("connecting to " .. proxy.global.config.master.addr)
      return
    end
  end
end

function read_query(packet)
--  print ("check master:" .. proxy.global.config.master.addr)
  for i = 1, #proxy.global.backends do
    local s = proxy.global.backends[i]
--    print ("check " .. s.dst.name)
    if s.dst.name == proxy.global.config.master.addr then
      proxy.connection.backend_ndx = i
--        print ("connecting to " .. proxy.global.config.master.addr)
      return
    end
  end
end

-- for debugging
function read_handshake()
        print("<-- let's send him some information about us")
        print("    mysqld-version: " .. proxy.connection.server.mysqld_version)
        print("    thread-id     : " .. proxy.connection.server.thread_id)
        print("    scramble-buf  : " .. string.format("%q",proxy.connection.server.scramble_buffer))
        print("    server-addr   : " .. proxy.connection.server.dst.name)
        print("    client-addr   : " .. proxy.connection.client.dst.name)
end
