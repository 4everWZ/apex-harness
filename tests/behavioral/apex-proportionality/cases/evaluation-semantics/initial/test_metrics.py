import unittest
from metrics import macro_f1
class MetricTests(unittest.TestCase):
    def test_perfect(self):
        self.assertEqual(macro_f1(["a", "b"], ["a", "b"], ["a", "b"]), 1.0)
