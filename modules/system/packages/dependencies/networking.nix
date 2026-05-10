{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sing-box
    nur.repos.wenjinnn.hiddify-next
  ];
}
