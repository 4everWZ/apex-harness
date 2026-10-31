import unittest
from cards import display_ids
class CardTests(unittest.TestCase):
    def test_display_order(self):
        self.assertEqual(display_ids([{"id": "b"}, {"id": "a"}]), ["b", "a"])
