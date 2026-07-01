{
  flake.templates = {
    rust-project = {
      path = ./templates/rust;
      description = "A simple Rust project flake";
    };
    dioxus = {
      path = ./templates/dioxus;
      description = "A Dioxus project flake";
    };
    godot = {
      path = ./templates/godot;
      description = "Godot development environment";
    };
  };
}
