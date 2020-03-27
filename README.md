<h1 align="center">snc (sharif-network-connector)</h1>

\`snc\` is a shell code which gives you a hand to connecting to sharif modems and log in to [net2.sharif.edu](https://net2.sharif.edu)

## Installation

### Installing Dependencies
**Dependencies:**

- A laptop that linux is installed on it
- Being a sharif student for having sharif-id
- Some packages that snc install them for you

### Installing snc

1- Clone the repository
 * `git clone https://github.com/mhbahmani/snc.git`

2- Install
 * Linux
   * step into the directory: `cd snc`
   * `./install.sh`
 * macOs and windows **(in the near feature)** 
   * i'll be happy if you contibute to this!

### snc; How to use

| **Command**                       | **Description**                                       |
|:----------------------------------|:------------------------------------------------------|
|`snc config, co`                   | set net2 username and password                        |
|`snc config, co <username> <pass> `| same previous one 
|`snc connect, c`                   | Connect to a modem you added and log in to net2       |
|`snc newmodem, n <modem_ssid>`     | Add a modem to your to connect modems list            |
|`snc remove, r <modem_ssid>`       | Remove a modem from your to connect modems list       |
|`snc show, s`                      | Show to connect modems list                           |
|`snc --help, -h`                   | Show help table                                       |
|`snc status, s`                    | Print connection status.                              |

## Bug Report and Feedback
 * Please let me know if there is any bug
 * If you had any Feedback about `snc`, i'll be glad to hear it.
 * You can contact me via:
   * email: mhbahmani79@gmail.com / mhbahmani@ce.sharif.edu
   * twitter direct message: @mh_bahmani
