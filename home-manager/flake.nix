# flake.nix
{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
	
	zen-browser = {
		url = "github:0xc000022070/zen-browser-flake";
		inputs.nixpkgs.follows = "nixpkgs";
		inputs.home-manager.follows = "home-manager";
	};
	nkfrf = {
		url = "github:anaslqdkd/nkfrf";
		inputs.nixpkgs.follows = "nixpkgs";
	};

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, zen-browser, nkfrf, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in {
      homeConfigurations = {
        ash = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
		  extraSpecialArgs = {
		  zen = zen-browser.packages.${system}.default;
		  nkfrf = nkfrf.packages.${system}.default;
		  inherit pkgs-unstable;
		  };
        };
      };
    };
}
