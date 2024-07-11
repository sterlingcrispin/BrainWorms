### Brain Worms:
Brain Worms is a fully onchain generative brain parasite system, with PvP, RPG style stats, resource harvesting, and more.

It's built on ERC-404 , so it's a token-coin hybrid. Meaning it is simultaneously an ERC-20 coin and ERC-721 NFT. If you hold more than one token, you automatically own an NFT, if you transfesr some and only have a fraction remaining, the NFT will be sent to a burn pool.

Each time a Brain Worm is removed from the burn pool it is re-rolled with all new stats and traits. However the Generation of the Brain Worm increases. Each generation comes with a -1 penalty to a random stat.

The NFT aspect is generated fully onchain in an ArtBlocks style, where an onchain seed is fed into a JavaScript file which generates artwork based on that. All of the traits are calculated onchain. As well, the thumbnails for the project which are typically stored on IPFS are their own contract which is an onchain generative SVG artwork. This is all combined together into a single blob during the tokenURI request. 

Learn more here:

https://delcomplex.com/brainworms


## Del Complex:
Del Complex is an alternate reality corporation. 

https://delcomplex.com/about

## BrainWorms.sol
The main contract for BrainWorms, defining the core functionalities and properties of the BrainWorms entities. It includes the creation, management, and interaction logic for BrainWorms, acting as the foundation for other related contracts.

## BrainWormsCombatSystem.sol
The combat system handles fights between BrainWorms and does PvP point calculation. When called from BrainWorms.sol it updates the properties of Brain Worms based on the combat results. It's also used for the free "Guest Mode" on the front end website, which allows for onchain combat even if the user doesn't own a token. Those events happen onchain, but are not recorded into the main contract. 

## BrainWormsResourceHarvesting.sol
This handles resource harvesting actions and is kind of an in between for BrainWorms.sol and the Resource Storage system. It stands on its own so that game play updates can happen without messing with the storage of resources itself.

## BrainWormsResourceStorage.sol
This manages the storage of resources collected by Brain Worms.

## BrainWormsThumbnailGenerator.sol
The generative onchain SVG code for the thumbnails that show up on OpensSea and similar NFT websites. This is also displayed in the Cartridges on the Brain Worm Simulation System.

## BrainWormsTokenURI.sol
This is the workhorse that handles the tokenURI requests, combining all of the onchain JavaScript, the SVG from the thumbnail generator, the JSON object for the traits, etc. It uses Scripty.sol and EthFS for management of the onchain JavasScript.

Shoutout to [@0xthedude](https://x.com/0xthedude), [@xtremetom](https://x.com/xtremetom), [@frolic](https://x.com/frolic), [@cxkoda](https://x.com/cxkoda) and all other contributors.

https://github.com/intartnft/scripty.sol
https://github.com/holic/ethfs
