poise_effect <- inherit("scripts/skills/skill", {
	m = {
		Count = 1;
		Max = 3;
		Refresh = 1;
	}

	function create() {
		m.ID					= "effects.poise";
		m.Name					= "Poise";
		m.Icon					= "ui/perks/perk_19.png";
		m.IconMini				= "perk_19_mini";
		m.Overlay				= "perk_19";
		m.Type					= Const.SkillType.StatusEffect;
		m.IsActive				= false;
		m.IsStacking			= false;
		m.IsRemovedAfterBattle	= true;
	}

	function getDescription() {
		return "This character is prepared to dodge [color=" + Const.UI.Color.PositiveValue + "]" + m.Count + "[/color] more blows and will accumulate " + m.Refresh + " poise per turn, up to a max of " + m.Max + ".";
	}

	function getTooltip() {
		return [
					{ id = 1, type = "title", text = getName() }
					{ id = 2, type = "description", text = getDescription() }
				];
	}

	function getName() {
		if (m.Count <= 1)
			return m.Name;
		else
			return m.Name + " (x" + m.Count + ")";
	}

	function onAdded() {
	  m.Max = Math.max(1, 1 + Math.floor(getContainer().getActor().getCurrentProperties().MeleeDefense / 10));
		m.Count = m.Max;
	}

	function onRefresh() {
		getContainer().update();
	}

	function onUpdate(_properties) {
	}

	function useToDodge() {
	  --m.Count;
	  if (m.Count == 0) {
			m.Icon = "ui/perks/perk_19_sw.png";
		}
	}

	function onRoundEnd() {
	  if (m.Count < m.Max) {
			++m.Count;
			m.Icon = "ui/perks/perk_19.png";
		}
		// if (--m.TurnsLeft <= 0)
		// 	removeSelf();
	}
});
