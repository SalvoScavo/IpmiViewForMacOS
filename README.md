# IpmiViewForMacOS

Run Supermicro IPMIView on macOS (Apple Silicon) inside an x86_64 Docker container. IPMIView has no official macOS build, so the container runs the Linux x86 version under Rosetta and exposes its GUI in your browser through noVNC.

## Requirements
- Docker Desktop (or OrbStack)
- Rosetta 2 installed (softwareupdate --install-rosetta)
- Rosetta enabled in Docker Desktop: Settings → General → Use Rosetta for x86_64/amd64 emulation on Apple Silicon



    
## Install IPMIView
Download the Linux version of IPMIView from the Supermicro download center (the version tested here is 2.21.1).
Extract it inside the ipmiview/ folder, so that IPMIView20.jar sits directly in ipmiview/ and not in a subfolder. For a .tar.gz:
mkdir -p ipmiview
tar -xzf IPMIView_*.tar.gz -C ipmiview --strip-components=1
Check with ls ipmiview: you should see the jar, the IPMIView20 script and the .so libraries.

The ipmiview/ folder is mounted into the container, it is not copied into the image. You can update IPMIView without rebuilding.

# Usage

docker compose up --build

(--build is only needed the first time, or after changing the Dockerfile or start.sh.)

Then open http://localhost:6080/ in your browser, click Connect (no password) and IPMIView will be running in the desktop.

In IPMIView add your BMCs by IP address (File → New → System). Broadcast discovery does not work from inside Docker.

To stop: Ctrl+C, then docker compose down to remove the container.

Network and VPN

The container reaches the BMCs through the Mac's network, so if the BMCs are only reachable through a VPN, connect the VPN on the Mac before starting the container.


To use a different IPMIView version, download it from the Supermicro link above, empty the ipmiview/ folder and extract the new version there as described in Install IPMIView. No rebuild is needed.


IPMIView is proprietary Supermicro software and is not included in this repository.
