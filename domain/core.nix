{
  domain = rec {
    organizations = {
      cowboyai = {
        name = "Example, LLC.";
        id = "05c8ea5f-b091-424f-96da-bcd1f311a598";
      };
    };
    people = {
      john = {
        name = "Johny Appleseed";
        id = "35ca2609-1175-45e0-9bba-f44a561bf6b2";
      };
    };

    dns = {
      example = {
        "root" = "example.com";
        "cim" = "cim.example.com";
      };
    };

    # people in an org defined as users
    users =  [
      "john -[is-user-in]-> example"
    ];
  };
}