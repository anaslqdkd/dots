{ pkgs, ... }:
{
	programs.neovim = {
		enable = true;
		extraLuaPackages = ps: [
			ps.luasql-sqlite3
			ps.luuid
		];


    };
}
