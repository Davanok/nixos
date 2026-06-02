{ ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;

      # substituters = [
      #     "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      #     "https://cache.nixos.org"
      # ];
      # trusted-public-keys = [
      #   "mirrors.tuna.tsinghua.edu.cn-1:10a4401e1495c029339f417855047f08" # Example key, check TUNA website for current
      # ];
      # http-connections = 128;
      # max-substitution-jobs = 128;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
