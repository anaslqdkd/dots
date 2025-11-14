{ pkgs, ... }:
{
	programs.neovim = {
		enable = true;
		plugins = with pkgs.vimPlugins; [
		nvim-jdtls
		];
		extraLuaPackages = ps: [
			ps.luasql-sqlite3
			ps.luuid
		];


    };
}
