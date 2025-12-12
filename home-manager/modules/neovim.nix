{ pkgs, ... }:
{
	programs.neovim = {
		enable = true;
		plugins = with pkgs.vimPlugins; [
		blink-cmp
		];
		extraLuaPackages = ps: [
			ps.luasql-sqlite3
			ps.luuid
		];


    };
}
