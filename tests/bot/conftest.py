import pytest

from app.trollabot.channelname import ChannelName
from .helpers import TestStream

stream_count: int = 0

def next_stream_name(prefix: str = "test_stream") -> ChannelName:
    global stream_count
    res = f"{prefix}_{stream_count}"
    stream_count = stream_count + 1
    return ChannelName(res)

@pytest.fixture(scope="function")
def test_stream(db_api) -> TestStream:
    stream: TestStream = TestStream(channel=next_stream_name(), db_api=db_api)
    stream.join()
    yield stream
