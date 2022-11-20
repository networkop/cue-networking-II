from __future__ import absolute_import, division, print_function

__metaclass__ = type

from ansible.errors import AnsibleError
from ansible.utils.display import Display
from jinja2.runtime import Undefined


def arista_avd_defined(value, test_value=None, var_type=None, fail_action=None, var_name=None, run_tests=False):
    display = Display()
    if isinstance(value, Undefined) or value is None:
        # Invalid value - return false
        if str(fail_action).lower() == "warning":
            display._warns = {}
            if var_name is not None:
                display.warning(f"{var_name} was expected but not set. Output may be incorrect or incomplete!")
            else:
                display.warning("A variable was expected but not set. Output may be incorrect or incomplete!")
        elif str(fail_action).lower() == "error":
            if var_name is not None:
                raise AnsibleError(f"{var_name} was expected but not set!")
            else:
                raise AnsibleError("A variable was expected but not set!")
        if run_tests:
            return False, display._warns
        return False

    elif test_value is not None and value != test_value:
        # Valid value but not matching the optional argument
        if str(fail_action).lower() == "warning":
            display._warns = {}
            if var_name is not None:
                display.warning(f"{var_name} was set to {value} but we expected {test_value}. Output may be incorrect or incomplete!")
            else:
                display.warning(f"A variable was set to {value} but we expected {test_value}. Output may be incorrect or incomplete!")
        elif str(fail_action).lower() == "error":
            if var_name is not None:
                raise AnsibleError(f"{var_name} was set to {value} but we expected {test_value}!")
            else:
                raise AnsibleError(f"A variable was set to {value} but we expected {test_value}!")
        if run_tests:
            return False, display._warns
        return False
    elif str(var_type).lower() in ["float", "int", "str", "list", "dict", "tuple", "bool"] and str(var_type).lower() != type(value).__name__:
        # Invalid class - return false
        if str(fail_action).lower() == "warning":
            display._warns = {}
            if var_name is not None:
                display.warning(f"{var_name} was a {type(value).__name__} but we expected a {str(var_type).lower()}. Output may be incorrect or incomplete!")
            else:
                display.warning(f"A variable was a {type(value).__name__} but we expected a {str(var_type).lower()}. Output may be incorrect or incomplete!")
        elif str(fail_action).lower() == "error":
            if var_name is not None:
                raise AnsibleError(f"{var_name} was a {type(value).__name__} but we expected a {str(var_type).lower()}!")
            else:
                raise AnsibleError(f"A variable was a {type(value).__name__} but we expected a {str(var_type).lower()}!")
        if run_tests:
            return False, display._warns
        return False
    else:
        # Valid value and is matching optional argument if provided - return true
        return True
