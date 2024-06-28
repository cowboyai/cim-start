{
  enable = true;
  settings = {
    do-ip4 = "yes";
    do-ip6 = "no";
    do-udp = "yes";
    do-tcp = "yes";
    server = {
      interface = ["0.0.0.0"];
      access-control = [
        "192.168.1.0/24 allow"
      ];

      local-zone = ''"cim.thecowboy.ai." static'';

      local-data = [
        ''"cim.thecowboy.ai.           IN A 100.96.142.78"''
        ''"gw.cim.thecowboy.ai.        IN A 192.168.1.1"''
        ''"nats.cim.thecowboy.ai.      IN A 192.168.1.253"''
        ''"ollama.cim.thecowboy.ai.    IN A 192.168.1.128"''
        ''"wash.cim.thecowboy.ai.      IN A 192.168.1.32"''
        ''"neo4j.cim.thecowboy.ai.     IN A 192.168.1.54"''
        ''"vault.cim.thecowboy.ai.     IN A 192.168.1.66"''
        ''"agents.cim.thecowboy.ai.    IN A 192.168.1.64"''
        ''"web.cim.thecowboy.ai.       IN A 192.168.1.101"''
        ''"vhost-dev.cim.thecowboy.ai. IN A 192.168.1.100"''
        ''"cim-dev.cim.thecowboy.ai.   IN A 192.168.1.81"''
        ''"router1.cim.thecowboy.ai.   IN A 192.168.1.130"''
        ''"ns.cim.thecowboy.ai.        IN A 192.168.1.254"''
        ''"ipa.cim.thecowboy.ai.       IN A 192.168.1.252"''
        ''"gateway1.cim.thecowboy.ai.  IN CNAME gw.cim.thecowboy.ai"''
      ];

      local-data-ptr = [
        ''"192.168.1.1    gw.cim.thecowboy.ai"''
        ''"192.168.1.253  nats.cim.thecowboy.ai"''
        ''"192.168.1.128  ollama.cim.thecowboy.ai"''
        ''"192.168.1.54   neo4j.cim.thecowboy.ai"''
        ''"192.168.1.66   vault.cim.thecowboy.ai"''
        ''"192.168.1.64   agents.cim.thecowboy.ai"''
        ''"192.168.1.81   cim-dev.cim.thecowboy.ai"''
        ''"192.168.1.32   wash.cim.thecowboy.ai"''
        ''"192.168.1.101  web.cim.thecowboy.ai"''
        ''"192.168.1.100  vhost-dev.cim.thecowboy.ai"''
        ''"192.168.1.81   cim-dev.cim.thecowboy.ai"''
        ''"192.168.1.130  router1.cim.thecowboy.ai"''
        ''"192.168.1.252  ipa.cim.thecowboy.ai"''
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
