<h1 align="center">snc (sharif-network-connector)</h1>

`snc` is a shell code which gives you a hand to connecting to sharif modems and log in to [net2.sharif.edu](https://net2.sharif.edu)
 
## snc; How it works
- First of all, you have to set net2 username and password.
- Then you should add your almost used modems to your list.
- Now, `snc` is ready to use.
- Use `snc connect` command and boom! you're connected to one of your modems that has the strongest signal and also logged in to ne2.sharif.edu!

# Installation

### Installing Dependencies
**Dependencies:**

- Laptop!
- net2 account

## Installing snc
### Automatic
1- Run install.sh directly with one of these two
 - Linux and MacOS
   - using wget:
     * `bash -c "$(wget -q -O- https://raw.githubusercontent.com/mhbahmani/snc/master/install.sh)"`
   - using curl:
     * `bash -c "$(curl -L -fsS -r 5 https://raw.githubusercontent.com/mhbahmani/snc/master/install.sh)"`
 - Windows **(in the near future)** 
   - 404 Not Found :(

### Manual
1- Clone the repository
 * `git clone https://github.com/mhbahmani/snc.git` 

2- Install
 * Linux and MacOS
   * step into the directory: `cd snc`
   * run `./install.sh`
 * Windows **(in the near future)** 
   * i'll be happy if you contibute to this!

## snc; How to use

| **Command**                       | **Description**                                       |
|:----------------------------------|:------------------------------------------------------|
|`snc config, co`                   | Set net2 username and password                        |
|`snc config, co <username> <pass>` | Same as previous one                                  |
|`snc connect, c`                   | Connect to a added modem and log me in to net2        |
|`snc connect, c <modem_name>`      | Connect to given modem                                |
|`snc newmodem, n <modem_name> ...` | Add a modem to my to connect modems list              |
|`snc remove, r <modem_name> ...`   | Remove a modem from my to connect modems list         |
|`snc show, sh`                     | Show modems list                                      |
|`snc status, s`                    | Print connection status.                              |
|`snc --help, -h`                   | Show help table                                       |

you can add or remove several modems with once using related command.

## Bug Report and Feedback

 * Please let me know if there is any bug
 * If you had any Feedback on `snc`, i'll be glad to hear it.
 * You can contact me via:
   * email: mhbahmani79@gmail.com / mhbahmani@ce.sharif.edu
   * twitter direct message: @mh_bahmani
