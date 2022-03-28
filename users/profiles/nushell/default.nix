{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;

    settings = {
      line_editor = {
        edit_mode = "vi";
        completion_mode = "circular";
      };

      skip_welcome_message = true;
      table_mode = "light";
      prompt = "starship prompt";

      env = {
        STARSHIP_SHELL = "nushell";
      };
    };
  };
}
