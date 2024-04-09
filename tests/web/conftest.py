import pytest

from app.trollabot.channelname import ChannelName
from tests.web.helpers import test_user
from web import create_app

@pytest.fixture
def web_client(db_container):
    conn_str = db_container.get_connection_url()
    app = create_app(conn_str, {'TESTING': True})
    with app.test_client() as client:
        yield client

stream_count: int = 0

def next_stream_name(prefix: str = "test_stream") -> ChannelName:
    global stream_count
    res = f"{prefix}_{stream_count}"
    stream_count = stream_count + 1
    return ChannelName(res)

@pytest.fixture(scope="function")
def web_test_stream(db_api) -> ChannelName:
    stream = next_stream_name()
    db_api.streams.insert_stream(stream, test_user)
    yield stream
