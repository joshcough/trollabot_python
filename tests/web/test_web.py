from app.trollabot.channelname import ChannelName

test_stream: ChannelName = ChannelName("web_test_stream")
test_user: str = "web_test_stream"

def test_home_page(web_client, db_api, clean_db):
    """Test the home page route."""
    db_api.streams.insert_stream(test_stream, test_user)
    db_api.scores.upsert_score_all(test_stream, "joe", 69, "jim", 42)
    response = web_client.get('/?channel_name=web_test_stream')
    assert response.status_code == 200
    assert b"joe 69 - 42 jim" in response.data
