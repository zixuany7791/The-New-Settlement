extends Node

var open_lumberyard: Panel = null  # Now specifically using Panel

func open_lumberyard_ui(new_ui: Panel):
	
	if open_lumberyard and open_lumberyard != new_ui:
		open_lumberyard.hide()  # Hide the currently opened menu
	print(new_ui)	
	open_lumberyard = new_ui  # Assign the new UI panel
	new_ui.show()  # Show the new UI panel
