::mods_hookExactClass("skills/actives/recover_skill", function(o) {
	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Current Fatigue is reduced by half, and poise is regenerated to 3/4 of it's original value."
			}
		];
		return ret;
	}

	local original_onUse = o.onUse;
	function onUse( _user, _targetTile )
	{
		if (_user.getSkills().hasSkill("effects.poise")) {
			local poise = _targetEntity.getSkills().getSkillByID("effects.poise");
			poise.m.Count = Math.floor(poise.m.Max * 0.75);
			}
		return original_onUse(_user, _targetTile);
	}
});
