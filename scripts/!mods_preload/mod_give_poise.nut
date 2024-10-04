// Give all tactical actors the poise effect when they are initialized.
::mods_hookExactClass("entity/tactical/actor", function(o) {
	while(!("onInit" in o)) o = o[o.SuperName];

	local original_onInit = o.onInit;
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
