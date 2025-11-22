{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs   = inputs.nixpkgs.legacyPackages.${system};
    in
    {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem{
      modules = [
	./configuration.nix
      ];
    };
      # devShells.${system}.default = pkgs.mkShell {
      #   packages = [
      #     pkgs.youtube-tui
      #   ];
      # };
    };
}
