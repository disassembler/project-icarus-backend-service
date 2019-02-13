with (import <nixpkgs> {});
rec {
  project-icarus-backend = mkYarnPackage {
    name = "project-icarus-backend";
    src = lib.cleanSource ./.;
    postInstallPhase = ''
      mkdir -p $out/bin
      cat > $out/bin/icarus-backend-service <<EOF
      #!${stdenv.shell}
      exec ${pkgs.nodejs}/bin/node $out/node_modules/icarus-poc-backend-service/src/index.js
      EOF
      chmod +x $out/bin/icarus-backend-service
    '';
    packageJson = ./package.json;
    yarnLock = ./yarn.lock;
  };
}
