
# DevOps Laboratory - Experiment 4
# GitHub Collaboration and Code Reviews

def greet(name):
    """Return a welcome message for the given name."""

    clean_name = name.strip()

    if not clean_name:
        return "Error: Name cannot be empty."

    return f"Hello, {clean_name}! Welcome to DevOps."


def main():
    print("====================================")
    print("        DEVOPS LABORATORY")
    print("====================================")

    print("Experiment 4: GitHub Collaboration")
    print(greet("Student"))
    print(greet("  Developer  "))

    print("====================================")
    print("Application executed successfully.")
    print("====================================")


if __name__ == "__main__":
    main()
