import unittest
from summary import render
class SummaryTests(unittest.TestCase):
    def test_render(self):
        self.assertEqual(render({"title": "Hello", "unused": 3}, "Body"), "# Hello\n\nBody")
