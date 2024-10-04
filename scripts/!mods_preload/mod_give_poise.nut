// Give all tactical actors the poise effect when they are initialized.
::mods_hookExactClass("entity/tactical/actor", function(o) {
	local original_onInit;
	if ("onInit" in o) {
		original_onInit = o.onInit;
	} else {
		original_onInit = function(){};
	}
	o.onInit = function() {
		original_onInit();
		this.m.Skills.add(new("scripts/skills/effects/poise"));
	}
});
// Give all tactical actors the poise effect when the tactical board is spawned.
/*
::mods_hookExactClass("entity/tactical/tactical_entity_manager", function(o) {
	local original_spawn = o.spawn;
	o.spawn = function(_properties) {
		original_spawn(_properties);
		foreach( i in this.getAllInstancesAsArray() ) {
			i.getSkills().add(new("scripts/skills/effects/poise"));
		}
	}
});
*/
