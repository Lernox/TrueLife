ELITE = {}

ELITE.StaffListRanks = { "superadmin", "admin", "Fondateur", "Co-Fondateur" } -- What ULX ranks to show on the "Staff Online" list.
ELITE.ShowFoodTab = true -- Make sure Hungermod is enabled, otherwise this will give you errors!

ELITE.VIPJobCheckbox = true -- Whether or not to show the "Show VIP Jobs" checkbox on the jobs tab. (The checkbox is based on the jobs that have a customCheck)

ELITE.OpenWebsiteInOverlay = false -- If this is true, the website will open in Steam overlay, if false, it will open in the F4 menu.

ELITE.WebsiteURL = "http://destiny-server.com" -- Website that opens when clicking the "Website" button, make sure you include "http://"!

timer.Simple( 1, function() -- Don't screw with this timer, but you may change the tables inside.
    ELITE.AccessToCPCmds = { TEAM_POLICE, TEAM_CHIEF }
    
    ELITE.AccessToMayorCmds = { TEAM_MAYOR }
end)

-- Adding Commands Buttons (Advanced)
/*
MenuAddMButton - Adds button to first section
MenuAddRPButton - Adds button to second section
MenuAddCPButton - Adds button to exclusive CP section
MenuAddMayorButton - Adds button to exclusive mayor section

Format goes as shown:
MenuAddMButton( [Title of button], [Function of button] )

===============================================================================

If you would just like the button to run a command (i.e. /buyhealth):
For the [Function of button] argument, use:

RunConsoleCommand( "say", [Command] )

===============================================================================

If you would like to open a window that takes the players input (number or reason) when clicked:
For the [Function of button] argument, use:

function() OpenTextBox( [Title of dialog box], [Subtext of dialog box], [Command] ) end

===============================================================================

If you would like to open a window with a drop down of players when clicked:
For the [Function of button] argument, use:

function() OpenPlyBox( [Title of dialog box], [Subheading over dropdown], [Command] ) end

===============================================================================

If you would like to open a window with a drop down of players and an input box (reason or number) when clicked:
For the [Function of button] argument, use:

function() OpenPlyReasonBox( [Title of dialog box], [Subheading over dropdown], [Subheading over input box], [Command] ) end

===============================================================================

*/

MONEYCMD_BUTTONS = {}
RPCMD_BUTTONS = {}
CPCMD_BUTTONS = {}
MAYORCMD_BUTTONS = {}
OTHERCMD_BUTTONS = {}

local function AddSidebarButton( n, f )
    table.insert(WEB_BUTTONS, { Title = n, Func = f } )
end
 
local function MenuAddMButton( n, f )
    table.insert(MONEYCMD_BUTTONS, { NAME = n, FUNC = f } )
end

local function MenuAddRPButton( n, f )
    table.insert(RPCMD_BUTTONS, { NAME = n, FUNC = f } )
end

local function MenuAddCPButton( n, f )
    table.insert(CPCMD_BUTTONS, { NAME = n, FUNC = f } )
end

local function MenuAddMayorButton( n, f )
    table.insert(MAYORCMD_BUTTONS, { NAME = n, FUNC = f } )
end

local function MenuAddOtherButton( n, f )
    table.insert(OTHERCMD_BUTTONS, { NAME = n, FUNC = f } )
end

--First Section
MenuAddMButton( "Donner de L'argent au joueur que vous regardez", function() OpenTextBox( "Donnez De l'argent", "Combien Voulez Vous Donnez?", "/give" ) end )
MenuAddMButton( "Faire Tomber de L'argent", function() OpenTextBox( "Faire Tomber De L'argent", "Combien D'argent Voulez Vous Laissez Tombez Sur Le Sol?", "/moneydrop" ) end )
--MenuAddMButton( "Buy Health", function() RunConsoleCommand( "say", "/buyhealth" ) end )

--Second Section
MenuAddRPButton( "Allez AFK", function() RunConsoleCommand( "say", "/afk" ) end )
MenuAddRPButton( "Faire Dodo/Se Reveiller", function() RunConsoleCommand( "say", "/sleep" ) end )
MenuAddRPButton( "Lacher Votre Arme", function() RunConsoleCommand( "say", "/drop" ) end )
MenuAddRPButton( "Demander Une License", function() RunConsoleCommand( "say", "/requestlicense" ) end )
MenuAddRPButton( "Renvoyer Un Joueur", function() OpenPlyReasonBox( "Renvoyez Un Joueur", "Qui Voulez Vous Renvoyez?", "Pourquoi Cette Personne Devrais Perdre Son Emploi?", "/demote" ) end )
MenuAddRPButton( "Vendre Toute Vos Portes", function() RunConsoleCommand( "say", "/unownalldoors" ) end )

MenuAddCPButton( "Rechercher Un joueur", function() OpenPlyReasonBox( "Rechercher Un Joueur", "Qui Voulez Vous Rechercher", "Quel Est La Raison?", "/wanted" ) end )
MenuAddCPButton( "Arretez De Rechercher un joueur", function() OpenPlyBox( "Arretez De Rechercher Un Joueur", "Qui Voulez Vous  Arretez De Rechercher?", "/unwanted" ) end )
MenuAddCPButton( "Obtenir Un Mandat Contre Un Joueur", function() OpenPlyReasonBox( "Obtenir Un Mandat", "Entrez Le Nom Du Joueur Sur Lequel Vous Voulez Un Mandat.", "Quel Est La Raison Du Mandat", "/warrant" ) end )

MenuAddMayorButton( "Rechercher Un joueur", function() OpenPlyReasonBox( "Rechercher Un Joueur", "Qui Voulez Vous Rechercher", "Quel Est La Raison?", "/wanted" ) end )
MenuAddMayorButton( "Arretez De Rechercher un joueur", function() OpenPlyBox( "Arretez De Rechercher Un Joueur", "Qui Voulez Vous  Arretez De Rechercher?", "/unwanted" ) end )
MenuAddMayorButton( "Obtenir Un Mandat Contre Un Joueur", function() OpenPlyReasonBox( "Obtenir Un Mandat", "Entrez Le Nom Du Joueur Sur Lequel Vous Voulez Un Mandat.", "Quel Est La Raison Du Mandat", "/warrant" ) end )
MenuAddMayorButton( "Faire Une Dictature", function() RunConsoleCommand( "say", "/lockdown" ) end )
MenuAddMayorButton( "Arreter La Dictature", function() RunConsoleCommand( "say", "/unlockdown" ) end )
MenuAddMayorButton( "Placer Le Tableau Des Lois", function() RunConsoleCommand( "say", "/placelaws" ) end )
MenuAddMayorButton( "Ajouter Une Loi", function() OpenTextBox( "Ajouter Une loi", "Quel loi Voulez Vous Ajouter?", "/addlaw" ) end )

MenuAddOtherButton( "Dire. Ce Serveur Est De La merde", function() RunConsoleCommand( "say", "Ce Serveur Est Juste Trop Cool!!. PS:Je suis YAOI" ) end )
