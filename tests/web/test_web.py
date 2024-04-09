
def test_home_page(web_client, db_api):
    """Test the home page route."""
    response = web_client.get('/')
    assert response.status_code == 200
    assert b"Welcome" in response.data

def test_score_page(web_client, db_api, web_test_stream):
    """Test the score page route."""
    db_api.scores.upsert_score_all(web_test_stream, "joe", 69, "jim", 42)
    response = web_client.get(f'/score?channel_name={web_test_stream.value}')
    assert response.status_code == 200
    assert b"joe 69 - 42 jim" in response.data
