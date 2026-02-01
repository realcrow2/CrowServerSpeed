# ServerSpeed - FiveM Vehicle Speed Limiter

A FiveM resource that limits vehicle speeds based on ACE permissions, with no restrictions for aircraft.

## Features

- **Default Speed**: 180 mph for all players (no permissions required)
- **Discord Permission**: 250 mph for players with `serverspeed.discord` ACE permission
- **Owner Permission**: 700 mph for players with `serverspeed.owner` ACE permission
- **Aircraft Exemption**: No speed restrictions for airplanes or helicopters

## Installation

1. Place the `serverspeed` folder in your server's `resources` directory
2. Add `ensure serverspeed` to your `server.cfg`

## ACE Permissions Setup

To grant players different speed limits, add these to your `server.cfg`:

```
# For Discord role (250 mph)
add_ace group.discord "serverspeed.discord" allow

# For Owner role (700 mph)
add_ace group.owner "serverspeed.owner" allow
```

Or for individual players:

```
# Individual player Discord permission
add_ace identifier.steam:YOUR_STEAM_ID "serverspeed.discord" allow

# Individual player Owner permission
add_ace identifier.steam:YOUR_STEAM_ID "serverspeed.owner" allow
```

## How It Works

- The server checks each player's ACE permissions and assigns their speed limit
- The client-side script enforces the speed limit on ground vehicles only
- Aircraft (helicopters and planes) are completely exempt from speed restrictions
- Speed limits are checked and updated when players connect

## Notes

- Speed limits are in miles per hour (mph)
- The script automatically converts to meters per second for GTA V's internal system
- Only ground vehicles are affected - all aircraft can go unlimited speed
