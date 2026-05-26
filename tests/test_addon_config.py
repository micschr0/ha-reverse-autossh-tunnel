"""Validate autossh/config.yaml against the Home Assistant add-on schema.

The schema is vendored from frenck/action-addon-linter (the canonical
community validator, maintained by HA's lead developer). We validate
config.yaml only; build.yaml is validated by home-assistant/builder
during the Build job and supports digest pins that the vendored schema
does not.

Renovate updates the vendored schema via the customManager pin marker
at the top of tests/schemas/config.schema.json's commit history.
"""

import json
import sys
from pathlib import Path

import yaml
from jsonschema import Draft7Validator

REPO = Path(__file__).resolve().parent.parent
CONFIG = REPO / "autossh" / "config.yaml"
SCHEMA = REPO / "tests" / "schemas" / "config.schema.json"


def main() -> int:
    with CONFIG.open() as fp:
        config = yaml.safe_load(fp)
    with SCHEMA.open() as fp:
        schema = json.load(fp)

    validator = Draft7Validator(schema)
    errors = sorted(validator.iter_errors(config), key=lambda e: list(e.absolute_path))
    if not errors:
        print(f"OK: {CONFIG.relative_to(REPO)} matches schema")
        return 0

    for err in errors:
        path = ".".join(str(p) for p in err.absolute_path) or "<root>"
        print(f"ERROR at {path}: {err.message}", file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
