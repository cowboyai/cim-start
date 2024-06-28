    import time

    # Check if the SSH service is running
    assert machine.succeed("systemctl is-active sshd")

    # Check the Containers are running (containers have their own tests)
    assert machine.succeed("systemctl is-active container@dns")
    assert machine.succeed("systemctl is-active container@nats")
    assert machine.succeed("systemctl is-active container@cim-dev")
    assert machine.succeed("systemctl is-active container@agents")
    assert machine.succeed("systemctl is-active container@web")
    assert machine.succeed("systemctl is-active container@vault")
    assert machine.succeed("systemctl is-active container@neo4j")
    assert machine.succeed("systemctl is-active container@wash")
    assert machine.succeed("systemctl is-active container@ollama")

    # Add more health checks as needed
    print("All health checks passed!")
