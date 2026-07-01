# Unit Tests for tf-atom-route-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
#
# NOTE: assertions target plan-KNOWN values only (tf-label id string,
# input pass-throughs, resource counts). Computed arn/id attributes are
# unknown under a mock provider and are NOT asserted here.

mock_provider "aws" {}

variables {
  # tf-label identity inputs
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # Module-required input
  route_table_id = "rtb-0123456789abcdef0"

  # A concrete route target so the plan is complete
  gateway_id             = "igw-0123456789abcdef0"
  destination_cidr_block = "0.0.0.0/0"
}

# ---------------------------------------------------------------------------
# Test: module creates the route when enabled (default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = length(aws_route.this) == 1
    error_message = "Expected exactly one aws_route to be planned when enabled."
  }

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true by default."
  }

  assert {
    condition     = output.route_table_id == "rtb-0123456789abcdef0"
    error_message = "route_table_id output should pass through the provided route table id."
  }

  assert {
    condition     = output.destination_cidr_block == "0.0.0.0/0"
    error_message = "destination_cidr_block output should pass through the provided CIDR."
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = length(aws_route.this) == 0
    error_message = "No aws_route should be planned when enabled = false."
  }

  assert {
    condition     = output.route_table_id == null
    error_message = "route_table_id output should be null when the module is disabled."
  }
}
