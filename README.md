# Pishock CPMA
Bunny hopping in CPMA, but with a twist.

I don't even know what CPMA is, my friend told me to download it and we played a few matches. Afaik it's a Quake 3 mod (??) which implements multiplayer shooting mechanics. It's fun you should try it.

Pishock CPMA hosts a private (but still publicly joinable) server, where every time the username "Pancake" dies, the server owner gets shocked... It's a good idea to change the name from "Pancake" to your username...

> [!WARNING]
> I'm not responsible for any damages done by this project (AI wrote most of this anyways, do I look like I know how to write bash scripts).
> Please be careful.

> [!IMPORTANT]
> For legal reasons, this tool was not designed to be used on animals or humans. You can probably get away with using it on aliens, if you find any.
> I'm not sure how this rule extends to catgirls and other hybrids.. ask your lawyer

> [!NOTE]
> The code of this repository is basically identical to [Pishock Roulette](https://github.com/PancakeTAS/pishock-roulette).. If I keep writing these, I'll have to make shared code for them.

## How do I use it?
Well, first of all you're going to need a [shock collar](https://pishock.com/). Then you're going to need to install [CPMA](https://playmorepromode.com/). I'm guessing you already know how to do that, so let's skip to the server installation. Which you can find [here](https://playmorepromode.com/guides/cnq3-dedicated-server-guide). Move the server into a folder called CPMA and ensure that ./CPMA/cnq-server-x64 is executable.

Now, create a file called `shockenv.sh` and enter your secrets:
```bash
#!/bin/bash
export PISHOCK_USER="Username"
export PISHOCK_API_KEY="xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
export PISHOCK_CODE="FFFFFFFFFFF"
```

Then, open `start.sh` and adjust the intensity and duration to what you can handle. I also added a timeout to prevent spawnkilling.
```bash
...

# Configure shock (can only be the same as on the web interface)
MIN_INTENSITY=20
MAX_INTENSITY=30
DURATION=0.3
TIMEOUT=15

...
```

Finally, run `./start.sh` and enjoy the game! Well, almost.
Depending on how you setup the server you might have to manually loads a map and execute some configs. The console *does* work, despite not having any output..

## How does it work?
CPMA logs a unique message into the console every time a player dies. `./start.sh` simply launches the server and reads through stdout. When it finds the message, it sends a shock to the PiShock api and sets a timeout to ensure you don't get spawnkilled (or shockkilled? (github copilot came up with this joke)).

## How do I know it works?
Launch the server, log onto it, start the match... and die! If you're shocked, it works! If you're not, you might have to check the logs on the website. It doesn't seem to work while the game is in prep-phase, but I have no clue how CPMA works so I can't help you there.

## Is it tested?
In two astonishing 30:1 and 10:6 10-minute matches, I can confirm, it does indeed work.
