{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = [
        pkgs.gcc
        pkgs.gnumake
        pkgs.cmake
    ];
}
