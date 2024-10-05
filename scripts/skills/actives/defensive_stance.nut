defensive_stance <- inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		m.ID = "actives.defensive_stance";
		m.Name = "Defensive Stance";
		m.Description = "Prepare yourself to dodge more blows!";
		m.Icon = "ui/active_176.png";
		m.IconDisabled = "ui/active_176_sw.png";
		m.Overlay = "active_176";
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
				text = "Gain 3 Poise"
			}
		];
		return ret;
	}

	function onUse( _user, _targetTile )
	{
   		 _user.getSkillByID("effects.poise").m.Count += 3;

		if (!_user.isHiddenToPlayer())
		{
			_user.playSound(Const.Sound.ActorEvent.Fatigue, Const.Sound.Volume.Actor * _user.getSoundVolume(Const.Sound.ActorEvent.Fatigue));
		}

		return true;
	}

});

