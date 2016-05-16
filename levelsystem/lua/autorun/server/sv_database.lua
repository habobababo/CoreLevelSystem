
require("mysqloo")

local DATABASE_HOST = "127.0.0.1"
local DATABASE_PORT = 3306
local DATABASE_NAME = "x"
local DATABASE_USERNAME = "x"
local DATABASE_PASSWORD = "x"
mysql = {}





local function ConnectToDatabase()

	database = mysqloo.connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME, DATABASE_PORT)
	
	function database:onConnected()
		print("\n*** Connectet to Mysql Database ***") 
		print("Server Version:", database:serverVersion() )
		print("Server Info:", database:serverInfo() )
		print("Host Info:", database:hostInfo() )
		print("\n")
		
		-- timer.Simple(1, function()
			-- LoadDonators()
		-- end)
	end

	function database:onConnectionFailed( err )
		print( "Connection to database failed!" )
		print( "Error:", err )
	end
	
	database:connect()
	
	timer.Simple(1, function() hook.Call("DatabaseLoaded") end)
end
hook.Add("Initialize", "Initialize_databse", ConnectToDatabase)

function mysql.query(querystr, callback)
	if !querystr then print("Querystr failed") return end
	if !database then ConnectToDatabase(); timer.Simple(1.5, function() mysql.query(querystr, callback); print("Database failed") end) end

	local status = database:status()
	if status == 2 or status == 3 then
		print("Status Failed")
		return
	end
	
	local Query = database:query(querystr)
	
	if Query == nil then timer.Simple(1, function() mysql.query(querystr, callback); print("Query Failed... retrying") end) return end
	
	function Query.onSuccess( userdata )
		if callback then
			callback(Query:getData()) 
		end
	end
 
    function Query:onError( err, sql )
        print( "Query errored!" )
        print( "Query:", sql )
        print( "Error:", err )
    end
 
    Query:start()
end


