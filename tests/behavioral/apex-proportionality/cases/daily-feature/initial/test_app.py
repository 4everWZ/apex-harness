import unittest
from app import handle
class AppTests(unittest.TestCase):
    def test_live(self):
        self.assertEqual(handle("GET", "/health/live", lambda: False), (200, {"alive": True}))
    def test_missing(self):
        self.assertEqual(handle("POST", "/missing", lambda: True)[0], 404)
