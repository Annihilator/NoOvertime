class NoOvertimeDrawMessage extends LocalMessage;

var(Messages) localized string Draw;

static function string GetString(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
	return default.Draw;
}

static simulated function ClientReceive(PlayerController P, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
}

defaultproperties
{
	Draw="MATCH DRAW"
	Lifetime=5
	PosY=0.500000
	DrawColor=(B=10,R=0)
	FontSize=1
}
