#!/usr/bin/env python

import os
import sys
import argparse
import subprocess


try:
    import json
except ImportError:
    import simplejson as json

path_to_terraform = '~/task-branches/terraform/stage/'

def get_output(text):
    outputVar = subprocess.check_output('cd ' + path_to_terraform + ' && terraform output ' + text, shell=True)
    outputVar = outputVar.decode("utf-8")
    return outputVar.strip('\n')


class ExampleInventory(object):

    def __init__(self):
        self.inventory = {}
        self.read_cli_args()

        # Called with `--list`.
        if self.args.list:
            self.inventory = self.example_inventory()
        # Called with `--host [hostname]`.
        elif self.args.host:
            # Not implemented, since we return _meta info `--list`.
            self.inventory = self.empty_inventory()
        # If no groups or vars are present, return an empty inventory.
        else:
            self.inventory = self.empty_inventory()

        print (json.dumps(self.inventory))

    # Example inventory for testing.
    def example_inventory(self):
        app_external_ip = get_output('app_external_ip')
        db_external_ip = get_output('db_external_ip')
        db_internal_ip = get_output('db_internal_ip')
        return {
            "app": {
                "hosts": ["appserver"],
                "vars": {
                    "ansible_host": app_external_ip
                    }
                },
            "db": {
                "hosts": ["dbserver"],
                "vars": {
                    "ansible_host": db_external_ip
                    }
                },
            "_meta": {
                "hostvars": {
                    "appserver": {
                        "db_host": db_internal_ip
                    }
                }
            }
}

    # Empty inventory for testing.
    def empty_inventory(self):
        return {'_meta': {'hostvars': {}}}

    # Read the command line args passed to the script.
    def read_cli_args(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--list', action = 'store_true')
        parser.add_argument('--host', action = 'store')
        self.args = parser.parse_args()

# Get the inventory.
ExampleInventory()