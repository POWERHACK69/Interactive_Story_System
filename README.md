An interactive Story Project based on DnD Wizard's choice with branching paths and stat-based choices.
# Interactive Story System

![image](https://github.com/user-attachments/assets/824ae954-1f49-4e34-9fb2-44c801d76dfe)

Welcome to the **Interactive Story System**! This project is a basic framework for creating interactive text-based stories using the Godot Engine. It allows players to make choices that influence the direction of the story, manage character stats, and engage with an immersive narrative.

## Features

- **Dynamic Storytelling**: Branching narratives with player choices that determine the outcome of the story.
- **Character Stats**: Track player stats like health and mana, which influence gameplay.
- **Customizable UI**: Easy-to-customize interface for displaying narrative text, images, and choices.
- **Death and Mana Systems**: Unique handling of player health and mana, including special events like death.

![Screenshot 2024-08-07 201455](https://github.com/user-attachments/assets/40931e9d-d8f1-4709-8763-ad59885b4ae9)


## How It Works

The system uses a combination of GDScript and JSON to manage and display the story's content.

- **GDScript**: Handles the game logic, including processing player choices, updating stats, and managing the story flow.
- **JSON**: Stores the narrative content, including titles, text, images, and choices.

### Core Script (`ContentContainer.gd`)

The main script is responsible for the following:

- Initializing the story and loading the content from a JSON file.
- Processing player choices and updating the story based on player decisions.
- Managing character stats, such as health and mana, and determining the consequences of those stats on gameplay.
- Handling special events, such as the player's death, and transitioning to relevant story segments.

### JSON Structure

The narrative content is stored in a structured JSON format. Each story segment contains:

- `title`: The title of the current page.
- `picture`: (Optional) The path to an image displayed with the text.
- `narr_text`: The narrative text shown to the player.
- `choices`: A list of choices the player can make, each leading to a different story segment.

Example:
```json
{
	 "002_proceed_cautiously": {
		"title": "Chapter 2: Darkwood Grove",
		"picture": "res://assets/art/Forest_Path.jpg",
		"narr_text": "You proceed cautiously through the grove...",
		"choices": {
			"1": {
				"text": "Turn around quickly",
				"output": "002_turn_around"
			},
			"2": {
				"text": "Draw your weapon",
				"output": "002_draw_weapon"
			},
			"3": {
				"text": "Start conjuring a fireball spell \n(-20 mana)",
				"requirement": {"mana": 20},
				"buffs":{"mana": -20, "health": 1},
				"output": "002_draw_weapon",
				"failed_output": "002_ignore_creature"
			}
		}
	}
}
```


Getting Started

To run the project, you'll need to have Godot Engine installed.

    Clone this repository
    Open the project in Godot Engine 4.
    Explore the ContentContainer.gd script and Sample_Story.json to customize the narrative.

How to Customize

    Adding New Story Segments: Edit the JSON file to add new pages, titles, text, images, and choices.
    Customizing Stats: Modify the game_screen.gd to include additional stats.
    Extending Functionality: Implement more complex game mechanics such as inventory systems, battle mechanics, or time-based events.

Contributing

Feel free to fork the repository and submit pull requests if you'd like to contribute. Whether it's bug fixes, new features, or improvements, all contributions are welcome!

This project is licensed under the MIT License. See the LICENSE file for more details.
