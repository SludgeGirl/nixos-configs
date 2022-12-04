{}: {
  folder = ./.;
  config = {
    "hosts/*/profiles".functor.enable = true;
    "hosts/*/modules".functor.enable = true;
    "hosts/*/home".functor.enable = true;
    "profiles/*".functor.enable = true;
    "users/*".functor.enable = true;
  };
}
