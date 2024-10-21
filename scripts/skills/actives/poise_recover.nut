poise_recover <- inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		m.ID = "actives.recover";
		m.Name = "Recover";
		m.Description = "Take a deep breath and rest for a turn in order to recover your strength.";
		m.Icon = "ui/perks/perk_54_active.png";
		m.IconDisabled = "ui/perks/perk_54_active_sw.png";
		m.Overlay = "perk_54_active";
		m.SoundOnUse = [];
		m.Type = Const.SkillType.Active;
		m.Order = Const.SkillOrder.Any;
		m.IsSerialized = false;
		m.IsActive = true;
		m.IsTargeted = false;
		m.IsStacking = false;
		m.IsAttack = false;
		m.ActionPointCost = 9;
		m.FatigueCost = 0;
		m.MinRange = 0;
		m.MaxRange = 0;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = getName()
			},
			{
				id = 2,
				type = "description",
				text = getDescription()
			},
			{
				id = 3,
				type = "text",
				text = getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Current Fatigue is reduced by half"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Poise is regenerated to 3/4 of it's original value."
			}
		];
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		if (_user.getSkills().hasSkill("effects.poise")) {
			local poise = _targetEntity.getSkills().getSkillByID("effects.poise");
			poise.m.Count = Math.floor(poise.m.Max * 0.75);
		}
		_user.setFatigue(_user.getFatigue() / 2);

		if (!_user.isHiddenToPlayer())
		{
			_user.playSound(Const.Sound.ActorEvent.Fatigue, Const.Sound.Volume.Actor * _user.getSoundVolume(Const.Sound.ActorEvent.Fatigue));
		}

		return true;
	}

});

