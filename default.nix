with (import <nixpkgs> {});
rec {
  project-icarus-backend = mkYarnPackage {
    name = "project-icarus-backend";
    src = lib.cleanSource ./.;
    postInstall = ''
      mkdir -p $out/bin
      yarn run flow-remove-types
      cp -vir flow-files $out/
      cat > $out/bin/icarus-backend-service <<EOF
      #!${stdenv.shell}
      cd $out
      exec ${nodejs}/bin/node $out/flow-files/index.js
      EOF
      chmod +x $out/bin/icarus-backend-service
      cp -rv package.json config src tls-files $out/
    '';
    packageJson = ./package.json;
    yarnLock = ./yarn.lock;
  };
}
