from setuptools import setup, find_packages

#setup tool makes it easy to package and distribute the project.
#it defines package name, version, description, dependencies, and entry points for command-line scripts.
#the packes will be found in the termhelper directory, and the .env file will be included in the package data just to make it easy for users.
#if we add another directory with code, we can add it to the packages list in the setup function.

setup(
    name="termhelper",
    version="0.1.0",
    description="An AI language helper for the terminal powered by Ollama",
    packages=find_packages(),
    package_data={
        "termhelper": [".env"],
    },
    include_package_data=True,
    install_requires=[
        "requests==2.31.0",
        "charset-normalizer==3.3.2",
        "idna==3.11",
        "urllib3==2.1.0",
        "certifi==2026.1.4",
        "python-dotenv==1.0.0",
    ],
    entry_points={
        "console_scripts": [
            "termhelp=termhelper.cli:main",
        ],
    },
)
