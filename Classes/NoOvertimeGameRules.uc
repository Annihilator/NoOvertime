class NoOvertimeGameRules extends GameRules;

var NoOvertime NOMut;

function bool CheckEndGame(PlayerReplicationInfo Winner, string Reason)
{
	if(Level.Game.bTeamGame)
		if(Level.Game.GameReplicationInfo.Teams[0].Score == Level.Game.GameReplicationInfo.Teams[1].Score)
		{
			NOMut.NOEndGame(none, false);
			return false;
		}
	if(NextGameRules != none)
		return NextGameRules.CheckEndGame(Winner, Reason);
	return true;
}
