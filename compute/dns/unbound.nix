{
  enable = true;
  settings = {
    do-ip4 = "yes";
    do-ip6 = "no";
    do-udp = "yes";
    do-tcp = "yes";
    server = {
      interface = [ "0.0.0.0" ];
      access-control = [
        "192.168.0.0/21 allow"
      ];

      local-zone = ''"cim.thecowboy.ai." static'';

      local-data = [
        ''"cim.thecowboy.ai.           IN A 98.97.118.240"'' #100.96.142.78
        ''"gw.cim.thecowboy.ai.        IN A 192.168.1.1"''
        ''"nats.cim.thecowboy.ai.      IN A 192.168.1.2"''
        ''"ollama.cim.thecowboy.ai.    IN A 192.168.1.53"''
        ''"neo4j.cim.thecowboy.ai.     IN A 192.168.1.54"''
        ''"dev.cim.thecowboy.ai.       IN A 192.168.1.55"''
        ''"apis.cim.thecowboy.ai.      IN A 192.168.1.56"''
        ''"web.cim.thecowboy.ai.       IN A 192.168.1.57"''
        ''"vhost-dev.cim.thecowboy.ai. IN A 192.168.1.100"''
        ''"cim-dev.cim.thecowboy.ai.   IN A 192.168.1.81"''
        ''"cloudkey.cim.thecowboy.ai.  IN A 192.168.1.130"''
        ''"ns.cim.thecowboy.ai.        IN A 192.168.1.254"''
      ];

      local-data-ptr = [
        ''"192.168.1.1    gw.cim.thecowboy.ai"''
        ''"192.168.1.2    nats.cim.thecowboy.ai"''
        ''"192.168.1.53   ollama.cim.thecowboy.ai"''
        ''"192.168.1.54   neo4j.cim.thecowboy.ai"''
        ''"192.168.1.55   dev.cim.thecowboy.ai"''
        ''"192.168.1.56   apis.cim.thecowboy.ai"''
        ''"192.168.1.57   web.cim.thecowboy.ai"''
        ''"192.168.1.100  vhost-dev.cim.thecowboy.ai"''
        ''"192.168.1.81   cim-dev.cim.thecowboy.ai"''
        ''"192.168.1.130  cloudkey.cim.thecowboy.ai"''
        ''"192.168.1.254  ns.cim.thecowboy.ai"''
      ];
    };
    forward-zone = [
      {
        name = ''"."'';
        forward-addr = "1.1.1.1@853";
      }
      {
        name = ''"cim.thecowboy.ai."'';
        forward-addr = [
          "1.1.1.1@853"
          "1.0.0.1@853"
        ];
      }
    ];
  };
}
