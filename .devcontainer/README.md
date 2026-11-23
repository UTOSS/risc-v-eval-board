# Remote desktop

The image installs XFCE, XRDP, and the KiCad 10 stable PPA. Rebuild the devcontainer to use Ubuntu 26.04 and XFCE 4.20. New KiCad major releases require updating the PPA in the Dockerfile.

1. In the container terminal, set a password for the `dev` account with `sudo passwd dev`. The image deliberately does not contain a shared password; repeat this after rebuilding unless the account is persisted.
2. In VS Code's **Ports** panel, verify that port 3389 is forwarded to your remote computer. If it is not, add a forward for container port 3389. Check the **Local Address** shown in that panel: VS Code may choose a different local port if 3389 is occupied.
3. On the remote computer, open an RDP client and connect to that local address (for example, `localhost:3389`). At the XRDP login, select **Xorg** and sign in as `dev` with the password you set.

Keep the port private and use the authenticated VS Code/SSH tunnel. `EXPOSE` describes the container port; it does not publish it on the Windows host. A direct connection to Windows requires separate Docker port publishing and Windows firewall/network configuration, which is not needed for the VS Code tunnel. If VS Code forwards only to the Windows host in your setup, create an SSH local forward from the remote computer to that Windows-side forwarded address instead.
