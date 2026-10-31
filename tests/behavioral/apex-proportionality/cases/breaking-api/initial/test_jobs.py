import unittest

from client import parse_job
from transport import encode_job


class JobTests(unittest.TestCase):
    def test_encode(self):
        self.assertEqual(
            encode_job({"id": "j1", "status": "pending"}),
            {"id": "j1", "status": "pending"},
        )

    def test_parse(self):
        self.assertEqual(parse_job({"id": "j1", "status": "pending"}), ("j1", "pending"))
