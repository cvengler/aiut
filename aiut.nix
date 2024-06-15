{config, pkgs, lib, ...}:

let
  cfg = config.services.aiut;
in

with lib;
{
  options = {
    services.aiut = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Starts aiut.
        '';
      };

      listen = mkOption {
        default = "127.0.0.1:8080";
        type = with types; str;
        description = ''
          An addr:port string specifying the address and port to listen on.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.aiut = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = with pkgs; [ bash curl ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "/opt/aiut/run.sh ${cfg.listen}";
        WorkingDirectory = "/opt/aiut";
        Restart = "always";
        RuntimeMaxSec = "1h";

        # Sandboxing
        CapabilityBoundingSet = "";
        DeviceAllow = [ "" ];
        DynamicUser = true;
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        PrivateDevices = true;
        PrivateTmp = true;
        PrivateUsers = true;
        ProcSubset = "pid";
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectProc = "invisible";
        ProtectSystem = "strict";
        RestrictAddressFamilies = [ "AF_INET AF_INET6" ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
      };
    };
  };
}
