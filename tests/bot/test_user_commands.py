from bot.trollabot.commands import Permission
from bot.trollabot.commands.base.response import RespondWithResponse
from bot.trollabot.commands.user_commands import parse_user_command_body, TextNode, VarNode

def test_user_commands(db_api, test_stream):
    res1 = test_stream.send("!housed", Permission.ANYONE)
    assert res1 == None

    res2 = test_stream.send("!addc housed has been housed ${housed} times", Permission.MOD)
    cmd = db_api.user_commands.get_user_command(test_stream.channel, "housed")
    assert res2 == RespondWithResponse(test_stream.channel, msg='housed: has been housed ${housed} times')
    assert cmd.body == "has been housed ${housed} times"

    res3 = test_stream.send("!housed", Permission.ANYONE)
    assert res3 == RespondWithResponse(test_stream.channel, "has been housed 1 times")

def test_user_commands_body_parsing():
    input_string = "Hello ${user}, your balance is ${balance} dollars."
    parsed_nodes = parse_user_command_body(input_string)
    assert parsed_nodes == [TextNode("Hello "), VarNode("user"), TextNode(", your balance is "), VarNode("balance"),
                            TextNode(" dollars.")]
