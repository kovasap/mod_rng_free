// Give all tactical actors the poise effect when the tactical board is spawned.
::mods_hookExactClass("entity/tactical/tactical_entity_manager", function(o) {
	local original_spawn = o.spawn;
	o.spawn = function(_properties) {
		original_spawn(_properties);
		foreach( i in this.getAllInstancesAsArray() ) {
			i.getSkills().add(new("scripts/skills/effects/poise"));
		}
	}
});
