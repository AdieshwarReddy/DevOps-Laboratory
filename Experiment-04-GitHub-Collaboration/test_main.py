
# Experiment 4: Unit Tests

import unittest
from main import greet


class TestGreeting(unittest.TestCase):

    def test_normal_name(self):
        self.assertEqual(
            greet("Student"),
            "Hello, Student! Welcome to DevOps."
        )

    def test_whitespace_handling(self):
        self.assertEqual(
            greet("  Developer  "),
            "Hello, Developer! Welcome to DevOps."
        )

    def test_empty_name(self):
        self.assertEqual(
            greet("   "),
            "Error: Name cannot be empty."
        )


if __name__ == "__main__":
    unittest.main()
