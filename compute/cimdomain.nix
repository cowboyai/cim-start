{
  network.description = "CIM Domain";

  # import all the VMs for the Domain Cluster
  imports = [
    ./dev
    ./dns
    ./nats
  ];
}
