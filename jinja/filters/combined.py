from __future__ import absolute_import, division, print_function

__metaclass__ = type

import re

import os
from jinja2.runtime import Undefined

def arista_avd_default(primary_value, *default_values):
    if isinstance(primary_value, Undefined) or primary_value is None:
        # Invalid value - try defaults
        if len(default_values) >= 1:
            # Return the result of another loop
            return arista_avd_default(default_values[0], *default_values[1:])
        else:
            # Return None
            return
    else:
        # Return the valid value
        return primary_value


def convert(text):
    return int(text) if text.isdigit() else text.lower()


def arista_avd_natural_sort(iterable, sort_key=None):
    if isinstance(iterable, Undefined) or iterable is None:
        return []

    def alphanum_key(key):
        if sort_key is not None and isinstance(key, dict):
            return [convert(c) for c in re.split("([0-9]+)", str(key.get(sort_key, key)))]
        else:
            return [convert(c) for c in re.split("([0-9]+)", str(key))]

    return sorted(iterable, key=alphanum_key)


def arista_avd_convert_dicts(dictionary, primary_key="name", secondary_key=None):
    if not isinstance(dictionary, (dict, list)) or os.environ.get("AVD_DISABLE_CONVERT_DICTS"):
        # Not a dictionary/list, return the original
        return dictionary
    elif isinstance(dictionary, list):
        output = []
        for element in dictionary:
            if not isinstance(element, dict):
                item = {}
                item.update({primary_key: element})
                output.append(item)
            elif primary_key not in element and secondary_key is not None:
                # if element of nested dictionary is a dictionary but primary key is missing, insert primary and secondary keys.
                for key in element:
                    output.append(
                        {
                            primary_key: key,
                            secondary_key: element[key],
                        }
                    )
            else:
                output.append(element)
        return output
    else:
        output = []
        for key in dictionary:
            if secondary_key is not None:
                # Add secondary key for the values if secondary key is provided
                item = {}
                item.update({primary_key: key})
                item.update({secondary_key: dictionary[key]})
                output.append(item)
            else:
                if not isinstance(dictionary[key], dict):
                    # Not a nested dictionary
                    output.append({primary_key: key})
                else:
                    # Nested dictionary
                    item = dictionary[key].copy()
                    item.update({primary_key: key})
                    output.append(item)
        return output
