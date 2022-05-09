let
  rev = "b4a34015c698c7793d592d66adbab377907a2be8";
  flake = (
    import
    (
      fetchTarball {
        url = "https://github.com/edolstra/flake-compat/archive/${rev}.tar.gz";
        sha256 = "1qc703yg0babixi6wshn5wm2kgl5y1drcswgszh4xxzbrwkk9sv7";
      }
    )
    {
      src = ../../.;
    }
  );
in
  flake
